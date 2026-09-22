create or replace package body ersh_demo_data_api as

  gc_scope_prefix     constant varchar2(31) := lower($$plsql_unit) || '.';
  -- Tag on every generated logger_logs row so purge_demo_data can remove
  -- exactly what this package created, and nothing else.
  gc_demo_client_id   constant varchar2(30 char) := 'ERRORSHIELD_DEMO_DATA';
  -- Prefix on every demo scheduler job name for the same reason.
  gc_demo_job_prefix  constant varchar2(20 char) := 'ERSH_DEMO_';








  -- ==========================================================================
  -- Private helpers
  -- ==========================================================================

  /**
   * Weighted random pick from the logger_level values the logger_logs check
   * constraint allows, skewed toward INFORMATION/DEBUG so the Logger Logs
   * report doesn't look artificially uniform.
   *
   * @return One of logger.g_permanent/g_error/g_warning/g_information/
   *         g_debug/g_timing/g_sys_context.
   */
  function get_random_log_level return logger_logs.logger_level%type
  is
    l_roll pls_integer := trunc(dbms_random.value(1, 101));
  begin
    if l_roll <= 40 then
      return logger.g_information;
    elsif l_roll <= 65 then
      return logger.g_debug;
    elsif l_roll <= 82 then
      return logger.g_warning;
    elsif l_roll <= 94 then
      return logger.g_error;
    elsif l_roll <= 98 then
      return logger.g_timing;
    elsif l_roll <= 99 then
      return logger.g_sys_context;
    else
      return logger.g_permanent;
    end if;
  end get_random_log_level;








  /**
   * @return A random, clearly-fake "background noise" log message.
   */
  function get_random_background_message return varchar2
  is
    type t_messages is table of varchar2(300 char);

    l_messages t_messages := t_messages(
        'Scheduled cache refresh completed successfully.'
      , 'Session pool utilization at ' || trunc(dbms_random.value(20, 95)) || '%.'
      , 'Batch job processed ' || trunc(dbms_random.value(10, 500)) || ' records.'
      , 'Outbound webhook delivered in ' || trunc(dbms_random.value(50, 900)) || 'ms.'
      , 'Nightly export finished for region ' || chr(64 + trunc(dbms_random.value(1, 5))) || '.'
      , 'Report generation queued for background processing.'
      , 'Configuration reloaded from logger_prefs.'
      , 'Slow query detected: ' || trunc(dbms_random.value(1200, 6000)) || 'ms.'
      , 'Connection pool recycled.'
      , 'File upload validated and stored.'
    );
  begin
    return l_messages(trunc(dbms_random.value(1, l_messages.count + 1)));
  end get_random_background_message;








  /**
   * @return A random, clearly-fake internal error message, the kind that
   *         would land in ersh_shield_incidents.error_summary.
   */
  function get_random_incident_message return varchar2
  is
    type t_messages is table of varchar2(300 char);

    l_messages t_messages := t_messages(
        'ORA-00001: unique constraint (DEMO.UK_ORDERS_NUMBER) violated'
      , 'ORA-01400: cannot insert NULL into ("DEMO"."INVOICES"."CUSTOMER_ID")'
      , 'ORA-02291: integrity constraint (DEMO.FK_LINES_ORDER) violated - parent key not found'
      , 'ORA-06502: PL/SQL: numeric or value error: character string buffer too small'
      , 'ORA-01438: value larger than specified precision allowed for this column'
      , 'Unable to reach the payment gateway within the configured timeout.'
      , 'Unexpected null returned while resolving the shipping rate for this order.'
      , 'The selected warehouse has no available inventory for this SKU.'
      , 'Currency conversion service returned an unexpected response format.'
      , 'Session state was lost while submitting the multi-step wizard.'
    );
  begin
    return l_messages(trunc(dbms_random.value(1, l_messages.count + 1)));
  end get_random_incident_message;








  /**
   * @return A random ORA/custom error code, including null (some internal
   *         APEX component errors carry no sqlcode at all).
   */
  function get_random_ora_sqlcode return ersh_shield_incidents.ora_sqlcode%type
  is
    type t_codes is table of number;

    l_codes t_codes := t_codes(-1, -1400, -2291, -2292, -6502, -1438, -20001, -20010, null, null);
  begin
    return l_codes(trunc(dbms_random.value(1, l_codes.count + 1)));
  end get_random_ora_sqlcode;








  /**
   * @return A random fake module name, distinct per "consumer application".
   */
  function get_random_module return varchar2
  is
    type t_values is table of varchar2(100 char);

    l_values t_values := t_values('ORDERS_API', 'BILLING_API', 'SHIPPING_API', 'AUTH_API', 'REPORTING_API', 'INTEGRATION_API');
  begin
    return l_values(trunc(dbms_random.value(1, l_values.count + 1)));
  end get_random_module;








  /**
   * @return A random fake action name.
   */
  function get_random_action return varchar2
  is
    type t_values is table of varchar2(100 char);

    l_values t_values := t_values('PROCESS', 'VALIDATE', 'SYNC', 'EXPORT', 'CALCULATE', 'SUBMIT');
  begin
    return l_values(trunc(dbms_random.value(1, l_values.count + 1)));
  end get_random_action;








  /**
   * @return A random, clearly-fake app user name — never a real identity.
   */
  function get_random_app_user return varchar2
  is
    type t_values is table of varchar2(60 char);

    l_values t_values := t_values('DEMO.JSMITH', 'DEMO.MGARCIA', 'DEMO.ADIAZ', 'DEMO.RPARKER', 'DEMO.TWONG', 'DEMO.LCHEN', 'DEMO.KMOORE');
  begin
    return l_values(trunc(dbms_random.value(1, l_values.count + 1)));
  end get_random_app_user;








  /**
   * Mirrors the shape of the real dedup fingerprint (see
   * ersh_shield_incidents.error_fingerprint) closely enough to look
   * authentic, plus a random salt so generated rows never collide with each
   * other under the (error_fingerprint, time_bucket) unique constraint.
   *
   * @param p_workspace_id   Fake workspace id for this incident.
   * @param p_application_id Fake application id for this incident.
   * @param p_page_id        Fake page id for this incident.
   * @param p_ora_sqlcode    Fake ORA code for this incident (may be null).
   * @return                 A 64-char lowercase hex SHA-256 hash.
   */
  function build_fingerprint(
      p_workspace_id                                   in number
    , p_application_id                                 in number
    , p_page_id                                        in number
    , p_ora_sqlcode                                    in number
  ) return ersh_shield_incidents.error_fingerprint%type
  is
    -- standard_hash is a SQL-only function -- PL/SQL rejects it outside a
    -- SQL statement (PLS-00201), so it must be resolved via select..from dual.
    l_fingerprint ersh_shield_incidents.error_fingerprint%type;
  begin
    select lower(standard_hash(
               p_workspace_id || '|' || p_application_id || '|' || p_page_id || '|' || p_ora_sqlcode
               || '|' || dbms_random.string('x', 32)
             , 'SHA256'
           ))
      into l_fingerprint
      from dual;

    return l_fingerprint;
  end build_fingerprint;








  /**
   * Same formula documented on ersh_shield_incidents.time_bucket: floor of
   * unix epoch seconds divided by 30.
   *
   * @param p_created_on Timestamp to bucket.
   * @return             30-second bucket number.
   */
  function compute_time_bucket(
      p_created_on                                     in ersh_shield_incidents.created_on%type
  ) return ersh_shield_incidents.time_bucket%type
  is
  begin
    return trunc((cast(p_created_on as date) - date '1970-01-01') * 86400 / 30);
  end compute_time_bucket;








  /**
   * Idempotent DBMS_SCHEDULER job creation, mirroring the existence-check
   * pattern already used by jobs/ersh_purge_job.sql. auto_drop is always
   * false so a one-shot job (p_repeat_interval null) stays visible in the
   * Inventory/Job Details dashboards after it has run, instead of Oracle
   * silently dropping it.
   *
   * @param p_job_name        Job name (this package always prefixes it with
   *                          gc_demo_job_prefix before calling this).
   * @param p_job_action      PLSQL_BLOCK body, e.g. 'begin ... end;'.
   * @param p_repeat_interval Scheduler calendar string, or null for one-shot.
   * @param p_comments        Stored on the job so it's identifiable as demo-only.
   */
  procedure create_demo_job_if_missing(
      p_job_name                                       in varchar2
    , p_job_action                                     in varchar2
    , p_repeat_interval                                in varchar2
    , p_comments                                       in varchar2
  )
  is
    l_count pls_integer;
  begin
    select count(1)
      into l_count
      from user_scheduler_jobs
     where job_name = p_job_name;

    if l_count = 0 then
      dbms_scheduler.create_job(
          job_name        => p_job_name
        , job_type        => 'PLSQL_BLOCK'
        , job_action      => p_job_action
        , start_date      => systimestamp
        , repeat_interval => p_repeat_interval
        , enabled         => true
        , auto_drop       => false
        , comments        => p_comments
      );
    end if;
  end create_demo_job_if_missing;








  -- ==========================================================================
  -- Public methods
  -- ==========================================================================

  /**
   * Inserts p_log_count "background noise" logger_logs rows, timestamped
   * randomly over the last p_days_back days, not linked to any incident.
   * Populates the Logger Logs report (page 400) so it looks like a real,
   * busy system instead of just the handful of rows generate_incidents adds.
   *
   * @example
   * exec ersh_demo_data_api.generate_background_logs(
   *     p_log_count                                    => 3000
   *   , p_days_back                                     => 30
   * );
   *
   * @issue ERSH-046
   *
   * @author Angel Flores (Consultant)
   * @created September 19, 2026
   *
   * @param p_log_count How many rows to insert.
   * @param p_days_back Spread timestamps randomly over this many past days.
   */
  procedure generate_background_logs(
      p_log_count                                      in pls_integer default 3000
    , p_days_back                                      in pls_integer default 30
  )
  is
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_background_logs';
    l_params logger.tab_param;

    l_module    varchar2(100 char);
    l_app_user  logger_logs.user_name%type;
    l_log_level logger_logs.logger_level%type;
    l_message   logger_logs.text%type;
    l_action    logger_logs.action%type;
  begin
    logger.append_param(l_params, 'p_log_count', p_log_count);
    logger.append_param(l_params, 'p_days_back', p_days_back);
    logger.log('START', l_scope, null, l_params);

    for i in 1 .. p_log_count loop
      -- dbms_random-backed helper functions can't be called directly from SQL
      -- here (PLS-00231) -- resolve each one to a local variable first, then
      -- bind it below.
      l_module    := get_random_module;
      l_app_user  := get_random_app_user;
      l_log_level := get_random_log_level;
      l_message   := get_random_background_message;
      l_action    := get_random_action;

      insert
        into logger_logs (
             id
           , logger_level
           , text
           , time_stamp
           , scope
           , module
           , action
           , user_name
           , client_identifier
      )
      values (
             logger_logs_seq.nextval
           , l_log_level
           , l_message
           , localtimestamp - numtodsinterval(dbms_random.value(0, p_days_back), 'day')
           , lower(l_module) || '.background'
           , l_module
           , l_action
           , l_app_user
           , gc_demo_client_id
      );

      if mod(i, 500) = 0 then
        commit;
      end if;
    end loop;

    commit;

    logger.log('END', l_scope, null, l_params);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_background_logs;








  /**
   * Generates p_incident_count rows in ersh_shield_incidents, each backed
   * by 1 to p_max_occurrences rows in ersh_incident_occurrences (and one
   * logger_logs row per occurrence, including the incident's own "first
   * hit" — mirroring what record_internal_incident does for real).
   * Populates the Incidents list (page 100) and Review Incident (page 110).
   *
   * @example
   * exec ersh_demo_data_api.generate_incidents(
   *     p_incident_count                               => 300
   *   , p_days_back                                     => 30
   *   , p_max_occurrences                               => 6
   * );
   *
   * @issue ERSH-046
   *
   * @author Angel Flores (Consultant)
   * @created September 19, 2026
   *
   * @param p_incident_count  How many ersh_shield_incidents rows to create.
   * @param p_days_back       Spread incident created_on randomly over this
   *                          many past days.
   * @param p_max_occurrences Each incident gets a random 1..this many
   *                          occurrences.
   */
  procedure generate_incidents(
      p_incident_count                                 in pls_integer default 300
    , p_days_back                                      in pls_integer default 30
    , p_max_occurrences                                in pls_integer default 6
  )
  is
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_incidents';
    l_params logger.tab_param;

    l_workspace_id     number;
    l_application_id   number;
    l_page_id          number;
    l_ora_sqlcode      ersh_shield_incidents.ora_sqlcode%type;
    l_message          varchar2(300 char);
    l_created_on       ersh_shield_incidents.created_on%type;
    l_resolved_yn      ersh_shield_incidents.resolved_yn%type;
    l_occurrence_count pls_integer;
    l_first_log_id     logger_logs.id%type;
    l_incident_id      ersh_shield_incidents.shield_incident_id%type;
    l_occurrence_log_id logger_logs.id%type;
    -- dbms_random-backed helper functions can't be called directly from SQL
    -- (PLS-00231) -- resolved to local variables below, then bound in.
    l_app_user         ersh_shield_incidents.app_user%type;
    l_resolved_by      ersh_shield_incidents.resolved_by%type;
    l_fingerprint      ersh_shield_incidents.error_fingerprint%type;
    l_module           varchar2(100 char);
    l_action           logger_logs.action%type;
    l_time_bucket      ersh_shield_incidents.time_bucket%type;
    l_occ_app_user     ersh_incident_occurrences.app_user%type;
    l_occ_module       varchar2(100 char);
    l_occ_action       logger_logs.action%type;
  begin
    logger.append_param(l_params, 'p_incident_count', p_incident_count);
    logger.append_param(l_params, 'p_days_back', p_days_back);
    logger.append_param(l_params, 'p_max_occurrences', p_max_occurrences);
    logger.log('START', l_scope, null, l_params);

    for i in 1 .. p_incident_count loop
      l_workspace_id     := trunc(dbms_random.value(1000000, 9999999));
      l_application_id   := trunc(dbms_random.value(1, 4)) * 100;
      l_page_id          := trunc(dbms_random.value(1, 50));
      l_ora_sqlcode      := get_random_ora_sqlcode;
      l_message          := get_random_incident_message;
      l_created_on       := localtimestamp - numtodsinterval(dbms_random.value(0, p_days_back), 'day');
      l_resolved_yn      := case when dbms_random.value(0, 1) < 0.35 then 'Y' else 'N' end;
      l_occurrence_count := trunc(dbms_random.value(1, p_max_occurrences + 1));
      l_app_user         := get_random_app_user;
      l_resolved_by      := case when l_resolved_yn = 'Y' then get_random_app_user end;
      l_fingerprint      := build_fingerprint(l_workspace_id, l_application_id, l_page_id, l_ora_sqlcode);
      l_module           := get_random_module;
      l_action           := get_random_action;
      l_time_bucket      := compute_time_bucket(l_created_on);

      -- =======================================================================
      -- First hit: one logger_logs row, becomes both the incident's own
      -- logger_log_id and occurrence #1.
      -- =======================================================================

      insert
        into logger_logs (
             id
           , logger_level
           , text
           , time_stamp
           , scope
           , module
           , action
           , user_name
           , client_identifier
      )
      values (
             logger_logs_seq.nextval
           , logger.g_error
           , l_message
           , l_created_on
           , 'consumer_app.apex_error_handling'
           , l_module
           , l_action
           , l_app_user
           , gc_demo_client_id
      )
      returning id into l_first_log_id;
      -- =======================================================================

      insert
        into ersh_shield_incidents (
             logger_log_id
           , workspace_id
           , application_id
           , page_id
           , app_user
           , request
           , component_type
           , component_name
           , ora_sqlcode
           , error_summary
           , error_fingerprint
           , time_bucket
           , occurrence_count
           , resolved_yn
           , resolved_by
           , resolved_on
           , resolution_notes
           , created_on
      )
      values (
             l_first_log_id
           , l_workspace_id
           , l_application_id
           , l_page_id
           , l_app_user
           , case trunc(dbms_random.value(1, 4)) when 1 then 'SAVE' when 2 then 'DELETE' else 'CREATE' end
           , 'APEX_APPLICATION_PAGE_REGIONS'
           , l_module || ' Region'
           , l_ora_sqlcode
           , l_message
           , l_fingerprint
           , l_time_bucket
           , l_occurrence_count
           , l_resolved_yn
           , l_resolved_by
           , case when l_resolved_yn = 'Y' then l_created_on + numtodsinterval(dbms_random.value(1, 48), 'hour') end
           , case when l_resolved_yn = 'Y' then 'Root cause identified and fixed in a later release.' end
           , l_created_on
      )
      returning shield_incident_id into l_incident_id;

      insert
        into ersh_incident_occurrences (
             shield_incident_id
           , logger_log_id
           , app_user
           , occurred_on
      )
      values (
             l_incident_id
           , l_first_log_id
           , l_app_user
           , l_created_on
      );

      -- =======================================================================
      -- Remaining occurrences: fresh logger_logs row each, later timestamps.
      -- =======================================================================
      for j in 2 .. l_occurrence_count loop
        l_occ_app_user := get_random_app_user;
        l_occ_module   := get_random_module;
        l_occ_action   := get_random_action;

        insert
          into logger_logs (
               id
             , logger_level
             , text
             , time_stamp
             , scope
             , module
             , action
             , user_name
             , client_identifier
        )
        values (
               logger_logs_seq.nextval
             , logger.g_error
             , l_message
             , l_created_on + numtodsinterval(dbms_random.value(1, 72), 'hour')
             , 'consumer_app.apex_error_handling'
             , l_occ_module
             , l_occ_action
             , l_occ_app_user
             , gc_demo_client_id
        )
        returning id into l_occurrence_log_id;

        insert
          into ersh_incident_occurrences (
               shield_incident_id
             , logger_log_id
             , app_user
             , occurred_on
        )
        values (
               l_incident_id
             , l_occurrence_log_id
             , l_occ_app_user
             , l_created_on + numtodsinterval(dbms_random.value(1, 72), 'hour')
        );
      end loop;
      -- =======================================================================

      if mod(i, 100) = 0 then
        commit;
      end if;
    end loop;

    commit;

    logger.log('END', l_scope, null, l_params);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_incidents;








  /**
   * Creates (idempotently) three demo-only DBMS_SCHEDULER jobs and runs two
   * of them several times synchronously, so ALL_SCHEDULER_JOB_RUN_DETAILS
   * accumulates real run history:
   *   - ERSH_DEMO_HEARTBEAT_JOB — repeats every 20 minutes, always succeeds.
   *     Populates "next runs" and gives a healthy row in every status view.
   *   - ERSH_DEMO_FLAKY_JOB     — one-shot, deliberately raises. Run
   *     p_failure_run_count times to populate recent-failures/status.
   *   - ERSH_DEMO_RELIABLE_JOB  — one-shot, always succeeds. Run
   *     p_success_run_count times for a clean SUCCEEDED execution history.
   *
   * This is what populates the Jobs dashboard (page 1000) and the
   * Inventory/Job Details/Job Executions pages (1100/1200/1300) — those
   * read Oracle's scheduler dictionary views directly, which no INSERT
   * statement can reach.
   *
   * @example
   * exec ersh_demo_data_api.generate_scheduler_jobs(
   *     p_failure_run_count                            => 4
   *   , p_success_run_count                             => 6
   * );
   *
   * @issue ERSH-046
   *
   * @author Angel Flores (Consultant)
   * @created September 19, 2026
   *
   * @param p_failure_run_count How many times to run the always-fails job.
   * @param p_success_run_count How many times to run the always-succeeds job.
   */
  procedure generate_scheduler_jobs(
      p_failure_run_count                              in pls_integer default 4
    , p_success_run_count                              in pls_integer default 6
  )
  is
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_scheduler_jobs';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'p_failure_run_count', p_failure_run_count);
    logger.append_param(l_params, 'p_success_run_count', p_success_run_count);
    logger.log('START', l_scope, null, l_params);

    create_demo_job_if_missing(
        p_job_name        => gc_demo_job_prefix || 'HEARTBEAT_JOB'
      , p_job_action      => 'begin logger.log_information(''ErrorShield demo heartbeat.'', ''ersh_demo_data_api.heartbeat_job''); end;'
      , p_repeat_interval => 'FREQ=MINUTELY; INTERVAL=20'
      , p_comments        => 'Demo-only heartbeat job (ERSH-046) -- safe to drop via ersh_demo_data_api.purge_demo_data.'
    );

    create_demo_job_if_missing(
        p_job_name        => gc_demo_job_prefix || 'FLAKY_JOB'
      , p_job_action      => 'begin raise_application_error(-20500, ''Demo: simulated downstream timeout.''); end;'
      , p_repeat_interval => null
      , p_comments        => 'Demo-only job intentionally designed to fail (ERSH-046) -- populates recent-failures.'
    );

    for i in 1 .. p_failure_run_count loop
      begin
        dbms_scheduler.run_job(job_name => gc_demo_job_prefix || 'FLAKY_JOB', use_current_session => true);
      exception
        when others then
          null; -- expected: this job's own action always raises.
      end;
    end loop;

    create_demo_job_if_missing(
        p_job_name        => gc_demo_job_prefix || 'RELIABLE_JOB'
      , p_job_action      => 'begin logger.log_information(''ErrorShield demo job run.'', ''ersh_demo_data_api.reliable_job''); end;'
      , p_repeat_interval => null
      , p_comments        => 'Demo-only job that always succeeds (ERSH-046) -- populates healthy execution history.'
    );

    for i in 1 .. p_success_run_count loop
      dbms_scheduler.run_job(job_name => gc_demo_job_prefix || 'RELIABLE_JOB', use_current_session => true);
    end loop;

    logger.log('END', l_scope, null, l_params);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_scheduler_jobs;








  /**
   * Creates (if missing) and kicks off, in the background, a demo job that
   * just sleeps for p_sleep_seconds. The "Running now" dashboard (page
   * 1400) only ever has rows while a job is actually executing, so call
   * this right before showing that screen rather than relying on the
   * synchronous run history generate_scheduler_jobs builds.
   *
   * @example
   * exec ersh_demo_data_api.run_slow_demo_job(
   *     p_sleep_seconds                                 => 45
   * );
   *
   * @issue ERSH-046
   *
   * @author Angel Flores (Consultant)
   * @created September 19, 2026
   *
   * @param p_sleep_seconds How long the job sleeps once it starts running.
   */
  procedure run_slow_demo_job(
      p_sleep_seconds                                  in pls_integer default 45
  )
  is
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'run_slow_demo_job';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'p_sleep_seconds', p_sleep_seconds);
    logger.log('START', l_scope, null, l_params);

    create_demo_job_if_missing(
        p_job_name        => gc_demo_job_prefix || 'SLOW_JOB'
      , p_job_action      => 'begin dbms_lock.sleep(' || p_sleep_seconds || '); end;'
      , p_repeat_interval => null
      , p_comments        => 'Demo-only long-running job (ERSH-046) -- run before showing "Running now" (page 1400).'
    );

    dbms_scheduler.run_job(job_name => gc_demo_job_prefix || 'SLOW_JOB', use_current_session => false);

    logger.log('END', l_scope, null, l_params);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end run_slow_demo_job;








  /**
   * Convenience wrapper: optionally purges existing demo data, then calls
   * generate_background_logs, generate_incidents, and generate_scheduler_jobs
   * with the given (or default) volumes. This is the one call a fresh demo
   * schema needs after installing ErrorShield itself (see docs/DEMO.md).
   *
   * @example
   * exec ersh_demo_data_api.generate_all_demo_data;
   *
   * @issue ERSH-046
   *
   * @author Angel Flores (Consultant)
   * @created September 19, 2026
   *
   * @param p_reset_first_yn   'Y' to purge_demo_data before generating.
   * @param p_log_count        Passed through to generate_background_logs.
   * @param p_incident_count   Passed through to generate_incidents.
   * @param p_days_back        Passed through to generate_background_logs
   *                           and generate_incidents.
   * @param p_max_occurrences  Passed through to generate_incidents.
   */
  procedure generate_all_demo_data(
      p_reset_first_yn                                 in varchar2 default 'Y'
    , p_log_count                                      in pls_integer default 3000
    , p_incident_count                                 in pls_integer default 300
    , p_days_back                                      in pls_integer default 30
    , p_max_occurrences                                in pls_integer default 6
  )
  is
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_all_demo_data';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'p_reset_first_yn', p_reset_first_yn);
    logger.append_param(l_params, 'p_log_count', p_log_count);
    logger.append_param(l_params, 'p_incident_count', p_incident_count);
    logger.log('START', l_scope, null, l_params);

    if p_reset_first_yn = 'Y' then
      purge_demo_data;
    end if;

    generate_background_logs(
        p_log_count => p_log_count
      , p_days_back => p_days_back
    );

    generate_incidents(
        p_incident_count   => p_incident_count
      , p_days_back        => p_days_back
      , p_max_occurrences  => p_max_occurrences
    );

    generate_scheduler_jobs;

    logger.log('END', l_scope, null, l_params);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_all_demo_data;








  /**
   * Removes every row this package generated (matched by client_identifier
   * = 'ERRORSHIELD_DEMO_DATA', deleted in FK-safe order: occurrences, then
   * incidents, then the logs themselves) and drops every demo scheduler job
   * (job_name like 'ERSH_DEMO_%'). Never touches real data or real jobs —
   * only what this package's own naming/tagging convention produced.
   *
   * @example
   * exec ersh_demo_data_api.purge_demo_data;
   *
   * @issue ERSH-046
   *
   * @author Angel Flores (Consultant)
   * @created September 19, 2026
   */
  procedure purge_demo_data
  is
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'purge_demo_data';
    l_params logger.tab_param;
  begin
    logger.log('START', l_scope, null, l_params);

    for l_job in (
      select job_name
        from user_scheduler_jobs
       where job_name like gc_demo_job_prefix || '%'
    )
    loop
      begin
        dbms_scheduler.drop_job(job_name => l_job.job_name, force => true);
      exception
        when others then
          logger.log_warning('Could not drop demo job ' || l_job.job_name, l_scope);
      end;
    end loop;

    delete
      from ersh_incident_occurrences
     where logger_log_id in (
       select id
         from logger_logs
        where client_identifier = gc_demo_client_id
     );

    delete
      from ersh_shield_incidents
     where logger_log_id in (
       select id
         from logger_logs
        where client_identifier = gc_demo_client_id
     );

    delete
      from logger_logs
     where client_identifier = gc_demo_client_id;

    commit;

    logger.log('END', l_scope, null, l_params);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end purge_demo_data;



end ersh_demo_data_api;
/
