# Contributing

This covers running the test suite locally and how CI is wired. For coding
standards, see `.claude/rules/` (imported by `CLAUDE.md`). For branch naming
and the PR workflow, see `.claude/rules/git-workflow.md`.

## Prerequisites

- Oracle Database 19c (19.18+) or Oracle AI Database 26ai, with Oracle APEX
  26.1+ installed — see the support matrix in [`README.md`](README.md).
  `ersh_error_handler_api.pks` references `apex_error.t_error` in its own
  signature, so the package cannot compile — let alone be tested — without
  real APEX installed. There is no lighter option.
- [SQLcl](https://www.oracle.com/database/sqldeveloper/technologies/sqlcl/)
  on your `PATH`.
- [utPLSQL](https://www.utplsql.org/) installed against that same database.

## Setting up a local database

Any Oracle DB + APEX 26.1+ instance works. If you don't already have one,
[United-Codes/uc-local-apex-dev](https://github.com/United-Codes/uc-local-apex-dev)
automates standing one up locally in Docker (Oracle AI Database Free +
Oracle APEX + ORDS) — that is what this repo's own CI recipe was validated
against before being written into
[`.github/workflows/ci.yml`](.github/workflows/ci.yml).

## Installing utPLSQL

```bash
git clone --branch v.3.2.3 --depth 1 https://github.com/utPLSQL/utPLSQL.git
cd utPLSQL/source
sql -S sys/<sys_password>@<host>:<port>/<service> as sysdba \
  @install_headless.sql UT3 <a_password_for_the_ut3_schema> users
```

## Installing ErrorShield

Connected as `SYS`/`SYSTEM`, create an owner schema if you don't have one
yet (see [`docs/INSTALL.md`](docs/INSTALL.md) for the full onboarding flow):

```bash
sql -S sys/<sys_password>@<host>:<port>/<service> as sysdba \
  @scripts/admin/create_user.sql
```

Then, connected as that owner schema:

```bash
cd release
sql <connection-as-owner-schema> @_uninstall.sql   # safe no-op on a fresh schema
sql <connection-as-owner-schema> @_release.sql
```

## Running the tests

```bash
cd tests
sql <connection-as-owner-schema> @run_tests.sql
```

This compiles the six utPLSQL suites in `tests/` and runs them with a
console reporter:

| Suite | Covers |
|---|---|
| `ut_ersh_decision_tree` | The 7 branches of `apex_error_handling` — internal vs. business error, known/unknown/deactivated constraint (ERSH-031), the dev `-20999..-20000` range, the generic masking fallback |
| `ut_ersh_masking` | `ENVIRONMENT` / `MASK_IN_ENVIRONMENTS` matching, including the `PROD` vs. `PROD_OLD` no-partial-match guard and the fail-safe-on-error path |
| `ut_ersh_dedup_occurrences` | `record_internal_incident` dedup + `ersh_incident_occurrences` — the test that protects ERSH-010: either of two users' reference codes must resolve back to the same incident |
| `ut_ersh_core_bugs` | `raise_custom_error` / `get_message` respecting `active_yn` (ERSH-022, ERSH-024), the `ora_sqlcode` range validation on `merge_ersh_error_lookup` (ERSH-025) |
| `ut_ersh_observability` | The `SCRUB_FUNCTION` hook (ERSH-032) — inert by default, applies when configured, falls back on a broken function, never affects the dedup fingerprint — and `purge_incidents` retention (ERSH-026) |
| `ut_ersh_related_logs` | The reference code → Logger trail (ERSH-051): `ersh_related_logs_vw` keeps the same request's rows (same `client_identifier` and `sid`, 2 minutes before to 5 seconds after) and drops other sessions or rows outside the window; `ersh_incident_occurrences_vw.log_status` reports Logged / Purged / Not logged |

Each suite cleans up its own fixtures (`%aftereach`) — running the suite
repeatedly against the same schema is safe.

> **Note:** `record_internal_incident` and `logger.set_pref` both commit
> autonomously, so the suites that touch them (`ut_ersh_dedup_occurrences`,
> `ut_ersh_decision_tree`, `ut_ersh_masking`) use utPLSQL's
> `--%rollback(manual)` annotation and clean up explicitly instead of relying
> on utPLSQL's automatic per-test rollback, which can't undo an autonomous
> commit anyway.

## How CI works

Two workflows, split by how often each needs to run. Both read the tool
versions (database image, APEX, utPLSQL, SQLcl) from
[`ci/versions.env`](ci/versions.env) — the one place to change them.

### On every PR and every merge to main

[`.github/workflows/ci.yml`](.github/workflows/ci.yml) pulls the prebuilt
image (Oracle Database Free + APEX + utPLSQL; it starts in seconds), then:

1. creates the `LOGGER_USER` schema and its APEX workspace;

2. installs ErrorShield from scratch with `release/_uninstall.sql` +
   `release/_release.sql`, including the APEX app;

3. fails if any object is invalid or app 10400 was not imported;

4. compiles every `tests/*.pks` and `*.pkb`, and fails with the compile
   errors if one does not compile;

5. runs the utPLSQL suite and fails on any failure or error, or if fewer
   tests ran than the `--%test` annotations in `tests/*.pks` declare;

6. reports code coverage of the `ERSH_*` objects (informational — it
   never fails the job).

Results, failing tests and coverage appear in the run's summary page; the
JUnit XML and the coverage report are uploaded as artifacts. A PR that only
touches Markdown, `docs/` or `LICENSE` skips the test job (reported as
passed).

### Only when the tool versions change

[`.github/workflows/build-ci-image.yml`](.github/workflows/build-ci-image.yml)
— manual (`workflow_dispatch`). Installs Oracle Database Free + APEX +
utPLSQL from scratch, commits the stopped container and pushes it to
`ghcr.io/aftorres02/oracle-apex-utplsql`. About 20 minutes. It holds no
ErrorShield objects, so any Oracle APEX project can reuse it; the image is
public.

To upgrade the database, APEX or utPLSQL: on a branch, edit
`ci/versions.env` with a **new** `CI_IMAGE_TAG`, run this workflow on that
branch, then push — the PR's CI runs against the new image. The workflow
refuses to overwrite a tag that already exists, because other branches
still pull it. A SQLcl upgrade only needs the `SQLCL_URL` edit.

### Expected noise in the install log

`Errors for TRIGGER BIU_LOGGER_PREFS: PLS-00049: bad bind variable
'NEW.PREF_TYPE'` appears on every fresh install. Logger's own
`tables/logger_prefs.sql` (vendored, not modified here) creates the
trigger before it adds the `pref_type` column further down the same
script; the trigger compiles cleanly at the end. Anything else invalid
fails the job at "Verify the install".
