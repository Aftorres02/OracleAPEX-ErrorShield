-- If you want to add ASCII Art: https://asciiartgen.now.sh/?style=standard
-- *** DO NOT MODIFY: HEADER SECTION ***
clear screen

-- define - Sets the character used to prefix substitution variables
-- Must be set before loading env vars so & substitution works in SQLcl and SQL*Plus
set define '&'
set verify off

whenever sqlerror exit sql.sqlcode

prompt loading environment variables
@load_env_vars.sql
-- feedback - Displays the number of records returned by a script ON=1
set feedback on
-- timing - Displays the time that commands take to complete
-- set timing on
-- display dbms_output messages
set serveroutput on
-- disables blank lines in code
set sqlblanklines off;


-- Log output of release
define logname = '' -- Name of the log file

set termout on
column my_logname new_val logname
select 'release_log_'||sys_context( 'userenv', 'service_name' )|| '_' || to_char(sysdate, 'YYYY-MM-DD_HH24-MI-SS')||'.log' my_logname from dual;
-- good to clear column names when done with them
column my_logname clear
set termout on
spool &logname
prompt Log File: &logname



prompt check DB user is expected user
declare
begin
  if user != '&env_schema_name' or '&env_schema_name' is null then
    raise_application_error(-20001, 'Must be run as &env_schema_name');
  end if;
end;
/

-- Disable APEX apps
@../scripts/apex_disable.sql


-- *** END: HEADER SECTION ***


-- =============================================================================
-- 1. PREREQUISITES
-- =============================================================================
-- Exit on error: if privileges are missing the install cannot continue.
prompt *** Checking installation prerequisites ***
@../scripts/logger_install_prereqs.sql


-- =============================================================================
-- Safe mode: from this point forward errors are logged but do not abort the
-- release. All object scripts are idempotent (create-if-not-exists / create or
-- replace) so warnings like "trigger created with compilation errors" are
-- expected on first run and harmless — the final recompile resolves them.
-- =============================================================================
whenever sqlerror continue


-- =============================================================================
-- 2. TABLES
-- =============================================================================
@all_tables.sql


-- =============================================================================
-- 3. RELEASE SPECIFIC TASKS
-- =============================================================================
@code/_run_code.sql


-- =============================================================================
-- 4. VIEWS
-- =============================================================================
@all_views.sql


-- =============================================================================
-- 5. PACKAGES
-- =============================================================================
@all_packages.sql


-- =============================================================================
-- 6. TRIGGERS
-- =============================================================================
@all_triggers.sql


-- =============================================================================
-- 7. STANDALONE PROCEDURES
-- =============================================================================
@all_procedures.sql


-- =============================================================================
-- 8. LOGGER POST-INSTALL CONFIGURATION
-- =============================================================================
prompt *** Logger post-install configuration ***
@../scripts/post_install_configuration.sql


-- =============================================================================
-- 9. JOBS
-- =============================================================================
@all_jobs.sql


-- =============================================================================
-- 10. DATA
-- =============================================================================
-- Load any re-runnable data scripts
@all_data.sql


-- =============================================================================
-- 11. RECOMPILE
-- =============================================================================
prompt recompile invalid schema objects
begin
 dbms_utility.compile_schema(schema => user, compile_all => false);
end;
/


-- =============================================================================
-- 12. VALIDATE (fail if any objects remain invalid after recompile)
-- =============================================================================
prompt *** Checking for invalid objects ***

select object_name, object_type, status
  from user_objects
 where status != 'VALID'
 order by object_type, object_name;

whenever sqlerror exit sql.sqlcode

declare
  l_invalid_count pls_integer;
begin
  select count(1)
    into l_invalid_count
    from user_objects
   where status != 'VALID';

  if l_invalid_count > 0 then
    raise_application_error(
      -20002
      , l_invalid_count || ' invalid object(s) found after recompile. Review the log for details.'
    );
  end if;
end;
/


-- =============================================================================
-- 13. APEX
-- =============================================================================
whenever sqlerror continue

-- Install all apex applications
@all_apex.sql


-- Control Build Options (optional)
-- In some cases you may want to enable / disable various build options for an application depending on the environment
-- An example is provided below on how to enabled a build option
PROMPT *** APEX Build option ***

-- set serveroutput on size unlimited;
-- declare
--   c_app_id constant apex_applications.application_id%type := CHANGEME_APPLICATION_ID;
--   c_username constant varchar2(30) := user;

--   l_build_option_id apex_application_build_options.build_option_id%type;
-- begin
--   if pkg_environment.is_dev() then
--     select build_option_id
--     into l_build_option_id
--     from apex_application_build_options
--     where 1=1
--       and application_id = c_app_id
--       and build_option_name='DEV_ONLY';

--     -- Session is already active ahead
--     apex_session.create_session (
--       p_app_id => c_app_id,
--       p_page_id => 1,
--       p_username => c_username );

--     apex_util.set_build_option_status(
--       p_application_id => c_app_id,
--       p_id => l_build_option_id,
--       p_build_status=>'INCLUDE');
--   end if;

-- end;
-- /

-- commit;


prompt *** Release complete ***

spool off
exit
