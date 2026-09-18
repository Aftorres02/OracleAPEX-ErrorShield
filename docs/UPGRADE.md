# Upgrade policy

## Right now: there is no upgrade path, and that's on purpose

ErrorShield hasn't shipped a public release yet — there is no real
installation anywhere that needs to be moved forward without losing data.
Every table, view, and package script in this repo writes its structure
directly (`create table`, `create or replace view/package`), guarded only
by the standard "does this object already exist at all" idempotency check
described in `.claude/rules/ddl-conventions.md`.

If you need to pick up a schema change locally, the only supported path is:

```sql
@release/_uninstall.sql
@release/_release.sql
```

Don't try to patch an existing dev/test schema forward column by column —
there's nothing there worth preserving yet, and doing so just reintroduces
the complexity this project deliberately doesn't carry pre-1.0.0.

## From 1.0.0 onward: the real policy

Once a version ships and real schemas are running it, "wipe and reinstall"
stops being an option — those schemas have real incidents, real custom
error codes, real data. From that point on, two different kinds of change
are handled differently:

**Structural changes** (a new column, a new constraint, a new table) stay
inside each object's own idempotent script — the same pattern used since
day one, just now actually exercised against a real prior install instead
of a schema that gets wiped between tests. Concretely: a new column is
added via a guarded `alter table ... add` (checked against
`user_tab_columns`), never folded blindly into a `create table` that only
fires when the table doesn't exist yet. Re-running `release/_release.sql`
against an already-installed schema must converge without erroring and
without touching data it didn't intend to touch.

**Data-only transformations** — backfilling a new column on existing rows,
recomputing a derived value, migrating rows into a new shape — go in
`release/migrations/`, never inside the idempotent DDL scripts. Idempotent
DDL answers "does this structure exist"; it has no way to answer "does
this *data* need transforming", which is exactly what a migration script
is for.

### Migration script convention

- **Location & naming**: `release/migrations/NNN_short-description.sql`,
  zero-padded, in ascending order (`001_...`, `002_...`, ...).
- **Never auto-run**: `release/_release.sql` only owns idempotent
  structure. Migrations are run by hand, once, after a release that needs
  them — never wired into `_release.sql` itself.
- **Gated by `ERSH_VERSION`**: the preference lives in `logger_prefs`
  (`pref_type = 'ERSH'`, `pref_name = 'ERSH_VERSION'`), seeded by
  `data/ersh_preferences.sql` on first install and otherwise left alone
  (insert-if-missing, so an admin's manual changes survive future
  releases). A migration script reads it with
  `logger.get_pref('ERSH_VERSION', 'ERSH')`, does its work only if the
  schema's version is older than what it targets, and stamps the new
  version forward at the end with `logger.set_pref('ERSH', 'ERSH_VERSION', '<new version>')`.
  That makes every migration safe to accidentally re-run: a schema
  already at or past the target version is a no-op.
- **Idempotent on top of that**: the version gate prevents re-running a
  migration that already applied, but the migration's own SQL should
  still be written defensively (`insert ... where not exists`, `merge`,
  etc.) rather than assuming a single clean run.

## Why this split

The idempotent DDL pattern (`select count(1) from user_tables/user_indexes/
user_constraints` → `execute immediate` inside an `if l_count = 0`) answers
one question: *does this object exist yet?* It says nothing about the data
already sitting in it. Trying to force a data backfill through that same
guard either does nothing (guard already satisfied, wrong reason) or
requires bolting unrelated data logic onto a structural check. Keeping
the two concerns in separate files — idempotent DDL for structure,
numbered scripts for data — means each one stays simple enough to read in
one pass, and a migration never gets silently skipped because some
unrelated structural guard happened to already be satisfied.
