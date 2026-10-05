# Setting Up a Community Demo

A walkthrough for populating a throwaway schema with realistic, clearly-fake
data so the admin app's reports and dashboards have something to show — for
a conference talk, a recorded demo, or letting someone poke around without
wiring up their own app first. Never run this against a schema with real
incidents or logs in it.

---

## Step 1 — Create a dedicated schema and workspace

Don't reuse a real install. Create a new, disposable schema exactly for
this — this is a full owner install (its own copy of every table, in its
own APEX workspace), never a consumer schema pointing at a real install via
synonyms: the generator does direct `insert`/`delete` on the core tables,
which a consumer's select-only grants (see
[`INSTALL.md`](INSTALL.md#onboarding-a-consumer-schema)) don't allow — and
even a real error raised the normal way from a consumer app still lands in
the *owner's* tables (definer's rights), never the consumer's, so a
consumer schema could never substitute for this regardless.

Edit the `define` values at the top of
[`scripts/admin/create_demo_schema.sql`](../scripts/admin/create_demo_schema.sql)
(schema name, password, tablespace — Autonomous Database usually uses
`DATA`/`TEMP`, not `USERS`/`TEMP` — and the new workspace name), then run
the whole script in one pass, connected as an admin user:

```bash
sql -S admin/<admin_password>@<host>:<port>/<service> \
  @scripts/admin/create_demo_schema.sql
```

