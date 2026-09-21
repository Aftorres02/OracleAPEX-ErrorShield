# OracleAPEX-ErrorShield

Enterprise error handling for Oracle APEX: maps constraints and custom errors to
friendly messages, optional masking of internal errors, and instrumentation via
the **OraOpenSource Logger** stack (`logger` package and `logger_*` objects).

## What problem this solves

A user hits an error and sees a generic, safe message with a reference code
instead of a raw ORA stack trace. That code is the whole point: a developer
supporting that user (the "DEV main") pastes it into the admin app and lands
directly on the incident that produced it — application, page, the full
internal error detail, and every other user who hit the same root cause.

The cycle is **user → code → DEV main → root cause**: the user reports a code
instead of a screenshot of a stack trace, the DEV main resolves that code to
one incident instead of grepping logs, and the incident already groups every
occurrence of the same underlying bug so fixing it closes all of them at once.

## Support matrix

- Oracle APEX 26.1+
- Oracle Database 19c (19.18+) or Oracle AI Database 26ai

---

## Quickstart

1. **Install the owner schema** — creates Logger + ErrorShield objects and
   the admin app (10400). See [`docs/INSTALL.md`](docs/INSTALL.md) for
   prerequisites, privileges, and the full walkthrough.
2. **Onboard a consumer app's schema** — grants + synonyms so that schema can
   call `ersh_error_handler_api` without owning any of its objects. Covered
   in [`docs/INSTALL.md`](docs/INSTALL.md#onboarding-a-consumer-schema).
3. **Point the consumer app's Error Handling Function** at
   `ersh_error_handler_api.apex_error_handling` (Shared Components → Security
   → Error Handling). See
   [`docs/INSTALL.md`](docs/INSTALL.md#configuring-the-error-handling-function).
4. **Try it without installing anything of your own**: the ErrorShield Demo
   app (10401, `apex/apex_lang/app_10401/`) is a standalone app with one page
   and four buttons, each deliberately triggering one branch of the decision
   tree — internal APEX error, constraint violation, business error, and an
   unexpected ORA error. Seed it with
   [`demos/demo_errorshield_app_seed.sql`](demos/demo_errorshield_app_seed.sql),
   then import it with `scripts/apex_install_demo.sql`. It never touches the
   real admin app.
5. **Presenting to a live audience?** The admin app's own reports and
   dashboards are empty on a fresh install — see
   [`docs/DEMO.md`](docs/DEMO.md) to bulk-generate realistic, clearly-fake
   data on a throwaway schema instead.

---

## Known limitations

These are consequences of decisions already made, not open bugs.

> **No isolation between apps.** Every consumer schema gets `select` on
> `ersh_shield_incidents`, so any code in schema A can read schema B's
> incidents — `error_summary` included. Grants alone can't fix this; it would
> need a VPD policy (`ERSH-042`, not yet built).

> **Every authenticated user of the admin app is an administrator.** The
> `administration-rights` authorization scheme is a placeholder (`return
> true;`) until a real role model exists (`ERSH-043`).

> **No per-application configuration override.** `SUPPORT_EMAIL` and every
> other ERSH preference are global to the owner schema — a consumer app
> can't set its own support address.

The first two have security implications beyond UX — see
[`SECURITY.md`](SECURITY.md#known-limitations-with-security-implications)
for those, plus one more (a silent Logger version downgrade on release)
that's security-relevant but not otherwise user-visible.

---

## License

This project is released under the [MIT License](LICENSE).

## Third-party / credits

**Logger** (packages, tables, views, jobs, contexts, procedures, and related
scripts) is **vendored from**
[OraOpenSource/logger](https://github.com/OraOpenSource/logger), **Copyright
(c) 2015 OraOpenSource**, under the MIT License. The snapshot used in this tree
is recorded in [`NOTICE`](NOTICE) (git commit). A verbatim upstream copy of the
MIT text is in
[`licenses/OraOpenSource-Logger-LICENSE.txt`](licenses/OraOpenSource-Logger-LICENSE.txt).

**ErrorShield** additions (e.g. `ersh_error_handler_api`, `ersh_error_lookup`,
`ersh_constraint_lookup`) are MIT-licensed in this repo as well; see `LICENSE`.

## Layout

- `packages/logger.pks` / `logger.pkb` — upstream Logger
- `packages/ersh_error_handler_api.*` — ErrorShield error API
- `contexts/`, `procedures/` — Logger install helpers from upstream
- `scripts/` — owner-schema scripts (grants, prereqs, post-install, APEX helpers)
- `scripts/admin/` — DBA scripts run as SYS (schema creation)
- `scripts/consumer/` — scripts run as the app schema that consumes ErrorShield (synonyms)
- `demos/` — runnable examples, including the seed data for the ErrorShield Demo app and the bulk demo-data generator (`ersh_demo_data_api`, see [`docs/DEMO.md`](docs/DEMO.md))
- `docs/` — [`INSTALL.md`](docs/INSTALL.md), [`UPGRADE.md`](docs/UPGRADE.md), [`OBSERVABILITY.md`](docs/OBSERVABILITY.md), [`DEMO.md`](docs/DEMO.md)
- `tests/` — utPLSQL suite; see [`CONTRIBUTING.md`](CONTRIBUTING.md) to run it
- [`CHANGELOG.md`](CHANGELOG.md) — notable changes, grouped per [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
- [`SECURITY.md`](SECURITY.md) — reporting a vulnerability, the security model, and security-relevant known limitations

## Standards

Coding standards are consumed as a git submodule at `.claude/`, from
[OracleApex-Code-Standards](https://github.com/Aftorres02/OracleApex-Code-Standards).
After cloning this repo, run:

```bash
git submodule update --init --recursive
```

[`CLAUDE.md`](CLAUDE.md) is the index that loads the standards under
`.claude/rules/` into context for Claude Code. If your tooling reads
`AGENTS.md` by convention instead, copy `.claude/AGENTS.md.template` to
`./AGENTS.md` (gitignored — machine-local, not committed).
