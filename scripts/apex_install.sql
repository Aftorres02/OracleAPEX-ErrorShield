-- =============================================================================
-- APEX Application Install
-- =============================================================================
-- Imports the split APEXlang export that lives in apex/apex_lang/ (produced by
-- apex/apex_export.sql: `apex export -applicationid 10400 -dir apex -split
-- -expType READABLE_YAML`). The application id is read from
-- apex/apex_lang/deployments/default.json (currently 10400); schema and
-- workspace are read from env_schema_name / env_apex_workspace, defined in
-- release/load_env_vars.sql.
--
-- Assumes the current working directory is release/ (the documented entry
-- point for a release, see release/README.md), so apex/apex_lang/ resolves
-- as ../apex/apex_lang from here.
--
-- Usage (as part of a release):
--   @@../scripts/apex_install.sql   -- called from release/all_apex.sql
--
-- Usage (standalone):
--   cd release
--   sql <connection>
--   @@load_env_vars.sql
--   @../scripts/apex_install.sql
-- =============================================================================

set serveroutput on size unlimited;
set define on;
set verify off;

prompt *** Importing APEX Application (schema: &env_schema_name., workspace: &env_apex_workspace.) ***
apex import -input ../apex/apex_lang -schema &env_schema_name. -workspace &env_apex_workspace.
