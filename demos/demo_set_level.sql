-- Logger demo file

exec ersh_logger.set_level(ersh_logger.g_debug);

exec ersh_logger.log('test, this should show up');

select *
from ersh_logger_logs_5_min
order by id desc;

exec ersh_logger.set_level (ersh_logger.g_error);

exec ersh_logger.log('test, this should not show up');

select *
from ersh_logger_logs_5_min
order by id desc;

-- In a different client run the following

exec dbms_session.set_identifier('logger_demo_session');

exec ersh_logger.set_level(ersh_logger.g_debug, sys_context('userenv','client_identifier'));

exec ersh_logger.log('test, this should show up for client_id: ' || sys_context('userenv','client_identifier'));

select *
from ersh_logger_logs_5_min
order by id desc;

-- In main client run the following

exec ersh_logger.log('this should not show up since the global config is error');

select *
from ersh_logger_logs_5_min
order by id desc;


-- In other client clear identifier to return to global config

exec dbms_session.clear_identifier;


-- Unset all client specific level settings
exec ersh_logger.unset_client_level_all;



-- TODO move to seperate file?
-- How does this work for batches?

create or replace procedure run_long_batch(
  p_client_id in varchar2,
  p_iterations in pls_integer)
as
  l_params ersh_logger.tab_param;
  l_scope ersh_logger_logs.scope%type := 'run_long_batch';
begin
  ersh_logger.append_param(l_params, 'p_client_id', p_client_id);
  ersh_logger.append_param(l_params, 'p_iterations', p_iterations);
  ersh_logger.log('START', l_scope, null, l_params);

  dbms_session.set_identifier(p_client_id);

  for i in 1..p_iterations loop
    ersh_logger.log('i: ' || i, l_scope);
    dbms_lock.sleep(1);
  end loop;

  ersh_logger.log('END');

end run_long_batch;
/


-- Setup
begin
  delete from ersh_logger_logs;
  ersh_logger.set_level(ersh_logger.g_error); -- Simulates Production
  ersh_logger.unset_client_level_all;
  commit;
end;
/

-- In SQL Plus
begin
  run_long_batch(p_client_id => 'in_sqlplus', p_iterations => 50);
end;
/


-- In SQL Dev
exec ersh_logger.set_level(ersh_logger.g_debug, 'in_sqlplus');

exec ersh_logger.unset_client_level('in_sqlplus');

exec ersh_logger.set_level(ersh_logger.g_debug, 'in_sqlplus');

exec ersh_logger.unset_client_level('in_sqlplus');

select logger_level, line_no, text, time_stamp, scope
from ersh_logger_logs
order by id
;

-- Reset Logging Level
exec ersh_logger.set_level(ersh_logger.g_debug);
