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
-- After this script: connect AS the new schema (a new SQL Developer
-- connection, using DEMO_SCHEMA_PASSWORD below) and run, in order:
--   1. release/_release.sql               -- installs ErrorShield + Logger
--   2. demos/demo_data_generator_run.sql  -- installs and runs the generator
--
-- No synonym/grant-to-consumer script is needed here. This schema is a full
-- owner install (it has its own copy of every table) -- synonyms
-- (scripts/consumer/create_ersh_synonyms.sql etc.) are only for a separate
-- application schema that wants to call ersh_error_handler_api without
-- owning any of its objects. ersh_demo_data_api does direct INSERT/DELETE
-- on the core tables, which a consumer schema's select-only grants (see
-- scripts/grant_ersh_to_user.sql) would not permit.
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

prompt
prompt *** &demo_schema_name. created. ***
prompt *** Next: connect AS &demo_schema_name. and run: ***
prompt ***   1. release/_release.sql ***
prompt ***   2. demos/demo_data_generator_run.sql ***
prompt
