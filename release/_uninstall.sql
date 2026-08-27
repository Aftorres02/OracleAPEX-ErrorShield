-- =============================================================================
-- _uninstall.sql
--
-- Drops every object created by release/_release.sql, leaving the schema as
-- if it had never been installed. Use this to reset a schema before testing
-- a "first run" install.
--
-- Objects are dropped in the REVERSE order they are created in _release.sql
-- (jobs -> context -> procedures -> packages -> views -> tables -> sequences)
-- so dependencies never block a drop.
--
-- This script is idempotent: it is safe to run against a schema that is
-- already partially or fully clean, or where the release only partially
-- installed.
-- =============================================================================
clear screen
set define '&'
set verify off
set serveroutput on

whenever sqlerror exit sql.sqlcode

prompt loading environment variables
@@load_env_vars.sql

prompt check DB user is expected user
declare
begin
  if upper(user) != upper('&env_schema_name') or '&env_schema_name' is null then
    raise_application_error(-20001, 'Must be run as &env_schema_name');
  end if;
end;
/

whenever sqlerror continue


-- =============================================================================
-- 1. JOBS
-- =============================================================================
prompt *** Dropping jobs ***

begin
  dbms_scheduler.drop_job(job_name => 'LOGGER_PURGE_JOB', force => true);
exception
  when others then
    if sqlcode != -27475 then raise; end if;
end;
/

begin
  dbms_scheduler.drop_job(job_name => 'LOGGER_UNSET_PREFS_BY_CLIENT', force => true);
exception
  when others then
    if sqlcode != -27475 then raise; end if;
end;
/


-- =============================================================================
-- 2. LOGGER GLOBAL CONTEXT
-- =============================================================================
prompt *** Dropping Logger global context ***

declare
  l_ctx_name varchar2(35) := substr(sys_context('USERENV','CURRENT_SCHEMA'),1,23)||'_LOGCTX';
begin
  execute immediate 'drop context '||l_ctx_name;
exception
  when others then
    -- ORA-01435: context does not exist (already dropped, fine)
    -- ORA-01031/ORA-41726: schema lacks DROP ANY CONTEXT (grant it via
    -- scripts/admin/create_user.sql, or ask a DBA to run this drop manually)
    if sqlcode not in (-1435, -1031) then
      raise;
    else
      dbms_output.put_line('Skipped: could not drop context '||l_ctx_name||' ('||sqlerrm||')');
    end if;
end;
/


-- =============================================================================
-- 3. STANDALONE PROCEDURES
-- =============================================================================
prompt *** Dropping standalone procedures ***

drop procedure logger_configure;


-- =============================================================================
-- 4. PACKAGES
-- =============================================================================
prompt *** Dropping packages ***

drop package ersh_error_handler_api;
drop package logger;


-- =============================================================================
-- 5. VIEWS
-- =============================================================================
prompt *** Dropping views ***

drop view ersh_shield_incidents_vw;
drop view logger_logs_terse;
drop view logger_logs_60_min;
drop view logger_logs_5_min;


-- =============================================================================
-- 6. TABLES (cascade constraints handles FKs regardless of drop order)
-- =============================================================================
prompt *** Dropping tables ***

drop table ersh_shield_incidents cascade constraints purge;
drop table ersh_error_lookup cascade constraints purge;
drop table ersh_constraint_lookup cascade constraints purge;

drop table logger_prefs_by_client_id cascade constraints purge;
drop table logger_logs_apex_items cascade constraints purge;
drop table logger_logs cascade constraints purge;
drop table logger_prefs cascade constraints purge;


-- =============================================================================
-- 7. SEQUENCES
-- =============================================================================
prompt *** Dropping sequences ***

drop sequence logger_apx_items_seq;
drop sequence logger_logs_seq;


-- =============================================================================
-- 8. VERIFY: nothing ERSH_*/LOGGER_* should remain
-- =============================================================================
prompt *** Remaining ERSH/LOGGER objects (should be empty) ***

select object_name, object_type, status
  from user_objects
 where object_name like 'ERSH\_%'      escape '\'
    or object_name  = 'LOGGER'
    or object_name like 'LOGGER\_%'    escape '\'
 order by object_type, object_name;

prompt *** Uninstall complete ***
