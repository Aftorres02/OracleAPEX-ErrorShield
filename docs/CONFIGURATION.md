# Configuration

Every ErrorShield setting is a row in `logger_prefs` with `pref_type =
'ERSH'`, seeded (insert-if-missing) by
[`data/ersh_preferences.sql`](../data/ersh_preferences.sql) on first
install. "Insert-if-missing" means the release never overwrites a value an
admin already changed — re-running `release/_release.sql` converges
without reverting anyone's configuration.

Read and write preferences the same way Logger itself does:

```sql
-- read
select logger.get_pref('SUPPORT_EMAIL', 'ERSH') from dual;

-- write
exec logger.set_pref('ERSH', 'SUPPORT_EMAIL', 'support@yourcompany.com');
```

---

## Version bookkeeping

`ERSH_VERSION` — **default:** `1.0.0`

Internal bookkeeping for the migration system described in
[`UPGRADE.md`](UPGRADE.md) — a migration script under `release/migrations/`
reads this to decide whether it still needs to run, then stamps it forward
itself. Don't set this by hand; a migration script owns it.

## Support contact shown to end users

`SUPPORT_EMAIL` — **default:** `support@example.com`

The address shown to end users alongside their incident reference code.

> **Change this before going to production.** The default uses
> `example.com`, a domain reserved by RFC 2606 so nobody can ever register
> it — left on the default, a user's reply bounces instead of landing on
> someone else's real mailbox (`ERSH-018`). Post-install configuration
> warns (via `logger.log_warn`) if this preference is still on the default
> after a release.

## Reference code digit width

`REFERENCE_DISPLAY_MIN_DIGITS` — **default:** `10`

Minimum digit width when formatting the numeric incident id into the
reference code shown to end users (e.g. `id = 42` renders as
`0000000042` at the default width). Purely cosmetic — raise it if you
expect incident volume high enough that short codes would look
inconsistent next to older ones.

## Incident retention window

`ERSH_PURGE_AFTER_DAYS` — **default:** `90`

Retention window (in days) for `ersh_error_handler_api.purge_incidents`.
See [`OBSERVABILITY.md`](OBSERVABILITY.md#incident-retention) for the full
mechanism and how to activate the scheduled purge job.

> **Must stay greater than Logger's own `PURGE_AFTER_DAYS`** (7 days by
> default, `tables/logger_prefs.sql`). A user can report a reference code
> well after Logger has purged the matching `logger_logs` row — the
> incident it points to has to still exist in `ersh_shield_incidents` for
> the DEV main to resolve it.

## Scrubbing hook for stored error messages

`SCRUB_FUNCTION` — **default:** unset (not seeded at all)

Optional hook that scrubs sensitive text out of `error_summary` before
it's stored. Left unset, the raw internal error message is stored
unchanged. See [`OBSERVABILITY.md`](OBSERVABILITY.md#scrubbing-sensitive-text)
for the function contract, safety guarantees, and a worked example.

## Current environment label

`ENVIRONMENT` — **default:** `PROD`

A free-text label for the current database — `DEV`, `TEST`, `QA`, `STAGE`,
`PROD`, `HOTFIX`, or anything else your team uses. Matched against
`MASK_IN_ENVIRONMENTS` (below) to decide whether internal APEX errors get
masked behind a generic message for end users.

## Which environments mask errors

`MASK_IN_ENVIRONMENTS` — **default:** `TEST,PROD`

Comma-separated list of `ENVIRONMENT` values where internal APEX errors
must be hidden behind a generic reference message instead of shown raw.
Matching is case-insensitive, whitespace-tolerant, and exact per entry —
`PROD` never partial-matches `PROD_OLD`.

| Value | Effect |
|---|---|
| `TEST,PROD` (default) | Mask in `TEST` and `PROD`; raw errors in `DEV` |
| `PROD` | Mask only in `PROD` |
| `DEV,TEST,PROD` | Mask everywhere |
| `''` or `null` | Never mask — always show raw errors |

> **Fail-safe direction:** any error reading this configuration masks the
> error. It is never the other way around — a broken preference can make
> ErrorShield over-cautious, never under-cautious.

---

## What's intentionally not here

`SUPPORT_EMAIL` and every preference above are global to the owner schema
— there is no per-consumer-application override. See the README's [Known
limitations](../README.md#known-limitations) for why, and
[`SECURITY.md`](../SECURITY.md) for the security-relevant subset of those
limitations.

Logger's own preferences (`LEVEL`, `PURGE_AFTER_DAYS`, etc., `pref_type =
'LOGGER'`) are a separate namespace and out of scope for this document —
see [OraOpenSource/logger](https://github.com/OraOpenSource/logger)'s own
documentation. `post_install_configuration.sql` reads the schema's
*current* `LEVEL` and re-applies it rather than resetting it, so an
existing Logger install's logging level survives a release.
