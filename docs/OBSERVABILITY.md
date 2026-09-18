# Observability

Two opt-in pieces, both off by default: retention (ERSH-026) and scrubbing
sensitive text out of stored error messages (ERSH-032).

## Incident retention

`ersh_shield_incidents` and `ersh_incident_occurrences` grow without bound —
nothing purges them during a normal install. `ersh_error_handler_api.purge_incidents`
deletes incidents (and their occurrences) older than the `ERSH_PURGE_AFTER_DAYS`
preference, seeded to `90` by default.

> **Why 90, and why it has to stay above 7:** Logger's own retention
> (`PURGE_AFTER_DAYS`, `tables/logger_prefs.sql`) defaults to 7 days. A
> user can report a reference code well after that — the incident it
> points to has to still exist in `ersh_shield_incidents` for the DEV main
> to find it, even once the matching `logger_logs` row is long gone. Keep
> `ERSH_PURGE_AFTER_DAYS` greater than Logger's `PURGE_AFTER_DAYS`, always.

### Running it manually

```sql
exec ersh_error_handler_api.purge_incidents;                    -- uses ERSH_PURGE_AFTER_DAYS
exec ersh_error_handler_api.purge_incidents(p_purge_after_days => 30);  -- explicit override
```

### Activating the scheduled job

`release/all_jobs.sql` does **not** reference `jobs/ersh_purge_job.sql` —
the release never creates this job on its own. To activate it, connected as
the owner schema:

```sql
@jobs/ersh_purge_job.sql
```

This creates `ERSH_PURGE_JOB` (`FREQ=DAILY; BYHOUR=2`), calling
`ersh_error_handler_api.purge_incidents` with no override, so it always
reads the current `ERSH_PURGE_AFTER_DAYS` preference. The script is safe to
re-run — it checks `user_scheduler_jobs` first and does nothing if the job
already exists.

To change the retention window:

```sql
exec logger.set_pref('ERSH', 'ERSH_PURGE_AFTER_DAYS', '180');
```

To deactivate the job entirely:

```sql
exec dbms_scheduler.drop_job('ERSH_PURGE_JOB');
```

---

## Scrubbing sensitive text

`ersh_shield_incidents.error_summary` stores up to 4000 characters of the
raw internal error message — which can carry bind values, emails, document
numbers, or fragments of the row that failed. It's stored (never masked
from an admin) and visible in the admin app.

There is no built-in scrubbing logic, and there won't be one. Fixed
patterns for emails, card numbers, or document IDs give false confidence
and destroy diagnostic information — this package has no way to know
what's actually sensitive in your data. Instead, `error_summary` runs
through an optional hook you implement yourself.

### The contract

Set the `SCRUB_FUNCTION` preference to the name of a function you write,
matching this signature exactly:

```sql
function my_scrub_function(p_message in varchar2) return varchar2;
```

```sql
exec logger.set_pref('ERSH', 'SCRUB_FUNCTION', 'my_scrub_function');
```

Left unset (the default — `SCRUB_FUNCTION` is not seeded by the release at
all, since `logger_prefs.pref_value` is `not null` and there is no
"empty-but-present" value to insert), `error_summary` keeps the raw
message unchanged.

### Safety guarantees

- The function name is validated with `dbms_assert.simple_sql_name` before
  it is ever used in dynamic PL/SQL — never pass anything through that
  wasn't checked.
- If the function doesn't exist, has the wrong signature, or raises an
  exception internally, the **original, unscrubbed** message is stored and
  incident recording proceeds normally. A scrubbing failure can never break
  the caller's transaction.
- Scrubbing only ever changes what gets **stored** in `error_summary`. The
  dedup fingerprint (`ersh_error_handler_api.record_internal_incident`)
  is always computed from the raw message — scrubbing must never change
  which errors count as duplicates of each other.

### Example

```sql
create or replace function my_scrub_function(
  p_message in varchar2
) return varchar2
is
begin
  return regexp_replace(p_message, '[[:alnum:].+-]+@[[:alnum:].-]+\.[[:alpha:]]{2,}', '[EMAIL]');
end my_scrub_function;
/

exec logger.set_pref('ERSH', 'SCRUB_FUNCTION', 'MY_SCRUB_FUNCTION');
```

This is only an example — write whatever scrubbing logic fits your own
data. The point of the hook is that you decide, not this package.
