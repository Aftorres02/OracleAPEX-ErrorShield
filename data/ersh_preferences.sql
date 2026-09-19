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
  -- support@example.com: example.com is reserved by RFC 2606, so nobody can
  -- register it. Left on the default, a message bounces instead of landing
  -- on someone else's real domain (ERSH-018). post_install_configuration.sql
  -- warns if this is still the default after install.
  select 'ERSH'              , 'SUPPORT_EMAIL'                             , 'support@example.com'               from dual union all
  select 'ERSH'              , 'REFERENCE_DISPLAY_MIN_DIGITS'              , '10'                                from dual union all
  -- ERSH_PURGE_AFTER_DAYS: retention window (in days) for purge_incidents /
  -- jobs/ersh_purge_job.sql (ERSH-026, not scheduled by the release — see
  -- docs/OBSERVABILITY.md to activate it). Must stay GREATER than Logger's
  -- own PURGE_AFTER_DAYS (7, tables/logger_prefs.sql): if logger_logs is
  -- already purged by the time a user reports a reference code, the
  -- incident it points to still has to exist for the DEV main to find it.
  select 'ERSH'              , 'ERSH_PURGE_AFTER_DAYS'                     , '90'                                from dual union all
  -- SCRUB_FUNCTION is intentionally NOT seeded here. logger_prefs.pref_value
  -- is NOT NULL, so there is no empty-but-present value to insert — and
  -- logger.get_pref on a pref row that doesn't exist already returns null,
  -- which is exactly the inert default ERSH-032 wants. To enable scrubbing,
  -- set it to a function(p_message varchar2) return varchar2 you implement:
  --   logger.set_pref('ERSH', 'SCRUB_FUNCTION', 'my_scrub_function');
  -- See docs/OBSERVABILITY.md for the contract and an example.
  -- ENVIRONMENT is just the label of the current database.
  -- Admins are free to use any name they want (DEV, TEST, QA, STAGE, PROD,
  -- HOTFIX, ...). It is matched against MASK_IN_ENVIRONMENTS to decide
  -- whether to mask user-facing error messages.
  select 'ERSH'              , 'ENVIRONMENT'                               , 'PROD'                              from dual union all
  -- MASK_IN_ENVIRONMENTS is a comma-separated list of environments where
  -- internal APEX errors must be hidden behind a generic reference message.
  -- Matching against ENVIRONMENT is case-insensitive and whitespace-tolerant.
  --
  -- Examples:
  --   'TEST,PROD'       -> mask in TEST and PROD, raw errors in DEV  (default)
  --   'PROD'            -> mask only in PROD
  --   'DEV,TEST,PROD'   -> mask everywhere
  --   ''  or  null      -> never mask (always show raw errors)
  --
  -- Change per environment, e.g.:
  --   update logger_prefs set pref_value = 'PROD'
  --    where pref_type = 'ERSH' and pref_name = 'MASK_IN_ENVIRONMENTS';
  select 'ERSH'              , 'MASK_IN_ENVIRONMENTS'                      , 'TEST,PROD'                         from dual
) d
on (p.pref_type = d.pref_type and p.pref_name = d.pref_name)
when not matched then
  insert (p.pref_type, p.pref_name, p.pref_value)
  values (d.pref_type, d.pref_name, d.pref_value);

commit;
