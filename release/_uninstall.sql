-- =============================================================================
-- _uninstall.sql
--
-- Drops every object created by release/_release.sql, leaving the schema as
-- if it had never been installed. Use this to reset a schema before testing
-- a "first run" install.
--
-- Objects are dropped in the REVERSE order they are created in _release.sql
-- (jobs -> context -> procedures -> packages -> views -> tables -> sequences)
-- so dependencies never block a drop. Objects that don't exist are skipped.
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
-- 3-7. PROCEDURES, PACKAGES, VIEWS, TABLES, SEQUENCES
-- =============================================================================
-- Each object is dropped only if it exists, so running this on an empty
-- schema (every CI run does) prints "Skipped" lines instead of ORA-04043 /
-- ORA-00942 errors, and any ERROR line that does appear here is real.
prompt *** Dropping procedures, packages, views, tables and sequences ***

declare
  procedure drop_if_exists(
      p_object_type                             in user_objects.object_type%type
    , p_object_name                             in user_objects.object_name%type
    , p_drop_options                            in varchar2 default null
  )
  is
    l_count pls_integer;
  begin
    select count(1)
      into l_count
      from user_objects o
     where o.object_type = p_object_type
       and o.object_name = p_object_name;

    if l_count = 0 then
      dbms_output.put_line('Skipped (not found): ' || lower(p_object_type) || ' ' || lower(p_object_name));
      return;
    end if;

    execute immediate 'drop ' || p_object_type || ' ' || dbms_assert.enquote_name(p_object_name) || p_drop_options;
    dbms_output.put_line('Dropped: ' || lower(p_object_type) || ' ' || lower(p_object_name));
  exception
    when others then
      dbms_output.put_line('ERROR dropping ' || lower(p_object_type) || ' ' || lower(p_object_name) || ': ' || sqlerrm);
  end drop_if_exists;
begin
  -- Standalone procedures
  drop_if_exists('PROCEDURE',  'LOGGER_CONFIGURE');

  -- Packages
  drop_if_exists('PACKAGE',    'ERSH_ERROR_HANDLER_API');
  drop_if_exists('PACKAGE',    'LOGGER');

  -- Views
  drop_if_exists('VIEW',       'ERSH_APEX_AUTOMATION_MESSAGES_VW');
  drop_if_exists('VIEW',       'ERSH_APEX_AUTOMATION_EXECUTIONS_VW');
  drop_if_exists('VIEW',       'ERSH_APEX_AUTOMATIONS_VW');
  drop_if_exists('VIEW',       'ERSH_JOBS_RUNNING_VW');
  drop_if_exists('VIEW',       'ERSH_JOB_EXECUTIONS_VW');
  drop_if_exists('VIEW',       'ERSH_JOB_DETAILS_VW');
  drop_if_exists('VIEW',       'ERSH_JOBS_INVENTORY_VW');
  drop_if_exists('VIEW',       'ERSH_JOBS_RECENT_FAILURES_VW');
  drop_if_exists('VIEW',       'ERSH_JOBS_NEXT_RUNS_VW');
  drop_if_exists('VIEW',       'ERSH_JOBS_HEALTH_BY_SOURCE_VW');
  drop_if_exists('VIEW',       'ERSH_JOBS_STATUS_VW');
  drop_if_exists('VIEW',       'ERSH_RELATED_LOGS_VW');
  drop_if_exists('VIEW',       'ERSH_INCIDENT_OCCURRENCES_VW');
  drop_if_exists('VIEW',       'ERSH_SHIELD_INCIDENTS_VW');
  drop_if_exists('VIEW',       'LOGGER_LOGS_TERSE');
  drop_if_exists('VIEW',       'LOGGER_LOGS_60_MIN');
  drop_if_exists('VIEW',       'LOGGER_LOGS_5_MIN');

  -- Tables (cascade constraints handles FKs regardless of drop order)
  drop_if_exists('TABLE',      'ERSH_INCIDENT_OCCURRENCES', ' cascade constraints purge');
  drop_if_exists('TABLE',      'ERSH_SHIELD_INCIDENTS',     ' cascade constraints purge');
  drop_if_exists('TABLE',      'ERSH_ERROR_LOOKUP',         ' cascade constraints purge');
  drop_if_exists('TABLE',      'ERSH_CONSTRAINT_LOOKUP',    ' cascade constraints purge');
  drop_if_exists('TABLE',      'LOGGER_PREFS_BY_CLIENT_ID', ' cascade constraints purge');
  drop_if_exists('TABLE',      'LOGGER_LOGS_APEX_ITEMS',    ' cascade constraints purge');
  drop_if_exists('TABLE',      'LOGGER_LOGS',               ' cascade constraints purge');
  drop_if_exists('TABLE',      'LOGGER_PREFS',              ' cascade constraints purge');

  -- Sequences
  drop_if_exists('SEQUENCE',   'LOGGER_APX_ITEMS_SEQ');
  drop_if_exists('SEQUENCE',   'LOGGER_LOGS_SEQ');
end;
/


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
