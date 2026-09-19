# Security Policy

## Supported versions

No public release has shipped yet (see the [roadmap](data/plan/ROADMAP.md)
if you have access to it, or the version history in
[`CHANGELOG.md`](CHANGELOG.md)) — there is no version support matrix to
publish yet. Until `1.0.0` ships, security reports apply to the current
`main` branch. This section will be replaced with a real supported-versions
table at that point.

## Reporting a vulnerability

Please use GitHub's private vulnerability reporting for this repository
instead of opening a public issue:

```
https://github.com/Aftorres02/OracleAPEX-ErrorShield/security/advisories/new
```

This keeps the report private between you and the maintainers until a fix
is ready. Please include:

- The affected object(s) (package, table, view, or APEX page/process).
- A reproduction, ideally against the [Demo app](README.md#quickstart)
  (10401) or a minimal owner-schema install — that already gives a report
  a self-contained way to demonstrate the issue.
- What you'd expect to happen instead.

---

## The security model, in one paragraph

`ersh_error_handler_api` runs with **definer's rights**, owned by the
schema that ran `_release.sql`. Consumer application schemas never own any
ErrorShield object — they get `execute` on the package and `select` on
`ersh_shield_incidents`, `ersh_incident_occurrences`, and
`ersh_shield_incidents_vw` only, via
[`scripts/grant_ersh_to_user.sql`](scripts/grant_ersh_to_user.sql). **Never
DML.** Every write — recording an incident, resolving one, purging old
ones — goes through the package, which enforces its own rules regardless
of who called it.

## Coding-level security posture

These are enforced as review-time standards on every change, not just
described here:

- **No string-concatenated dynamic SQL.** `execute immediate ... using`
  with bind variables; `dbms_assert` on any dynamically-referenced object
  name. See `.claude/rules/security.md`.
- **No raw exception text reaches end users.** Internal APEX errors and
  unexpected ORA codes are masked behind a generic reference message
  (subject to `MASK_IN_ENVIRONMENTS`, see
  [`CONFIGURATION.md`](docs/CONFIGURATION.md)) — never `sqlerrm` or a raw
  stack trace shown directly to a user.
- **Business packages never call `apex_error.add_error` directly** — see
  `.claude/rules/error-handling.md`. This keeps `ersh_error_handler_api`
  usable outside an APEX session (scheduled jobs, other applications,
  tests) and keeps error *presentation* a strictly separate concern from
  error *handling*.
- **Observability never escalates.** A failure recording or logging an
  incident is caught in its own handler and swallowed — it can never break
  the caller's transaction. See `CLAUDE.md`'s "Error-handling lessons".

## Known limitations with security implications

These are consequences of decisions already made, not open bugs — the
non-security-flavored version of this same list is in the README's [Known
limitations](README.md#known-limitations).

> **No isolation between consumer applications.** Every consumer schema is
> granted `select` on `ersh_shield_incidents`, so any code running in
> schema A can read schema B's incidents — `error_summary` included, which
> may contain bind values or fragments of the row that failed. Grants
> alone can't fix this; it needs a VPD policy (`ERSH-042`, not yet built).
> If your consumer schemas don't fully trust each other, treat
> `error_summary` as reachable, and don't rely on this package for
> cross-tenant isolation until that ships.

> **Every authenticated user of the admin app is an administrator.** The
> `administration-rights` authorization scheme is a placeholder (`return
> true;`) until a real role model exists (`ERSH-043`). Restrict who can log
> into the admin app (10400) at the authentication/network level in the
> meantime — there is no in-app role distinction yet.

> **A Logger downgrade is silent.** This repo vendors Logger 3.1.1 (see
> [`NOTICE`](NOTICE)) and always recompiles to that version on release. If
> a target schema already has a *newer* Logger installed, `_release.sql`
> still overwrites the code with this repo's 3.1.1 — silently, with no
> version check or warning. If you rely on behavior from a newer Logger
> version, confirm the installed version before running a release against
> that schema.

## Reporting a non-security bug

Anything that isn't a vulnerability — a regular bug, a formatting issue, a
feature request — goes through a normal public GitHub issue or PR, not
this process. See [`CONTRIBUTING.md`](CONTRIBUTING.md).
