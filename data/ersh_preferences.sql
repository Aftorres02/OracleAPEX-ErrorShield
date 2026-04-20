-- =============================================================================
-- ERSH preferences (stored in logger_prefs with pref_type = 'ERSH')
-- =============================================================================
-- Re-runnable and NON-DESTRUCTIVE:
--   * Fresh install          -> seeds ERSH_VERSION, SUPPORT_EMAIL and
--                               REFERENCE_DISPLAY_MIN_DIGITS with their defaults.
--   * Pref already present   -> existing pref_value is preserved (admins can
--                               change these after install without the release
--                               reverting their changes).
--
-- NOTE: Intentionally does NOT call logger.set_level. The Logger LEVEL pref
-- is seeded (only on fresh install) by tables/logger_prefs.sql. If you need
-- to change the Logger level in an environment, do it manually with
-- logger.set_level() after the release completes; the release will not
-- touch the value on future runs.
-- =============================================================================

prompt *** Loading ERSH preferences (insert-if-missing) ***

merge into logger_prefs p
using (
  select 'ERSH' as pref_type, 'ERSH_VERSION'                 as pref_name, '1.0.0'                 as pref_value from dual union all
  select 'ERSH'              , 'SUPPORT_EMAIL'                             , 'aftorres02@gmail.com'              from dual union all
  select 'ERSH'              , 'REFERENCE_DISPLAY_MIN_DIGITS'              , '10'                                from dual
) d
on (p.pref_type = d.pref_type and p.pref_name = d.pref_name)
when not matched then
  insert (p.pref_type, p.pref_name, p.pref_value)
  values (d.pref_type, d.pref_name, d.pref_value);

commit;
