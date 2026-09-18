# Install

## Prerequisites and privileges

- Oracle APEX 26.1+ and Oracle Database 19c (19.18+) or Oracle AI Database
  26ai — see the support matrix in the [README](../README.md#support-matrix).
- An owner schema (new or existing) with:

  ```
  CREATE SESSION
  CREATE TABLE
  CREATE VIEW
  CREATE SEQUENCE
  CREATE PROCEDURE
  CREATE TRIGGER
  CREATE ANY CONTEXT
  CREATE JOB
  ```

  `release/_release.sql` checks these up front
  (`scripts/logger_install_prereqs.sql`) and aborts before touching anything
  if one is missing.
- If you don't have an owner schema yet, `scripts/admin/create_user.sql`
  creates one (run as `SYS`/`SYSTEM`) with exactly this privilege set.

## Installing the owner schema

```bash
cd release
sql <connection-as-the-owner-schema>
@_release.sql
```

`_release.sql` is the single entry point: tables, views, packages, triggers,
the Logger global context, seed preferences, post-install configuration, the
purge-adjacent jobs, and the admin app (10400) import, in that order. It
fails if any `ERSH_*`/`LOGGER*` object is left invalid after the final
recompile — that check is never relaxed.

Re-running `_release.sql` against an already-installed schema converges: the
DDL is idempotent (every table/index/constraint checks for its own existence
before creating itself), and re-running it is currently the *only* supported
way to move a local schema forward — see
[`UPGRADE.md`](UPGRADE.md) for why there's no in-place upgrade path yet.

### If Logger already exists in this schema

The release leaves it alone. Every Logger table script guards its `create
table` with a `count(1)` check, every preference `merge` is `when not
matched` (an existing value is never overwritten), and
`scripts/post_install_configuration.sql` reads the schema's current
`LEVEL` preference and re-applies it rather than resetting it. The PL/SQL
code always recompiles to this repo's vendored Logger version (3.1.1)
regardless of what was there before — see the [`NOTICE`](../NOTICE) file for
the exact upstream snapshot.

## Onboarding a consumer schema

A "consumer" is any schema running an APEX app that wants to call
`ersh_error_handler_api` without owning any of its objects.

1. Connected as the **owner** schema, grant privileges to the consumer:

   ```sql
   @scripts/grant_ersh_to_user.sql MY_APP_SCHEMA
   ```

   This grants `execute` on the package and `select` on the three core
   tables plus `ersh_shield_incidents_vw` — never `insert`/`update`/`delete`.
   Every write goes through the package, which runs with the owner's
   definer's rights.

2. Connected as the **consumer** schema, create synonyms pointing back at
   the owner:

   ```sql
   @scripts/consumer/create_ersh_synonyms.sql OWNER_SCHEMA_NAME
   @scripts/consumer/create_logger_synonyms.sql OWNER_SCHEMA_NAME
   ```

## Configuring the Error Handling Function

In the consumer app: **Shared Components → Security Attributes → Error
Handling Function**, set it to:

```
ersh_error_handler_api.apex_error_handling
```

That's the one integration point. From here on, every unhandled error in
that app — internal APEX errors, constraint violations, custom business
errors, unexpected ORA codes — routes through ErrorShield automatically.

> **Want to see all four branches without touching your own app first?**
> The ErrorShield Demo app (10401) exercises exactly these four cases. See
> the [README quickstart](../README.md#quickstart).

## Troubleshooting

**`_release.sql` fails at the prerequisites check.** The error message
names the missing privilege(s) directly — grant them (or re-run
`scripts/admin/create_user.sql` for a fresh owner schema) and re-run.

**`_release.sql` fails at the final validation step (`ORA-20002`).** Some
`ERSH_*`/`LOGGER*` object is still invalid after recompile. The release
prints every invalid object in the schema first (informational), then the
subset that's actually `ERSH_*`/`LOGGER*` (the one that fails the build).
Fix that object and re-run — the release is idempotent, so re-running after
a partial failure is safe.

**`apex import` complains about the application ID or workspace.** Check
`release/load_env_vars.sql` — `env_schema_name` and `env_apex_workspace`
must match the schema/workspace you're actually connected as.

**A consumer schema gets `ORA-01031` calling `ersh_error_handler_api`.**
The grant step (above) wasn't run, or was run for the wrong schema name.
`grant_ersh_to_user.sql` is safe to re-run.

**You need to reset a local schema entirely.** There is no upgrade path
pre-1.0.0 — see [`UPGRADE.md`](UPGRADE.md). Use:

```sql
@release/_uninstall.sql
@release/_release.sql
```
