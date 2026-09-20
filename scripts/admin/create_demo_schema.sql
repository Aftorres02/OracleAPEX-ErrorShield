-- =============================================================================
-- create_demo_schema.sql
--
-- One-shot, non-interactive variant of create_user.sql for a throwaway demo
-- schema (see docs/DEMO.md). Run this connected as an admin user (SYS,
-- SYSTEM, or an Autonomous Database ADMIN connection), edit the `define`
-- values below first, then run the whole script in one pass (F5 in SQL
-- Developer, or @create_demo_schema.sql in SQLcl/SQL*Plus).
--
-- create_user.sql (interactive, `accept` prompts) is the generic version of
-- this for any owner schema. This one exists because `accept` always pops a
-- dialog in SQL Developer regardless of pre-set defines, which defeats
-- "run this once, hands-off" for a demo setup.
--
-- Grants the exact privilege set docs/INSTALL.md documents as required for
-- an owner schema: CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE
-- SEQUENCE, CREATE PROCEDURE, CREATE TRIGGER, CREATE ANY CONTEXT,
-- CREATE JOB (plus DROP ANY CONTEXT, needed by the Logger install itself).
--
-- Also provisions a dedicated APEX workspace for this schema (matching how
-- the real LOGGER_USER install has its own workspace, never shared with a
-- consumer app's workspace) via apex_instance_admin.add_workspace, run as
-- part of this same admin pass. NOTE: this call is not verified against a
-- live database in this repo (no DB connectivity here) -- it is the
-- standard, documented way to script APEX workspace creation, but confirm
-- it behaves as expected on your Autonomous Database before relying on it.
--
-- After this script: connect AS the new schema (a new SQL Developer
-- connection, using DEMO_SCHEMA_PASSWORD below) and run, in order:
--   1. release/_release.sql               -- installs ErrorShield + Logger
--   2. scripts/apex_install.sql           -- imports app 10400 into the new
--                                             workspace (edit env_schema_name
--                                             / env_apex_workspace in
--                                             release/load_env_vars.sql
--                                             first, or redefine them in the
--                                             same session right before this)
--   3. demos/demo_data_generator_run.sql  -- installs and runs the generator
--
-- No synonym/grant-to-consumer script is needed here. This schema is a full
-- owner install (it has its own copy of every table) -- synonyms
-- (scripts/consumer/create_ersh_synonyms.sql etc.) are only for a separate
-- application schema (like an invoices_sch) that wants to call
-- ersh_error_handler_api without owning any of its objects. Any error
-- raised through that real path still lands in the OWNER schema's tables
-- (definer's rights) -- never in the consumer schema -- so a consumer can
-- never be a substitute for this owner install. ersh_demo_data_api also
-- does direct INSERT/DELETE on the core tables, which a consumer schema's
-- select-only grants (see scripts/grant_ersh_to_user.sql) would not permit
-- even if that were the goal.
--
-- @ticket ERSH-046
-- =============================================================================

-- ---------------------------------------------------------------------------
-- EDIT THESE before running.
-- DEMO_TABLESPACE/DEMO_TEMP_TABLESPACE: on Autonomous Database this is
-- usually DATA / TEMP, not USERS / TEMP -- check with:
--   select tablespace_name from dba_tablespaces;
-- ---------------------------------------------------------------------------
define demo_schema_name     = ERSH_DEMO_USER
define demo_schema_password = CHANGE_ME_STRONG_PASSWORD
define demo_tablespace      = DATA
define demo_temp_tablespace = TEMP
define demo_workspace_name  = ERSH_DEMO_WS

set define '&'
set verify off
whenever sqlerror exit sql.sqlcode

prompt *** Creating demo schema &demo_schema_name. ***

create user &demo_schema_name identified by &demo_schema_password
  default tablespace &demo_tablespace
  temporary tablespace &demo_temp_tablespace
/

alter user &demo_schema_name quota unlimited on &demo_tablespace
/

grant connect
    , create view
    , create job
    , create table
    , create sequence
    , create trigger
    , create procedure
    , create any context
    , drop any context
   to &demo_schema_name
/

prompt *** Creating APEX workspace &demo_workspace_name. for &demo_schema_name. ***

begin
  apex_instance_admin.add_workspace(
      p_workspace      => '&demo_workspace_name.'
    , p_primary_schema => '&demo_schema_name.'
  );
  commit;
end;
/

prompt
prompt *** &demo_schema_name. and workspace &demo_workspace_name. created. ***
prompt *** Next: connect AS &demo_schema_name. and run, in order: ***
prompt ***   1. release/_release.sql ***
prompt ***   2. scripts/apex_install.sql (env_schema_name / env_apex_workspace ***
prompt ***      must point at &demo_schema_name. / &demo_workspace_name. first) ***
prompt ***   3. demos/demo_data_generator_run.sql ***
prompt