This creates the schema (see
[`INSTALL.md`](INSTALL.md#prerequisites-and-privileges) for exactly which
privileges it grants and why) and a matching APEX workspace via
`apex_instance_admin.add_workspace`, mirroring how the real `LOGGER_USER`
install has its own dedicated workspace, never shared with a consumer
app's workspace.

> **Not verified against a live database.** The schema-creation part is
> plain, standard SQL. The workspace-creation call
> (`apex_instance_admin.add_workspace`) is the standard documented way to
> script this, but wasn't run against a real instance while writing this —
> confirm it behaves as expected on your Autonomous Database (check
> `apex_workspaces`) before relying on it for a live demo.

## Step 2 — Install ErrorShield

Connected as that new schema:

```bash
cd release
sql <connection-as-owner-schema> @_release.sql
```

## Step 3 — Import the admin app into the new workspace

`scripts/apex_install.sql` reads `env_schema_name` / `env_apex_workspace`
from `release/load_env_vars.sql`, which defaults to `LOGGER_USER` for both
— pointed at the real install, not this demo one. Either edit those two
values in `load_env_vars.sql` temporarily, or redefine them in the same
SQLcl session right before running the import:

```sql
-- from the release/ directory, same connection as Step 2
define env_schema_name = ERSH_DEMO_USER
define env_apex_workspace = ERSH_DEMO_WS
@../scripts/apex_install.sql
```

(Use whatever schema/workspace names you actually set in Step 1.)

## Step 4 — Generate the demo data

Connected as the same schema:

```bash
cd demos
sql <connection-as-owner-schema> @demo_data_generator_run.sql
```

This installs `ersh_demo_data_api` (spec + body, not part of the release)
and calls `generate_all_demo_data` with its defaults: ~3,000 background
`logger_logs` rows, ~300 incidents (each with a random 1-6 occurrences),
and three demo `DBMS_SCHEDULER` jobs run enough times to build real
execution history. Takes one to two minutes.

> **Why a package, and why scheduler jobs instead of just INSERT
> statements?** The Jobs dashboard (page 1000) and Inventory/Job
> Details/Job Executions pages (1100/1200/1300) read Oracle's own
> `ALL_SCHEDULER_*` dictionary views directly — there is no application
> table to insert fake rows into. The only way to populate them is to
> create real jobs and let them actually run, which is exactly what
> `ersh_demo_data_api.generate_scheduler_jobs` does.

**Done when:** the Incidents list (page 100), Logger Logs (page 400), and
Jobs Dashboard (page 1000) all show data instead of empty reports.

## Step 5 — Install the Automation Lab (optional)

The "APEX Automations" page (1600) reads APEX's own dictionary views
(`apex_appl_automations`, `apex_automation_log`,
`apex_automation_msg_log`) — there is no table to insert into. The
Automation Lab is a small demo app (10403) that only owns ten real
automations. Install it connected as the same owner schema, from the repo
root, passing the workspace the admin app lives in:

```bash
sql <connection-as-owner-schema> @demos/automation_lab/install_automation_lab.sql ERSH_DEMO_WS
```

It installs `ersh_demo_automation_api`, imports app 10403, and runs every
enabled automation once so the executions and messages reports have rows
right away. Run more executions at any time with:

```sql
exec ersh_demo_automation_api.execute_all;
```

> **Why the owner workspace, never a consumer one:** inside an APEX
> session those dictionary views only return the workspace the running app
> belongs to. An automation in a consumer's workspace can never show up on
> page 1600 of an admin app running in the owner's workspace.

The ten cover every combination the page can show: scheduled and on
demand, active and disabled, the four "actions initiated on" modes, the
three error-handling modes, one batch with a single failed row, and three
that fail on purpose and report themselves to ErrorShield (they also show
up on the Incidents page, component "Automations").

> **Most of these keep running.** Seven are scheduled and active (every 30
> minutes, hourly, or daily), and the nightly archive export fails every
> night on purpose. Remove the whole lab with
> `@demos/automation_lab/uninstall_automation_lab.sql ERSH_DEMO_WS`.

## Step 6 — Install the Error Lab in a consumer schema (optional)

Everything above lives in the owner schema. The Error Lab (app 10402) shows
the other half: a separate application schema that reaches ErrorShield
only through synonyms, the way a real consumer app does. Every button on
its single page fails on purpose with one specific Oracle error (division
by zero, invalid number, value too large for a column, constraint
violations, AJAX callbacks, a region that fails while rendering, a business
rule), and each one lands in the owner's Incidents page (100) or is shown
as a friendly message, depending on how ErrorShield classifies it.

Onboard the consumer first (see
[`INSTALL.md`](INSTALL.md#onboarding-a-consumer-schema)), then, connected
as the consumer schema, pass the consumer's own APEX workspace:

```bash
sql <connection-as-consumer-schema> @demos/error_lab/install_error_lab.sql <CONSUMER_WORKSPACE>
```

It creates two small tables (`elab_customers`, `elab_orders`), the
`elab_errors_api` package, seed rows, three ErrorShield registrations (two
friendly constraint messages and one business error code), and imports app
10402. The page's legend explains which buttons record an incident (red
outline) and which only show a friendly message (green outline).

> **Unlike the Automation Lab, this one belongs in a consumer workspace.**
> Errors raised there still land in the owner's tables (definer's rights),
> which is exactly what the lab demonstrates. Remove it with
> `@demos/error_lab/uninstall_error_lab.sql <CONSUMER_WORKSPACE>`; the
> incidents it already recorded stay in the owner schema as history.

---

## What this does not cover

Two pages in the admin app can't be populated by a script:

> **"Running now" (page 1400)** only ever has rows while a job is actually
> executing. Call this right before you show that specific screen, not as
> part of the bulk generation step:
>
> ```sql
> exec ersh_demo_data_api.run_slow_demo_job;
> ```
>
> It creates (if missing) and kicks off a job that sleeps for 45 seconds in
> the background — open the page within that window.

> **"Timeline" (page 1500)** has no report or region at all in the current
> app export — it's a placeholder page. There is nothing to feed it.

---

## Resetting

To remove everything the generator created — logs, incidents, occurrences,
and the three demo scheduler jobs — without touching anything else in the
schema:

```sql
exec ersh_demo_data_api.purge_demo_data;
```

Safe to run even if you never generated anything (it just deletes zero
rows and drops zero jobs). `generate_all_demo_data` also calls this first
by default (`p_reset_first_yn => 'Y'`), so re-running the whole generator
converges instead of piling up duplicate data on top of the last run.

> **The heartbeat job keeps running until you purge it.**
> `ERSH_DEMO_HEARTBEAT_JOB` repeats every 20 minutes so the Jobs dashboard
> always has at least one healthy, currently-scheduled job to show. It's
> harmless (a single `logger.log_information` call) but it is a real,
> live scheduler job — `purge_demo_data` is what stops it.

---

## Why this is safe to run on a schema that might later go real

Every row this package inserts sets `logger_logs.client_identifier` to a
fixed marker (`ERRORSHIELD_DEMO_DATA`), and every job it creates is named
`ERSH_DEMO_*`. `purge_demo_data` deletes and drops by matching exactly
those two things — it can never touch a real incident, a real log line, or
a real job, no matter what else has since been added to the schema.
