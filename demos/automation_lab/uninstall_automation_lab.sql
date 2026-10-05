-- =============================================================================
-- ErrorShield Automation Lab — uninstall (owner schema)
-- =============================================================================
-- Removes everything install_automation_lab.sql created: app 10403 (and with
-- it its ten automations and their APEX-managed schedules) and the
-- ersh_demo_automation_api package.
--
-- Leaves the incidents the lab's failing automations already recorded alone —
-- they are real history, cleared the normal way (resolve, or
-- ersh_error_handler_api.purge_incidents) from the admin app. APEX keeps the
-- automation log rows on its own retention, independent of the app.
--
-- Usage (connected as the ErrorShield owner schema):
--   @demos/automation_lab/uninstall_automation_lab.sql <APEX_WORKSPACE>
--
-- &1 = APEX workspace that owns the ErrorShield schema.
--
-- @ticket ERSH-050
-- =============================================================================

set serveroutput on size unlimited;
set define on;
set verify off;

define alab_workspace = '&1'
define alab_app_id    = 10403

whenever sqlerror exit sql.sqlcode


prompt *** Removing app &alab_app_id. from workspace &alab_workspace. ***

declare
  l_count pls_integer;
begin
  select count(1)                                                   as app_count
    into l_count
    from apex_applications a
   where a.application_id = &alab_app_id.;

  if l_count > 0 then
    apex_application_install.set_workspace(
        p_workspace                     => '&alab_workspace.'
    );
    apex_application_install.remove_application(
        p_application_id                => &alab_app_id.
    );
    commit;
  end if;
end;
/


prompt *** Dropping ersh_demo_automation_api ***

declare
  l_count pls_integer;
begin
  select count(1)                                                   as object_count
    into l_count
    from user_objects o
   where o.object_type = 'PACKAGE'
     and o.object_name = 'ERSH_DEMO_AUTOMATION_API';

  if l_count > 0 then
    execute immediate 'drop package ersh_demo_automation_api';
  end if;
end;
/

prompt *** Automation Lab removed ***
