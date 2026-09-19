-- =============================================================================
-- demo_data_generator_run.sql
--
-- Installs ersh_demo_data_api and runs generate_all_demo_data with sensible
-- defaults, so the admin app (10400) has enough data for a live community
-- demo instead of empty reports and dashboards.
--
-- Run this connected as the ErrorShield owner schema, AFTER release/_release.sql
-- has already installed ErrorShield itself. See docs/DEMO.md for the full
-- setup walkthrough, what this does and does not cover, and how to reset.
--
-- Not part of release/_release.sql — this is demo-only tooling, never run
-- against a schema with real incidents/logs in it. Everything it generates
-- is tagged for exact removal later via ersh_demo_data_api.purge_demo_data.
--
-- @ticket ERSH-046
-- =============================================================================
set define off
set serveroutput on size unlimited

prompt *** Installing ersh_demo_data_api ***
@@ersh_demo_data_api.pks
@@ersh_demo_data_api.pkb

prompt *** Generating demo data (this takes a minute or two) ***
begin
  ersh_demo_data_api.generate_all_demo_data;
end;
/

prompt *** Done. See docs/DEMO.md for what still needs a manual step ***
prompt *** (the "Running now" and "APEX Automations" dashboards). ***
