# ErrorShield — Oracle APEX / PL/SQL Code Standards

This file is an **index only**. It does not contain standards content itself —
it imports the rule files that Claude Code should always load into context.
Detailed standards live under `.claude/rules/` — this package's `rules/`
folder, consumed as your project's `.claude/` directory via git submodule.

See `.claude/STRUCTURE.md` for a full explanation of how this configuration
directory is organized (rules vs. agents vs. commands vs. skills vs. hooks).

## Rules (always loaded)

@.claude/rules/sql-format.md
@.claude/rules/plsql-standards.md
@.claude/rules/ddl-conventions.md
@.claude/rules/apex-ux.md
@.claude/rules/security.md
@.claude/rules/javascript-standards.md
@.claude/rules/git-workflow.md
@.claude/rules/repo-structure.md
@.claude/rules/documentation-formatting.md
@.claude/rules/error-handling.md

## Other configuration

- Reviewer/generator subagents: `.claude/agents/`
- Slash commands: `.claude/commands/`
- Multi-step guides: `.claude/skills/`
- Git hooks: `.claude/hooks/`

## Project-specific rules

The rules above are the generic Oracle APEX / PL/SQL standard. These are
ErrorShield's own additions on top — where the generic rule doesn't say
anything, or where this project made a specific call.

**Naming.** Project prefix `ersh_` on every core table, view, and package.
`logger*` objects are vendored from OraOpenSource — never modified directly;
anything ErrorShield needs from Logger goes through an `ersh_`-side wrapper.

**Error-handling lessons** (learned by breaking them — see `ERSH-022`/`023`
in git history for the actual bugs):
- A `when others` must never catch the `raise_application_error` its own
  block just raised. An intentional business error is not an unhandled
  exception and must not produce `logger.log_error`. Structure the risky
  work in a nested block with its own handler, and raise the final,
  intentional error outside any exception handler entirely.
- Every lookup respects `active_yn`. A deactivated row behaves as if it
  never existed — same fallback path as a missing row, never a distinct
  "disabled" message that leaks internal state to the end user.
- Blocks that log or record incidents never escalate: wrap them in their
  own `begin ... exception when others then null; end;`. A failure in
  observability must never break the caller's transaction.
- Masking is fail-safe: any error reading configuration means mask. Never
  the other way around.
- Incident recording uses `pragma autonomous_transaction` + `commit`, with
  an explicit `rollback` in its own `when others`, so it survives a
  caller's rollback.
- An incident is a root cause, not a single hit. `ersh_shield_incidents`
  carries resolution state; individual hits go to
  `ersh_incident_occurrences`. Never fold user identity into the dedup key
  (fingerprint + time bucket only).

**Security.** `ersh_error_handler_api` runs with definer's rights.
Consumer schemas get `execute` on the package and `select` on the tables —
never DML; every write goes through the package.

**APEX export.** Two formats coexist and **both are canonical**:
`apex/apex_lang/app_10400/` (split — what makes a UI PR reviewable) and
`apex/apex_single_file/f10400.sql` (direct install). Regenerate both in the
same run. Corollary: since any UI change regenerates the whole export tree,
two branches touching the app never merge cleanly — group UI changes into
one PR and don't let them overlap.

**Releases.** SemVer; the public API freezes at 1.0.0. Every new object is
registered in its matching `all_*.sql`. Structural changes are covered by
idempotent DDL directly in each object's own script — there is no
"upgrade an existing install" path pre-1.0.0, since none has shipped yet;
the only supported way to move a dev/test schema forward is
`_uninstall.sql` + `_release.sql`. Once something ships, data-only
transformations for a real upgrade go in `release/migrations/`, numbered
and gated by the `ERSH_VERSION` preference — not structural changes, which
idempotent DDL already handles. `release/_release.sql` fails if any
`ERSH_*`/`LOGGER*` object is left invalid after recompile; that check is
never relaxed.

**Third-party (Logger).** If Logger already exists in the target schema,
its tables and data are left untouched — `merge`s are `when not matched`,
tables are guarded by a `count(1)` check, and post-install reads the
existing `LEVEL` and re-sets it rather than overwriting it. Code always
compiles to this repo's vendored version regardless. The release only ever
writes `pref_type = 'ERSH'` rows to `logger_prefs`, and only when they
don't already exist — never a `LOGGER` row.
