drop package ersh_logger
/

drop procedure ersh_logger_configure
/

drop table ersh_logger_logs_apex_items cascade constraints
/

drop table ersh_logger_prefs cascade constraints
/

drop table ersh_logger_logs cascade constraints
/

drop table ersh_logger_prefs_by_client_id cascade constraints
/

drop sequence ersh_logger_logs_seq
/

drop sequence ersh_logger_apx_items_seq
/


begin
	dbms_scheduler.drop_job('ERSH_LOGGER_PURGE_JOB');
exception
  when others then
    if sqlcode != -27475 then raise; end if; -- ORA-27475: job does not exist
end;
/

begin
	dbms_scheduler.drop_job('ERSH_LOGGER_UNSET_PREFS_BY_CLIENT');
exception
  when others then
    if sqlcode != -27475 then raise; end if;
end;
/

-- Legacy OraOpenSource Logger job names (pre-ersh_ rename)
begin
	dbms_scheduler.drop_job('LOGGER_PURGE_JOB');
exception
  when others then
    if sqlcode != -27475 then raise; end if;
end;
/

begin
	dbms_scheduler.drop_job('LOGGER_UNSET_PREFS_BY_CLIENT');
exception
  when others then
    if sqlcode != -27475 then raise; end if;
end;
/

drop view ersh_logger_logs_5_min
/

drop view ersh_logger_logs_60_min
/

drop view ersh_logger_logs_terse
/

