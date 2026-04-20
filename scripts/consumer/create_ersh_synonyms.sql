-- Creates synonyms in the current schema for ErrorShield objects that live in
-- another schema.
--
-- Usage (run connected as your APP schema):
--   @create_ersh_synonyms.sql ERRORSHIELD_OWNER
--
-- &1 = the schema where ErrorShield (and Logger) is installed.
--      For example, if ErrorShield was installed in the "LOGGER_USER" schema:
--        @create_ersh_synonyms.sql LOGGER_USER


set define &

-- Parameters
define from_user = '&1'


whenever sqlerror exit sql.sqlcode

prompt *** Creating ErrorShield synonyms pointing to &from_user ***

-- Packages
create or replace synonym ersh_error_handler_api for &from_user..ersh_error_handler_api;

-- Tables
create or replace synonym ersh_error_lookup      for &from_user..ersh_error_lookup;
create or replace synonym ersh_constraint_lookup for &from_user..ersh_constraint_lookup;
create or replace synonym ersh_shield_incidents  for &from_user..ersh_shield_incidents;

-- Views
create or replace synonym ersh_shield_incidents_vw for &from_user..ersh_shield_incidents_vw;

prompt *** ErrorShield synonyms created successfully ***
