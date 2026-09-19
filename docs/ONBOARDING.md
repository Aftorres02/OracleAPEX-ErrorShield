# Onboarding

A walkthrough for a developer or team adopting ErrorShield for the first
time — what to do, in order, and which reference doc to go deeper on at
each step. This is a narrative path through the reference docs, not a
replacement for them.

---

## Step 1 — See it work before installing anything of your own

Don't start by wiring ErrorShield into a real app. Start with the
standalone Demo app (10401) — one page, four buttons, each deliberately
triggering one branch of the decision tree (internal APEX error,
constraint violation, business error, unexpected ORA error). It never
touches the real admin app (10400).

```sql
@demos/demo_errorshield_app_seed.sql
```

then import it with `scripts/apex_install_demo.sql`. See the [README
quickstart](../README.md#quickstart) for the exact commands.

**Done when:** you can click all four buttons, see each produce a
different kind of error, and find the resulting incident(s) in the admin
app.

## Step 2 — Install the owner schema for real

This is the schema that owns every ErrorShield/Logger object — tables,
views, packages, the admin app (10400). See
[`INSTALL.md`](INSTALL.md#installing-the-owner-schema) for prerequisites
(privileges, Oracle/APEX version support matrix) and the exact
`_release.sql` invocation.

**Done when:** `_release.sql` completes with no invalid `ERSH_*`/`LOGGER*`
objects (it fails the build itself if any are left invalid — nothing to
double-check manually).

## Step 3 — Onboard your first real consumer app

A "consumer" is any schema running an APEX app that wants to call
`ersh_error_handler_api` without owning any of its objects. See
[`INSTALL.md`](INSTALL.md#onboarding-a-consumer-schema) for the grant +
synonym scripts, and
[`INSTALL.md`](INSTALL.md#configuring-the-error-handling-function) for
pointing that app's Error Handling Function at
`ersh_error_handler_api.apex_error_handling` — the one integration point.

**Done when:** an unhandled error in your consumer app produces a
reference code instead of a raw ORA stack trace, and that code resolves to
an incident in the admin app.

## Step 4 — Set your environment's configuration

Before anyone relies on this in a real environment, set at minimum:

- `SUPPORT_EMAIL` — the default is deliberately non-functional (see
  [`CONFIGURATION.md`](CONFIGURATION.md#support-contact-shown-to-end-users)).
- `ENVIRONMENT` and `MASK_IN_ENVIRONMENTS` — confirm the defaults
  (`PROD`, `TEST,PROD`) match how your team names environments.

See [`CONFIGURATION.md`](CONFIGURATION.md) for every preference, its
default, and what changing it affects.

**Done when:** `SUPPORT_EMAIL` is no longer the default (post-install
configuration warns in the log until it isn't), and you've deliberately
decided — not just accepted the default — which environments mask errors.

## Step 5 — Decide on retention and scrubbing

Both are opt-in and off by default — skip this step if you don't need
either yet.

- Incident retention (`ERSH_PURGE_AFTER_DAYS`, the scheduled purge job).
- Scrubbing sensitive text out of stored error messages before they land
  in `error_summary`.

Both are covered in full in [`OBSERVABILITY.md`](OBSERVABILITY.md).

## Step 6 — Know the upgrade story before you need it

Once you have real incidents and real data in this schema, "wipe and
reinstall" is no longer a safe way to pick up a new ErrorShield version.
Read [`UPGRADE.md`](UPGRADE.md) now, not the day you need to upgrade —
it explains the split between idempotent structural changes (automatic)
and data migrations (`release/migrations/`, run by hand).

---

## If you're contributing code back

Steps 1-6 are for *using* ErrorShield. If you're changing ErrorShield
itself — fixing a bug, adding a preference, extending the admin app — see
[`CONTRIBUTING.md`](../CONTRIBUTING.md) for running the test suite locally
and how CI is wired, and `.claude/rules/` (imported by `CLAUDE.md`) for
coding standards.
