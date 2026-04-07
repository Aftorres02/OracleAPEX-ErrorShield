-- Post installation configuration tasks
PROMPT Calling ersh_logger_configure
begin
  ersh_logger_configure;
end;
/


-- Only set level if not in DEBUG mode
PROMPT Setting Logger Level
declare
  l_current_level ersh_logger_prefs.pref_value%type;
begin

  select pref_value
  into l_current_level
  from ersh_logger_prefs
  where 1=1
    and pref_type = ersh_logger.g_pref_type_logger
    and pref_name = 'LEVEL';

  -- Note: Probably not necessary but pre 1.4.0 code had this in place
  ersh_logger.set_level(l_current_level);
end;
/

prompt
prompt *************************************************
prompt Now executing LOGGER.STATUS...
prompt

begin
	ersh_logger.status;
end;
/

prompt *************************************************
begin
	ersh_logger.log_permanent('Logger version '||ersh_logger.get_pref('LOGGER_VERSION')||' installed.');
end;
/
