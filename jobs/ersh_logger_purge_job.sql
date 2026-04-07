declare
  l_count pls_integer;
  l_job_name user_scheduler_jobs.job_name%type := 'ERSH_LOGGER_PURGE_JOB';
begin
  
  select count(1)
  into l_count
  from user_scheduler_jobs
  where job_name = l_job_name;
  
  if l_count = 0 then
    dbms_scheduler.create_job(
       job_name => l_job_name,
       job_type => 'PLSQL_BLOCK',
       job_action => 'begin ersh_logger.purge; end; ',
       start_date => systimestamp,
       repeat_interval => 'FREQ=DAILY; BYHOUR=1',
       enabled => TRUE,
       comments => 'Purges ersh_logger_logs using default values defined in ersh_logger_prefs.');
  end if;
end;
/