-- =============================================================================
-- ErrorShield Automation Lab — install (owner schema)
-- =============================================================================
-- Installs the Automation Lab demo app (10403): ten APEX Automations whose only
-- purpose is to give the admin app's "APEX Automations" page (10400, page
-- 1600) real automations, executions and messages to show.
--
-- Why the OWNER workspace and not a consumer one: page 1600 reads APEX's own
-- dictionary views (apex_appl_automations, apex_automation_log,
-- apex_automation_msg_log). Inside an APEX session those views only return
-- the workspace the running app belongs to, so an automation in a consumer
-- workspace can never appear on 10400's page 1600.
--
-- Not part of release/_release.sql — like the 10401 demo, it is optional.
--
-- Usage (connected as the ErrorShield owner schema, from the repo root). The
-- apex import path below is relative to THIS script's folder — SQLcl 26.2
-- resolves `apex import -input` from the running script, not from the
-- working directory:
--   sql <owner-connection>
--   @demos/automation_lab/install_automation_lab.sql <APEX_WORKSPACE>
--
-- &1 = APEX workspace that owns the ErrorShield schema (the one 10400 lives in).
--
-- Re-runnable: the package is create-or-replace and the import targets the
-- fixed id 10403 (a plain `apex import` without -id mints a new id on every
-- run).
--
-- @ticket ERSH-050
-- =============================================================================

set serveroutput on size unlimited;
set define on;
set verify off;

define alab_workspace = '&1'
define alab_app_id    = 10403

column alab_schema new_value alab_schema noprint
select user as alab_schema
  from dual;

whenever sqlerror exit sql.sqlcode


prompt *** Installing ersh_demo_automation_api in &alab_schema. ***
set define off
@@ersh_demo_automation_api.pks
@@ersh_demo_automation_api.pkb
set define on

declare
  l_count pls_integer;
begin
  select count(1)                                                   as object_count
    into l_count
    from user_objects
   where object_name = 'ERSH_DEMO_AUTOMATION_API'
     and status      = 'INVALID';

  if l_count > 0 then
    raise_application_error(
        -20001
      , 'ersh_demo_automation_api is INVALID. Is ErrorShield installed in this schema?'
    );
  end if;
end;
/


prompt *** Importing Automation Lab app &alab_app_id. (schema: &alab_schema., workspace: &alab_workspace.) ***
apex import -input ../../apex/apex_lang/app_10403 -id &alab_app_id. -schema &alab_schema. -workspace &alab_workspace.


prompt *** Enabling schedules (apex import brings every schedule in as Disabled) ***
begin
  ersh_demo_automation_api.enable_schedules;
end;
/


prompt *** Running every enabled automation once, so page 1600 has executions ***
begin
  ersh_demo_automation_api.execute_all;
end;
/

prompt *** Automation Lab installed. Open 10400 > Jobs > APEX Automations. ***
