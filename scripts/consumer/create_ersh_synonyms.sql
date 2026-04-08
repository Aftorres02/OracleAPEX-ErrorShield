-- Creates synonyms in the current schema for ErrorShield objects that live in
-- another schema.
--
-- Usage (run connected as your APP schema):
--   @create_ersh_synonyms.sql ERRORSHIELD_OWNER
--
-- &1 = the schema where ErrorShield (and Logger) is installed.
--      For example, if ErrorShield was installed in the "CORE_DB" schema:
--        @create_ersh_synonyms.sql CORE_DB


-- Parameters
define from_user = '&1'


whenever sqlerror exit sql.sqlcode

prompt *** Creating ErrorShield synonyms pointing to &from_user ***

create or replace synonym ersh_error_handler_api for &from_user..ersh_error_handler_api;
create or replace synonym ersh_error_lookup for &from_user..ersh_error_lookup;
create or replace synonym ersh_constraint_lookup for &from_user..ersh_constraint_lookup;

prompt *** ErrorShield synonyms created successfully ***
