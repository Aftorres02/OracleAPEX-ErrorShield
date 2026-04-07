set serveroutput on

create or replace procedure log_test_plugin(
  p_rec in ersh_logger.rec_ersh_logger_log)
as
  l_text ersh_logger_logs.text%type;
begin
  dbms_output.put_line('In Plugin');

  ersh_logger.log_error('Wont call plugin since recursion / infinite loop would occur');
end;
/

exec ersh_logger.set_level(p_level => ersh_logger.g_debug);

update ersh_logger_prefs
  set pref_value = 'log_test_plugin'
  where 1=1
    and pref_type = 'LOGGER'
    and pref_name = 'PLUGIN_FN_ERROR';

exec ersh_logger_configure;


declare
begin
  ersh_logger.log_error('test');
end;
/
