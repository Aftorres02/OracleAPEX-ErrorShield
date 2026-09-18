-- Post installation configuration tasks
PROMPT Calling logger_configure
begin
  logger_configure;
end;
/


-- Only set level if not in DEBUG mode
PROMPT Setting Logger Level
declare
  l_current_level logger_prefs.pref_value%type;
begin

  select pref_value
  into l_current_level
  from logger_prefs
  where 1=1
    and pref_type = logger.g_pref_type_logger
    and pref_name = 'LEVEL';

  -- Note: Probably not necessary but pre 1.4.0 code had this in place
  logger.set_level(l_current_level);
end;
/

prompt
prompt *************************************************
prompt Now executing LOGGER.STATUS...
prompt

begin
	logger.status;
end;
/

prompt *************************************************
begin
	logger.log_permanent('Logger version '||logger.get_pref('LOGGER_VERSION')||' installed.');
end;
/


-- ERSH-018: SUPPORT_EMAIL ships as a placeholder (support@example.com,
-- reserved by RFC 2606 so it bounces rather than reaching a real inbox).
-- Warn on every release run until an admin sets a real address.
prompt *************************************************
prompt ErrorShield post-install configuration
declare
  l_support_email logger_prefs.pref_value%type;
begin
  l_support_email := logger.get_pref('SUPPORT_EMAIL', 'ERSH');

  if l_support_email = 'support@example.com' then
    dbms_output.put_line('*** WARNING: ERSH SUPPORT_EMAIL is still the placeholder default (support@example.com). ***');
    dbms_output.put_line('*** Set a real address before going live: logger.set_pref(''ERSH'', ''SUPPORT_EMAIL'', ''your-team@example.org''); ***');
  end if;
end;
/
