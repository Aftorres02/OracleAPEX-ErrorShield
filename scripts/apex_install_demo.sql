-- =============================================================================
-- ErrorShield Demo App Install
-- =============================================================================
-- Imports the split APEXlang export that lives in apex/apex_lang/app_10401/
-- (produced by apex/apex_export_demo.sql). Mirrors scripts/apex_install.sql
-- for the real admin app (10400), kept separate since the demo is optional
-- and not part of release/_release.sql.
--
-- Run demos/demo_errorshield_app_seed.sql first (connected as the owner
-- schema) — the demo's buttons need the table and lookup rows it creates.
--
-- Assumes the current working directory is release/ (same convention as
-- scripts/apex_install.sql), so apex/apex_lang/app_10401 resolves as
-- ../apex/apex_lang/app_10401 from here.
--
-- Usage:
--   cd release
--   sql <connection>
--   @@load_env_vars.sql
--   @../demos/demo_errorshield_app_seed.sql
--   @../scripts/apex_install_demo.sql
-- =============================================================================

set serveroutput on size unlimited;
set define on;
set verify off;

prompt *** Importing ErrorShield Demo Application (schema: &env_schema_name., workspace: &env_apex_workspace.) ***
apex import -input ../apex/apex_lang/app_10401 -schema &env_schema_name. -workspace &env_apex_workspace.
