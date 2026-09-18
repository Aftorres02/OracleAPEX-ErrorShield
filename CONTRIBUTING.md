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

This compiles the five utPLSQL suites in `tests/` and runs them with a
console reporter:

| Suite | Covers |
|---|---|
| `ut_ersh_decision_tree` | The 7 branches of `apex_error_handling` — internal vs. business error, known/unknown/deactivated constraint (ERSH-031), the dev `-20999..-20000` range, the generic masking fallback |
| `ut_ersh_masking` | `ENVIRONMENT` / `MASK_IN_ENVIRONMENTS` matching, including the `PROD` vs. `PROD_OLD` no-partial-match guard and the fail-safe-on-error path |
| `ut_ersh_dedup_occurrences` | `record_internal_incident` dedup + `ersh_incident_occurrences` — the test that protects ERSH-010: either of two users' reference codes must resolve back to the same incident |
| `ut_ersh_core_bugs` | `raise_custom_error` / `get_message` respecting `active_yn` (ERSH-022, ERSH-024), the `ora_sqlcode` range validation on `merge_ersh_error_lookup` (ERSH-025) |
| `ut_ersh_observability` | The `SCRUB_FUNCTION` hook (ERSH-032) — inert by default, applies when configured, falls back on a broken function, never affects the dedup fingerprint — and `purge_incidents` retention (ERSH-026) |

Each suite cleans up its own fixtures (`%aftereach`) — running the suite
repeatedly against the same schema is safe.

> **Note:** `record_internal_incident` and `logger.set_pref` both commit
> autonomously, so the suites that touch them (`ut_ersh_dedup_occurrences`,
> `ut_ersh_decision_tree`, `ut_ersh_masking`) use utPLSQL's
> `--%rollback(manual)` annotation and clean up explicitly instead of relying
> on utPLSQL's automatic per-test rollback, which can't undo an autonomous
> commit anyway.

## How CI works

Two workflows, split by how often each needs to run:

- [`.github/workflows/build-ci-image.yml`](.github/workflows/build-ci-image.yml)
  — manual (`workflow_dispatch`) only. Installs Oracle Database Free + real
  Oracle APEX 26.1 + utPLSQL from scratch, then commits the stopped
  container and pushes it to `ghcr.io/<owner>/oracle-apex-utplsql`. Slow
  (~30-40 minutes) — run it once, and again whenever the pinned
  Oracle/APEX/utPLSQL versions change. Deliberately generic: no ErrorShield
  objects are baked in, so the same image is reusable by any other Oracle
  APEX project's CI, not just this repo.
- [`.github/workflows/ci.yml`](.github/workflows/ci.yml) — runs on every
  PR. Pulls that pre-built image (DB + APEX + utPLSQL already installed,
  starts in seconds instead of being created from scratch), then installs
  ErrorShield fresh (`release/_uninstall.sql` + `_release.sql`) and runs the
  `tests/` suite, gated on a GitHub check.

**Before `ci.yml` can pass for the first time**, `build-ci-image.yml` has
to run once manually to publish the base image. See
`data/plan/CI-ROLLOUT.md` for the exact activation steps and what's been
validated locally vs. not yet run for real on GitHub.

**To reuse `ghcr.io/<owner>/oracle-apex-utplsql` from another repo**, its
package visibility needs to be set to public (one-time, in that package's
GitHub settings) — `ci.yml` itself doesn't need this, since `GITHUB_TOKEN`
can always pull a package this same repo published.
