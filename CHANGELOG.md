# Changelog

All notable changes to this project are documented here. The format
follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and
versioning follows [Semantic Versioning](https://semver.org/) — the public
API freezes at `1.0.0` (see `CLAUDE.md`'s "Releases" section).

No version has shipped yet. Everything below is accumulated on `main`
ahead of the first public release, `0.9.0`.

---

## [Unreleased]

### Added

- `ersh_incident_occurrences` child table: each hit on an incident records
  its own `logger_log_id` and `app_user`, so an incident groups every
  occurrence of the same root cause instead of one flattened row
  (`ERSH-010`).
- `get_message(p_error_code)` — returns a custom error's message text
  without raising it, respecting `active_yn` the same way error raising
  does (`ERSH-024`).
- Check constraint on `ersh_error_lookup`'s `ora_sqlcode` range
  (`-20999..-20000`), plus validation in `merge_ersh_error_lookup` for a
  clear message before the database would otherwise raise `ORA-02290`
  (`ERSH-025`).
- `active_yn` on `ersh_constraint_lookup`, with a check constraint and
  default; the decision tree treats a deactivated constraint mapping the
  same as one that was never configured (`ERSH-031`).
- `purge_incidents` + `jobs/ersh_purge_job.sql` — opt-in retention for
  `ersh_shield_incidents`/`ersh_incident_occurrences`, off by default (see
  [`docs/OBSERVABILITY.md`](docs/OBSERVABILITY.md)) (`ERSH-026`).
- Optional `SCRUB_FUNCTION` hook to scrub sensitive text out of stored
  error messages before they land in `error_summary`, inert by default
  (`ERSH-032`).
- Standalone ErrorShield Demo app (10401) — one page, four buttons, one
  per branch of the decision tree, seeded via
  `demos/demo_errorshield_app_seed.sql` (`ERSH-033`).
- `docs/UPGRADE.md`: the split between idempotent structural DDL and
  numbered data migrations under `release/migrations/`, gated by the
  `ERSH_VERSION` preference (`ERSH-020`).
- utPLSQL test suite (5 suites, 32 tests) covering the decision tree,
  masking, dedup/occurrences, and previously-untested core bug fixes, plus
  a two-workflow GitHub Actions CI setup that caches a pre-built Oracle
  Database + APEX + utPLSQL image so PRs don't reinstall it from scratch
  (`ERSH-027`).
- `docs/CONFIGURATION.md`, `docs/ONBOARDING.md`, `CHANGELOG.md`, and this
  project's `SECURITY.md` (`ERSH-045`).

### Changed

- Consumer schema grants reduced to `select` only on the three core
  tables/view — never DML; a `revoke` step was added to
  `grant_ersh_to_user.sql` for schemas granted under the old, broader
  model (`ERSH-012`).
- `workspace_id` added to `ersh_shield_incidents` and folded into the
  dedup fingerprint calculation (`ERSH-013`).
- `error_code` is now `not null` on `ersh_error_lookup`, matching what
  `merge_ersh_error_lookup` already required (`ERSH-028`).
- `reference_display` (in `ersh_incident_occurrences_vw` /
  `ersh_shield_incidents_vw`) now reads the
  `REFERENCE_DISPLAY_MIN_DIGITS` preference instead of a hardcoded
  `lpad(...,10,'0')` (`ERSH-017`).
- `raise_custom_error` unified onto a single `select ... into` with
  `no_data_found` handling, replacing a `count(1)` followed by a second
  `select` (`ERSH-030`).
- Default owner schema name standardized to `LOGGER_USER` across scripts
  and docs (`ERSH-034`).
- 11 `ersh_*_vw` views extracted out of inline SQL previously embedded in
  the admin app's job pages.
- Coding standards are now consumed as a git submodule at `.claude/` from
  [OracleApex-Code-Standards](https://github.com/Aftorres02/OracleApex-Code-Standards)
  instead of an in-repo `AGENTS.md` (`ERSH-019`).

### Fixed

- `raise_custom_error` and `apex_error_handling` no longer log an
  intentional business error as a false "Unhandled Exception" — the
  `raise_application_error` that raises it now sits outside any `when
  others` handler, in its own nested block (`ERSH-022`, `ERSH-023`), and
  the same fix was later applied to `resolve_incident`, which had the
  identical bug (`ERSH-044`).
- `raise_custom_error` / `get_message` now respect `active_yn` — a
  deactivated custom error code falls back to the generic message the
  same way a missing one does, instead of leaking that it once existed
  (`ERSH-022`).
- `component_type` / `component_name` are now populated from
  `p_error.component.type` / `.name` in `log_and_mask_error`, instead of
  being left blank (`ERSH-016`).
- `SUPPORT_EMAIL`'s default changed to `support@example.com`
  (RFC 2606-reserved, so it can never belong to a real mailbox); an
  operator email address is no longer baked in as the default
  (`ERSH-018`).

### Security

- See "Changed" above for the consumer-grants reduction (`ERSH-012`) —
  listed there and here since it closes a real over-permissioning gap.
- Known, accepted security-relevant limitations (cross-application
  incident visibility, the admin-app authorization placeholder, and a
  silent Logger version downgrade on release) are now documented in
  [`SECURITY.md`](SECURITY.md) rather than living only in internal notes.

[Unreleased]: https://github.com/Aftorres02/OracleAPEX-ErrorShield/compare/main...HEAD
