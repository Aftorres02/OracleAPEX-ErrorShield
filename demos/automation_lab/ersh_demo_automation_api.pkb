create or replace package body ersh_demo_automation_api as

  gc_scope_prefix     constant varchar2(31) := lower($$plsql_unit) || '.';
  -- Component type recorded on every incident this lab raises. The incidents
  -- view strips the APEX_APPLICATION_ prefix, so it shows as "Automations".
  gc_component_type   constant varchar2(30 char) := 'APEX_APPLICATION_AUTOMATIONS';
  -- Scheduled on purpose but never enabled, so page 1600 always has one
  -- automation that has never run.
  gc_always_disabled  constant varchar2(255 char) := 'weekly-resolved-purge';








  /**
   * Records a failed automation action in ErrorShield. See the spec.
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
  )
  is
    l_scope        logger_logs.scope%type := gc_scope_prefix || 'report_failure';
    l_params       logger.tab_param;
    l_logger_id    logger_logs.id%type;
    l_incident_id  ersh_shield_incidents.shield_incident_id%type;
  begin
    -- Log full details (autonomous commit inside logger; failure is silent)
    begin
      logger.append_param(l_params, 'p_static_id', p_static_id);
      logger.append_param(l_params, 'p_sqlcode',   p_sqlcode);

      l_logger_id := logger.log_error(
          p_text   => 'APEX Automation action failed: ' || p_static_id
                      || chr(10) || substr(p_error_message, 1, 3000)
        , p_scope  => l_scope
        , p_params => l_params
      );
    exception
      when others then null;
    end;


    -- =========================================================================
    -- Record the hit as an ErrorShield incident (autonomous; failure is silent)
    -- =========================================================================

    begin
      ersh_error_handler_api.record_internal_incident(
          p_workspace_id                    => apex_application.get_security_group_id
        , p_application_id                  => gc_application_id
        , p_app_user                        => apex_application.g_user
        , p_component_type                  => gc_component_type
        , p_component_name                  => p_static_id
        , p_ora_sqlcode                     => p_sqlcode
        , p_error_message                   => p_error_message
        , p_logger_log_id                   => l_logger_id
        , o_incident_id                     => l_incident_id
      );
    exception
      when others then null;
    end;
    -- =========================================================================
  end report_failure;








  /**
   * Enables every lab schedule except gc_always_disabled. See the spec.
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
  procedure enable_schedules
  is
    l_scope              logger_logs.scope%type := gc_scope_prefix || 'enable_schedules';
    l_params             logger.tab_param;
    l_session_created_yn varchar2(1 char) := 'N';
  begin
    logger.log('START', l_scope, null, l_params);

    apex_session.create_session(
        p_app_id                            => gc_application_id
      , p_page_id                           => 1
      , p_username                          => 'ERSH_AUTOMATION_LAB'
    );
    l_session_created_yn := 'Y';

    for l_rec in (
      select a.static_id                                             as static_id
        from apex_appl_automations a
       where a.application_id    = gc_application_id
         and a.trigger_type_code = 'POLLING'
         and a.static_id        != gc_always_disabled
    )
    loop
      apex_automation.enable(
          p_application_id                  => gc_application_id
        , p_static_id                       => l_rec.static_id
      );
    end loop;

    commit;
    apex_session.delete_session;

    logger.log('END', l_scope, null, l_params);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      -- No nested handler here: handling a second exception would clear the
      -- original one and turn the re-raise below into ORA-21002.
      if l_session_created_yn = 'Y' then
        apex_session.delete_session;
      end if;
      raise;
  end enable_schedules;








  /**
   * Runs every enabled automation of the lab app once. See the spec.
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
  procedure execute_all
  is
    l_scope              logger_logs.scope%type := gc_scope_prefix || 'execute_all';
    l_params             logger.tab_param;
    l_session_created_yn varchar2(1 char) := 'N';
  begin
    logger.log('START', l_scope, null, l_params);

    apex_session.create_session(
        p_app_id                            => gc_application_id
      , p_page_id                           => 1
      , p_username                          => 'ERSH_AUTOMATION_LAB'
    );
    l_session_created_yn := 'Y';

    for l_rec in (
      select a.static_id                                             as static_id
           , a.name                                                  as automation_name
        from apex_appl_automations a
       where a.application_id = gc_application_id
         and nvl(a.polling_status_code, 'ACTIVE') != 'DISABLED'
       order by a.name
    )
    loop
      begin
        apex_automation.execute(
            p_application_id                => gc_application_id
          , p_static_id                     => l_rec.static_id
        );
      exception
        when others then
          -- Some lab automations fail on purpose; their action already
          -- reported the failure, so this is only a breadcrumb.
          logger.log_warning(
              p_text  => 'Automation ' || l_rec.static_id || ' raised: ' || sqlerrm
            , p_scope => l_scope
          );
      end;
    end loop;

    apex_session.delete_session;

    logger.log('END', l_scope, null, l_params);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      -- No nested handler here: handling a second exception would clear the
      -- original one and turn the re-raise below into ORA-21002.
      if l_session_created_yn = 'Y' then
        apex_session.delete_session;
      end if;
      raise;
  end execute_all;


end ersh_demo_automation_api;
/
