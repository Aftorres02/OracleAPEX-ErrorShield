-- =============================================================================
-- Preferences (stored in logger_prefs)
-- =============================================================================
-- Re-runnable: logger.set_pref performs an upsert.
-- =============================================================================

prompt *** Loading preferences ***

begin
  -- LOGGER-type preferences are managed by Logger itself during install.
  -- Do not call logger.set_pref with pref_type='LOGGER' — it is reserved
  -- and will raise ORA-20001. Use logger.set_level / logger.purge instead.
  -- Set to DEBUG for development, ERROR for production.
  -- All Logger level constants are prefixed with g_ (e.g. g_debug_name, g_error_name).
  logger.set_level(p_level => logger.g_debug_name);

  -- ERSH preferences (custom type; logger.set_pref performs an upsert)
  logger.set_pref('ERSH', 'ERSH_VERSION', '1.0.0');
  logger.set_pref('ERSH', 'SUPPORT_EMAIL', 'aftorres02@gmail.com');
  logger.set_pref('ERSH', 'REFERENCE_DISPLAY_MIN_DIGITS', '10');

  commit;
end;
/
