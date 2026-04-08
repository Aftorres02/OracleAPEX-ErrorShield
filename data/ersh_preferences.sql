-- =============================================================================
-- Preferences (stored in logger_prefs)
-- =============================================================================
-- Re-runnable: logger.set_pref performs an upsert.
-- =============================================================================

prompt *** Loading preferences ***

begin
  -- Logger preferences
  logger.set_pref('LOGGER', 'PURGE_AFTER_DAYS', '7');
  logger.set_pref('LOGGER', 'PURGE_MIN_LEVEL', 'DEBUG');
  logger.set_pref('LOGGER', 'LOGGER_VERSION', 'x.x.x');
  logger.set_pref('LOGGER', 'LEVEL', 'DEBUG');
  logger.set_pref('LOGGER', 'PROTECT_ADMIN_PROCS', 'TRUE');
  logger.set_pref('LOGGER', 'INCLUDE_CALL_STACK', 'TRUE');
  logger.set_pref('LOGGER', 'PREF_BY_CLIENT_ID_EXPIRE_HOURS', '12');
  logger.set_pref('LOGGER', 'INSTALL_SCHEMA', sys_context('USERENV', 'CURRENT_SCHEMA'));
  logger.set_pref('LOGGER', 'PLUGIN_FN_ERROR', 'NONE');
  logger.set_pref('LOGGER', 'LOGGER_DEBUG', 'FALSE');

  -- ERSH preferences
  logger.set_pref('ERSH', 'ERSH_VERSION', '1.0.0');
  logger.set_pref('ERSH', 'SUPPORT_EMAIL', 'aftorres02@gmail.com');
  logger.set_pref('ERSH', 'REFERENCE_DISPLAY_MIN_DIGITS', '10');

  commit;
end;
/
