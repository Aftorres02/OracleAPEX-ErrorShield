create or replace package ersh_demo_automation_api is
-- =============================================================================
-- Package: ersh_demo_automation_api
-- Purpose: Support code for the ErrorShield Automation Lab demo app (10403),
--          whose only job is to own ten APEX Automations so the admin app's
--          "APEX Automations" page (10400, page 1600) has real automations,
--          executions and messages to show.
--
-- Page 1600 reads APEX's own dictionary views (apex_appl_automations,
-- apex_automation_log, apex_automation_msg_log), which only return the
-- workspace the app runs in — so the lab app lives in the ErrorShield owner
-- workspace, next to 10400. Demo-only: never referenced by
-- release/_release.sql or any *_api package that is part of the real
-- product surface.
--
-- @ticket ERSH-050
-- =============================================================================

  gc_application_id constant number := 10403;


  /**
   * Records a failed automation action in ErrorShield: one logger_logs error
   * row plus one ersh_shield_incidents hit (component "Automations"). Called
   * from an action's own exception handler, right before it re-raises, so the
   * failure shows up both on page 1600 and on the Incidents page. Never
   * raises — a failure in observability must not mask the action's own error.
   *
   * @example
   *   begin
   *     execute immediate 'select 1 from ersh_demo_missing_table';
   *   exception
   *     when others then
   *       ersh_demo_automation_api.report_failure(
   *           p_static_id     => 'nightly-archive-export'
   *         , p_sqlcode       => sqlcode
   *         , p_error_message => sqlerrm
   *       );
   *       raise;
   *   end;
   *   /
   *
   * @issue ERSH-050
   * @author Angel Flores (Consultant)
   * @created October 4, 2026
   *
   * @param p_static_id     Static ID of the automation whose action failed.
   * @param p_sqlcode       sqlcode of the error being handled.
   * @param p_error_message sqlerrm of the error being handled.
   */
  procedure report_failure(
      p_static_id                               in varchar2
    , p_sqlcode                                 in number
    , p_error_message                           in varchar2
  );


  /**
   * Enables the schedule of every scheduled automation in the lab app except
   * the ones meant to stay disabled (gc_always_disabled). `apex import`
   * brings every scheduled automation in as Disabled, whatever the source
   * says, so the install script calls this right after the import. Opens
   * (and closes) its own APEX session for app 10403.
   *
   * @example
   *   set serveroutput on
   *   begin
   *     ersh_demo_automation_api.enable_schedules;
   *     dbms_output.put_line('Automation Lab schedules enabled.');
   *   end;
   *   /
   *
   * @issue ERSH-050
   * @author Angel Flores (Consultant)
   * @created October 4, 2026
   */
  procedure enable_schedules;


  /**
   * Runs every enabled automation of the lab app once, right now, through
   * apex_automation.execute — so page 1600's "Executions · 7 days" and
   * "Messages" regions have data without waiting for each schedule. Opens
   * (and closes) its own APEX session for app 10403. Automations that fail on
   * purpose are logged as a warning and do not stop the rest.
   *
   * @example
   *   set serveroutput on
   *   begin
   *     ersh_demo_automation_api.execute_all;
   *     dbms_output.put_line('Automation Lab executions done.');
   *   end;
   *   /
   *
   * @issue ERSH-050
   * @author Angel Flores (Consultant)
   * @created October 4, 2026
   */
  procedure execute_all;


end ersh_demo_automation_api;
/
