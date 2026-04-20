-- Conditional compilation for verbose logging (see
-- https://rimblas.com/blog/2020/05/debugging-logger-conditional-compilation/).
-- Default off. To enable: alter session set plsql_ccflags = 'VERBOSE_OUTPUT:TRUE';
-- then recompile.

alter session set plsql_ccflags = 'VERBOSE_OUTPUT:FALSE';

create or replace package body ersh_error_handler_api as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';
  gc_pref_type    constant varchar2(30) := 'ERSH';

  -- ==========================================================================
  -- Private helpers
  -- ==========================================================================

  /**
   * Logs a maskable error to logger and ersh_shield_incidents, then builds
   * the user-facing reference message. Called from apex_error_handling for
   * both internal APEX errors and unexpected technical errors from app code.
   *
   * Both logger and incident recording are protected by their own
   * begin/exception blocks so a failure in either never propagates to
   * the caller or the end user.
   *
   * @param p_log_title  Prefix line written to logger to identify error origin.
   * @param p_error      Original APEX error record (apex_error.t_error).
   * @param o_message    User-facing masked message: reference number or fallback.
   */
  procedure log_and_mask_error(
    p_log_title                             in varchar2
  , p_error                                 in apex_error.t_error
  , o_message                               out varchar2
  )
  is
    l_reference_id  number;
    l_incident_id   ersh_shield_incidents.shield_incident_id%type;
    l_support_email varchar2(255 char);
    l_min_digits    pls_integer;
  begin
    -- Log full details (autonomous commit inside logger; failure is silent)
    begin
      l_reference_id := logger.log_error(
        p_text  =>
          p_log_title
          || chr(10) || 'message: '         || substr(nvl(p_error.message,         '(null)'), 1, 3000)
          || chr(10) || 'additional_info: ' || substr(nvl(p_error.additional_info, '(null)'), 1, 1000)
          || chr(10) || 'ora_sqlcode: '     || to_char(p_error.ora_sqlcode)
          || chr(10) || 'ora_sqlerrm: '     || substr(nvl(p_error.ora_sqlerrm,     '(null)'), 1, 4000)
          || chr(10) || 'error_backtrace: ' || substr(nvl(p_error.error_backtrace, '(null)'), 1, 2000)
      , p_scope => gc_scope_prefix || 'apex_error_handling'
      );
    exception
      when others then null;
    end;

    -- Record incident for admin dashboard (autonomous commit; failure is silent)
    begin
      record_internal_incident(
        p_application_id  => apex_application.g_flow_id
      , p_page_id         => apex_application.g_flow_step_id
      , p_app_user        => apex_application.g_user
      , p_request         => apex_application.g_request
      , p_ora_sqlcode     => p_error.ora_sqlcode
      , p_error_message   => p_error.message
      , p_logger_log_id   => l_reference_id
      , o_incident_id     => l_incident_id
      );
    exception
      when others then null;
    end;

    l_support_email := logger.get_pref('SUPPORT_EMAIL', gc_pref_type);
    l_min_digits    := to_number(logger.get_pref('REFERENCE_DISPLAY_MIN_DIGITS', gc_pref_type));

    if l_reference_id is not null then
      o_message :=
        'We hit an unexpected problem. Reference: '
        || lpad(
             to_char(l_reference_id),
             greatest(
               l_min_digits,
               length(to_char(l_reference_id))
             ),
             '0'
           )
        || '. Please contact '
        || l_support_email
        || ' and give us this reference.';
    else
      o_message :=
        'We hit an unexpected problem. Please contact '
        || l_support_email
        || ' for assistance. If you can, describe what you were doing when this appeared.';
    end if;

  end log_and_mask_error;


  -- ==========================================================================
  -- Public methods
  -- ==========================================================================

  /**
   * APEX error handling function. Masks internal errors; maps constraint
   * violations to friendly messages from ersh_constraint_lookup.
   *
   * @author Angel Flores (Consultant)
   * @created Monday, March 09, 2026
   *
   * @param p_error APEX error record (apex_error.t_error)
   * @return apex_error.t_error_result
   */
  function apex_error_handling(
    p_error                                 in apex_error.t_error
  ) return apex_error.t_error_result
  is
    l_result           apex_error.t_error_result;
    l_constraint_name  varchar2(255 char);
  begin
    l_result := apex_error.init_error_result(p_error => p_error);

    -- If it's an internal error raised by APEX, like an invalid statement or
    -- code which can't be executed, the error text might contain security
    -- sensitive information. To avoid this security problem we can rewrite the
    -- error to a generic error message and log the original error message for
    -- further investigation by the help desk.
    if p_error.is_internal_error then
      -- Mask all errors that are not common runtime errors (Access Denied
      -- errors raised by application / page authorization and all errors
      -- regarding session and session state)
      if not p_error.is_common_runtime_error then
        log_and_mask_error(
          p_log_title => 'Internal APEX error (user-facing message masked).'
        , p_error     => p_error
        , o_message   => l_result.message
        );
        l_result.additional_info := null;
      end if;
    else
      -- Note: If you want to have friendlier ORA error messages, you can
      -- also define a text message with the name pattern
      --
      --      APEX.ERROR.ORA-number
      --
      -- There is no need to implement custom code for that.

      -- If it's a constraint violation like
      --
      --   -) ORA-00001: unique constraint violated
      --   -) ORA-02091: transaction rolled back (-> can hide a deferred
      --      constraint)
      --   -) ORA-02290: check constraint violated
      --   -) ORA-02291: integrity constraint violated - parent key not found
      --   -) ORA-02292: integrity constraint violated - child record found
      --
      -- We try to get a friendly error message from our constraint lookup
      -- configuration. If we don't find the constraint in our lookup table,
      -- we fallback to the original ORA error message.
      if p_error.ora_sqlcode in (-1, -2091, -2290, -2291, -2292) then
        l_constraint_name := apex_error.extract_constraint_name(p_error => p_error);

        begin
          select constraint_message
            into l_result.message
            from ersh_constraint_lookup
           where constraint_name = l_constraint_name;
        exception
          when no_data_found then
            null; -- Not every constraint has to be in our lookup table.
        end;

      end if;

      -- Route remaining ORA errors by origin:
      --
      --   (-20000 to -20999) Developer-intentional raise_application_error:
      --     strip the "ORA-20xxx:" prefix and show the dev's message as-is.
      --
      --   Everything else (ORA-06502, ORA-01476, ORA-06500, etc.):
      --     Unexpected technical errors that should never reach the user.
      --     Log full details and return a masked reference message.
      if p_error.ora_sqlcode is not null
        and l_result.message = p_error.message
      then

        if p_error.ora_sqlcode between -20999 and -20000 then
          -- Intentional developer error: show message as written.
          l_result.message := apex_error.get_first_ora_error_text(p_error => p_error);

        else
          -- Unexpected technical error: mask it and give the user a reference.
          log_and_mask_error(
            p_log_title => 'Unexpected technical error in application code (masked).'
          , p_error     => p_error
          , o_message   => l_result.message
          );
          l_result.additional_info := null;

        end if;
      end if;

      -- If no associated page item/tabular form column has been set, we can
      -- use apex_error.auto_set_associated_item to automatically guess the
      -- affected error field by examine the ORA error for constraint names
      -- or column names.
      if l_result.page_item_name is null
        and l_result.column_alias is null
      then
        apex_error.auto_set_associated_item(
            p_error        => p_error
          , p_error_result => l_result
        );
      end if;
    end if;

    return l_result;
  end apex_error_handling;


  /**
   * Adds a custom error code to the ersh_error_lookup table.
   *
   * @author Angel Flores (Consultant)
   * @created Monday, March 09, 2026
   *
   * @example
   *   ersh_error_handler_api.add_custom_error(
   *       p_error_code   => 'CURRENCY_FETCH_FAILED'
   *     , p_ora_sqlcode  => -20001
   *     , p_message      => 'Failed to fetch currencies from the external service.'
   *   );
   */
  procedure add_custom_error(
    p_error_code                            in ersh_error_lookup.error_code%type
  , p_ora_sqlcode                           in ersh_error_lookup.ora_sqlcode%type
  , p_message                               in ersh_error_lookup.message%type
  )
  is
    l_scope   logger_logs.scope%type := gc_scope_prefix || 'add_custom_error';
    l_params  logger.tab_param;
    l_exists  number;
  begin
    logger.append_param(l_params, 'p_error_code: ', p_error_code);
    logger.append_param(l_params, 'p_ora_sqlcode: ', p_ora_sqlcode);
    logger.append_param(l_params, 'p_message: ', p_message);
    logger.log('START', l_scope, null, l_params);

    select count(1)
      into l_exists
      from ersh_error_lookup
     where error_code = p_error_code;

    if l_exists > 0 then
      raise_application_error(
        -20001
        , 'Error code already exists, try update method instead (ersh_error_handler_api.update_custom_error) '
      );
    end if;

    insert into ersh_error_lookup (
        error_code
      , ora_sqlcode
      , message
    )
    values (
        p_error_code
      , p_ora_sqlcode
      , p_message
    );

    logger.log('END', l_scope, null, l_params);

  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end add_custom_error;


  /**
   * Updates a custom error code in the ersh_error_lookup table.
   *
   * @author Angel Flores (Consultant)
   * @created Monday, March 09, 2026
   *
   * @example
   *   ersh_error_handler_api.update_custom_error(
   *       p_error_code   => 'CURRENCY_FETCH_FAILED'
   *     , p_ora_sqlcode  => -20001
   *     , p_message      => 'Unable to load currency data. Please try again later.'
   *   );
   */
  procedure update_custom_error(
    p_error_code                            in ersh_error_lookup.error_code%type
  , p_ora_sqlcode                           in ersh_error_lookup.ora_sqlcode%type
  , p_message                               in ersh_error_lookup.message%type
  )
  is
    l_scope   logger_logs.scope%type := gc_scope_prefix || 'update_custom_error';
    l_params  logger.tab_param;
  begin
    logger.append_param(l_params, 'p_error_code: ', p_error_code);
    logger.append_param(l_params, 'p_ora_sqlcode: ', p_ora_sqlcode);
    logger.append_param(l_params, 'p_message: ', p_message);
    logger.log('START', l_scope, null, l_params);

    update ersh_error_lookup
       set ora_sqlcode = p_ora_sqlcode
         , message     = p_message
     where error_code  = p_error_code;

    logger.log('END', l_scope, null, l_params);

  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end update_custom_error;


  /**
   * Deletes a custom error code from the ersh_error_lookup table.
   *
   * @author Angel Flores (Consultant)
   * @created Monday, March 09, 2026
   *
   * @param p_error_code The error code
   */
  procedure delete_custom_error(
    p_error_code                            in ersh_error_lookup.error_code%type
  )
  is
    l_scope   logger_logs.scope%type := gc_scope_prefix || 'delete_custom_error';
    l_params  logger.tab_param;
  begin
    logger.append_param(l_params, 'p_error_code: ', p_error_code);
    logger.log('START', l_scope, null, l_params);

    delete
      from ersh_error_lookup
     where error_code = p_error_code;

    logger.log('END', l_scope, null, l_params);

  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end delete_custom_error;


  /**
   * Raises a custom error code defined in ersh_error_lookup.
   *
   * @author Angel Flores (Consultant)
   * @created Monday, March 09, 2026
   *
   * @example
   *   ersh_error_handler_api.raise_custom_error(
   *     p_error_code => 'CURRENCY_FETCH_FAILED'
   *   );
   */
  procedure raise_custom_error(
    p_error_code                            in ersh_error_lookup.error_code%type
  )
  is
    l_scope        logger_logs.scope%type := gc_scope_prefix || 'raise_custom_error';
    l_params       logger.tab_param;
    l_exists       number := 0;
    l_ora_sqlcode  number;
    l_message      varchar2(4000 char);
  begin

    $if $$VERBOSE_OUTPUT $then
      logger.append_param(l_params, 'p_error_code: ', p_error_code);
      logger.log('START', l_scope, null, l_params);
    $end

    select count(1)
      into l_exists
      from ersh_error_lookup
     where error_code = p_error_code;

    if l_exists = 0 then
      raise_application_error(
        -20001
        , p_error_code || ' code, was not implemented in the ersh_error_lookup table'
      );
    end if;

    select ora_sqlcode
         , message
      into l_ora_sqlcode
         , l_message
      from ersh_error_lookup
     where error_code = p_error_code;

    raise_application_error(l_ora_sqlcode, l_message);

    $if $$VERBOSE_OUTPUT $then
      logger.log('END', l_scope, null, l_params);
    $end

  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end raise_custom_error;


  -- ==========================================================================
  -- PROCEDURE: record_internal_incident
  -- ==========================================================================
  /**
   * Inserts or increments a row in ersh_shield_incidents using Option A
   * deduplication: SHA-256 fingerprint + 30-second time bucket unique key.
   *
   * How it works:
   *  1. Build error_fingerprint = SHA-256 of (app_id|page_id|ora_sqlcode|msg_head).
   *  2. Build time_bucket      = floor(unix epoch seconds / 30).
   *  3. MERGE on (fingerprint, bucket):
   *       - matched   -> occurrence_count + 1
   *       - unmatched -> insert full correlation row
   *  4. dup_val_on_index safety net handles rare concurrent inserts.
   *  5. Return shield_incident_id of the resulting row.
   *
   * @example
   *   ersh_error_handler_api.record_internal_incident(
   *       p_application_id => apex_application.g_flow_id
   *     , p_page_id        => apex_application.g_flow_step_id
   *     , p_app_user       => apex_application.g_user
   *     , p_request        => apex_application.g_request
   *     , p_ora_sqlcode    => p_error.ora_sqlcode
   *     , p_error_message  => p_error.message
   *     , p_logger_log_id  => l_reference_id
   *     , o_incident_id    => l_incident_id
   *   );
   *
   * @issue ERSH-001
   *
   * @author Angel Flores (Consultant)
   * @created April 11, 2026
   *
   * @param p_application_id  APEX application ID
   * @param p_page_id         APEX page ID
   * @param p_app_user        APEX application user
   * @param p_request         APEX request value (e.g. SAVE, DELETE)
   * @param p_component_type  APEX component type from apex_error.t_error
   * @param p_component_name  APEX component name from apex_error.t_error
   * @param p_ora_sqlcode     ORA error code, if available
   * @param p_error_message   Raw internal message (stored only in DB, never shown to users)
   * @param p_logger_log_id   logger_logs.id from logger.log_error call, if available
   * @param o_incident_id     Shield incident id (new or existing dedup row)
   */
  procedure record_internal_incident(
    p_application_id                        in number default null
  , p_page_id                               in number default null
  , p_app_user                              in varchar2 default null
  , p_request                               in varchar2 default null
  , p_component_type                        in varchar2 default null
  , p_component_name                        in varchar2 default null
  , p_ora_sqlcode                           in number default null
  , p_error_message                         in varchar2 default null
  , p_logger_log_id                         in number default null
  , o_incident_id                           out ersh_shield_incidents.shield_incident_id%type
  )
  is
    pragma autonomous_transaction;

    l_scope         logger_logs.scope%type := gc_scope_prefix || 'record_internal_incident';
    l_fingerprint   ersh_shield_incidents.error_fingerprint%type;
    l_time_bucket   ersh_shield_incidents.time_bucket%type;
  begin
    -- ---------------------------------------------------------------------
    -- Step 1: Build the error fingerprint.
    --
    -- Purpose: uniquely identify "this type of error" so we can group
    --          repeated occurrences into a single incident row.
    --
    -- Inputs joined with '|' as separator to avoid accidental collisions
    -- between different combinations of short values:
    --   application_id  -> which APEX app triggered the error
    --   page_id         -> which page within the app
    --   ora_sqlcode     -> the ORA error code (e.g. -1, -20001), or null
    --   message head    -> first 200 chars only so minor runtime differences
    --                      (e.g. a primary key value in the message) do not
    --                      generate a new fingerprint for the same root cause
    --
    -- Algorithm: SHA-256 via standard_hash, then rawtohex so the result is
    -- a readable 64-char hex string (varchar2) stored in error_fingerprint.
    --
    -- Note: standard_hash is a SQL function, not a PL/SQL built-in, so it
    --       must be called inside a SELECT statement.
    -- ---------------------------------------------------------------------
    select rawtohex(
             standard_hash(
               nvl(to_char(p_application_id), '') || '|'
               || nvl(to_char(p_page_id), '') || '|'
               || nvl(to_char(p_ora_sqlcode), '') || '|'
               || nvl(substr(p_error_message, 1, 200), '')
             , 'SHA256'
             )
           )
      into l_fingerprint
      from dual;

    -- ---------------------------------------------------------------------
    -- Step 2: Compute the 30-second time bucket.
    --
    -- Purpose: limit how many rows a single repeated error can generate.
    --          All errors with the same fingerprint that arrive within the
    --          same 30-second window map to the same bucket number, and
    --          therefore hit the same row in ersh_shield_incidents.
    --
    -- How it works:
    --   1. sys_extract_utc(systimestamp) -> current timestamp in UTC.
    --   2. Cast to DATE so subtraction gives fractional days.
    --   3. Multiply by 86400 -> total elapsed seconds since Unix epoch
    --      (midnight 1-Jan-1970 UTC).
    --   4. Divide by 30, then floor() -> integer bucket number.
    --      Every 30 seconds the bucket increments by 1.
    --
    -- Example:
    --   14:00:00 UTC = bucket 3_733_200  (seconds: 111_996_000 / 30)
    --   14:00:29 UTC = same bucket 3_733_200  (same 30-sec window)
    --   14:00:30 UTC = bucket 3_733_201  (new window starts)
    -- ---------------------------------------------------------------------
    l_time_bucket := floor(
      (cast(sys_extract_utc(systimestamp) as date) - date '1970-01-01')
      * 86400 / 30
    );

    -- -----------------------------------------------------------------
    -- Step 3: MERGE — increment if same fingerprint+bucket, else insert.
    -- -----------------------------------------------------------------
    merge into ersh_shield_incidents t
    using (
      select l_fingerprint as error_fingerprint
           , l_time_bucket as time_bucket
        from dual
    ) s
    on (    t.error_fingerprint = s.error_fingerprint
        and t.time_bucket       = s.time_bucket)
    when matched then
      update
         set t.occurrence_count = t.occurrence_count + 1
           , t.logger_log_id    = nvl(t.logger_log_id, p_logger_log_id)
    when not matched then
      insert (
        logger_log_id
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
      )
      values (
        p_logger_log_id
      , p_application_id
      , p_page_id
      , p_app_user
      , p_request
      , p_component_type
      , p_component_name
      , p_ora_sqlcode
      , substr(p_error_message, 1, 4000)
      , l_fingerprint
      , l_time_bucket
      );

    -- Return the id of whichever row the merge touched.
    select shield_incident_id
      into o_incident_id
      from ersh_shield_incidents
     where error_fingerprint = l_fingerprint
       and time_bucket       = l_time_bucket;

    commit;

  exception
    -- -----------------------------------------------------------------
    -- Safety net: two sessions raced to insert the same bucket row.
    -- Update the existing row and return its id.
    -- -----------------------------------------------------------------
    when dup_val_on_index then
      update ersh_shield_incidents
         set occurrence_count = occurrence_count + 1
           , logger_log_id    = nvl(logger_log_id, p_logger_log_id)
       where error_fingerprint = l_fingerprint
         and time_bucket       = l_time_bucket;

      select shield_incident_id
        into o_incident_id
        from ersh_shield_incidents
       where error_fingerprint = l_fingerprint
         and time_bucket       = l_time_bucket;

      commit;

    when others then
      rollback;
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end record_internal_incident;


  -- ==========================================================================
  -- PROCEDURE: resolve_incident
  -- ==========================================================================
  /**
   * Marks a shield incident as resolved by the current user.
   *
   * @example
   *   ersh_error_handler_api.resolve_incident(
   *       p_incident_id      => 42
   *     , p_resolution_notes => 'Root cause: missing null check. Fixed in release 1.2.'
   *   );
   *
   * @issue ERSH-001
   *
   * @author Angel Flores (Consultant)
   * @created April 11, 2026
   *
   * @param p_incident_id      PK of the ersh_shield_incidents row to resolve
   * @param p_resolution_notes Optional admin notes describing root cause or fix
   */
  procedure resolve_incident(
    p_incident_id                           in ersh_shield_incidents.shield_incident_id%type
  , p_resolution_notes                      in ersh_shield_incidents.resolution_notes%type default null
  )
  is
    l_scope   logger_logs.scope%type := gc_scope_prefix || 'resolve_incident';
    l_params  logger.tab_param;
  begin
    logger.append_param(l_params, 'p_incident_id: ', p_incident_id);
    logger.log('START', l_scope, null, l_params);

    update ersh_shield_incidents
       set resolved_yn       = 'Y'
         , resolved_by       = coalesce(
                                 sys_context('APEX$SESSION', 'app_user')
                               , regexp_substr(sys_context('userenv', 'client_identifier'), '^[^:]*')
                               , sys_context('userenv', 'session_user')
                               )
         , resolved_on       = localtimestamp
         , resolution_notes  = p_resolution_notes
     where shield_incident_id = p_incident_id;

    if sql%rowcount = 0 then
      raise_application_error(
        -20001
      , 'Incident ' || to_char(p_incident_id) || ' not found in ersh_shield_incidents.'
      );
    end if;

    logger.log('END', l_scope, null, l_params);

  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end resolve_incident;



end ersh_error_handler_api;
/
