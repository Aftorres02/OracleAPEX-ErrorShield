# Setting Up a Community Demo

A walkthrough for populating a throwaway schema with realistic, clearly-fake
data so the admin app's reports and dashboards have something to show — for
a conference talk, a recorded demo, or letting someone poke around without
wiring up their own app first. Never run this against a schema with real
incidents or logs in it.

---

## Step 1 — Create a dedicated schema

Don't reuse a real install. Create a new, disposable schema exactly for
this — this is a full owner install (its own copy of every table), never a
consumer schema pointing at a real install via synonyms: the generator does
direct `insert`/`delete` on the core tables, which a consumer's select-only
grants (see [`INSTALL.md`](INSTALL.md#onboarding-a-consumer-schema)) don't
allow.

Edit the `define` values at the top of
[`scripts/admin/create_demo_schema.sql`](../scripts/admin/create_demo_schema.sql)
(schema name, password, tablespace — Autonomous Database usually uses
`DATA`/`TEMP`, not `USERS`/`TEMP`), then run the whole script in one pass,
connected as an admin user:

```bash
sql -S admin/<admin_password>@<host>:<port>/<service> \
  @scripts/admin/create_demo_schema.sql
```

See [`INSTALL.md`](INSTALL.md#prerequisites-and-privileges) for exactly
which privileges this grants and why.

## Step 2 — Install ErrorShield

Connected as that new schema:

```bash
cd release
sql <connection-as-owner-schema> @_release.sql
```

## Step 3 — Generate the demo data

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

---

## What this does not cover

Three pages in the admin app can't be populated by a script:

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

> **"APEX Automations" (page 1600)** reads APEX's own automation dictionary
> views (`apex_appl_automations`, `apex_automation_log`). Populating it
> means configuring a real Automation in APEX Builder (Shared Components →
> Automations) on some app — there's no supported way to script that from
> SQL, so this is a manual, optional step if you want that page populated
> too.

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
