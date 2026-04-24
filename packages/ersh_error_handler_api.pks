create or replace package ersh_error_handler_api is

  function apex_error_handling(
    p_error                                 in apex_error.t_error
  ) return apex_error.t_error_result;


  -- =========================================================================
  -- Custom error code management (ersh_error_lookup)
  -- =========================================================================

  /**
   * Inserts or updates a row in ersh_error_lookup by error_code (MERGE).
   * Single entry point for former add_custom_error / update_custom_error.
   *
   * @param p_error_code  Business key (must not be null).
   * @param p_ora_sqlcode SQLCODE passed to raise_application_error.
   * @param p_message     User-facing message.
   * @param p_active_yn   Soft flag Y/N (default Y).
   */
  procedure merge_ersh_error_lookup(
    p_error_code                            in ersh_error_lookup.error_code%type
  , p_ora_sqlcode                           in ersh_error_lookup.ora_sqlcode%type
  , p_message                               in ersh_error_lookup.message%type
  , p_active_yn                             in ersh_error_lookup.active_yn%type default 'Y'
  );


  /**
   * Deletes a row from ersh_error_lookup by error_code.
   *
   * @param p_error_code Business key to remove.
   */
  procedure delete_ersh_error_lookup(
    p_error_code                            in ersh_error_lookup.error_code%type
  );


  procedure delete_custom_error(
    p_error_code                            in ersh_error_lookup.error_code%type
  );


  -- =========================================================================
  -- Constraint lookup (ersh_constraint_lookup)
  -- =========================================================================

  /**
   * Inserts or updates a row in ersh_constraint_lookup by constraint_name (MERGE).
   *
   * @param p_constraint_name    Unique constraint name (must not be null).
   * @param p_constraint_message User-facing message for constraint violations.
   */
  procedure merge_ersh_constraint_lookup(
    p_constraint_name                       in ersh_constraint_lookup.constraint_name%type
  , p_constraint_message                    in ersh_constraint_lookup.constraint_message%type
  );


  /**
   * Deletes a row from ersh_constraint_lookup by constraint_name.
   *
   * @param p_constraint_name Business key to remove.
   */
  procedure delete_ersh_constraint_lookup(
    p_constraint_name                       in ersh_constraint_lookup.constraint_name%type
  );


  procedure raise_custom_error(
    p_error_code                            in ersh_error_lookup.error_code%type
  );


  -- ==========================================================================
  -- Incident tracking
  -- ==========================================================================

  /**
   * Inserts or increments a row in ersh_shield_incidents using a 30-second
   * time bucket and a SHA-256 fingerprint as the dedup key (Option A).
   * Autonomous commit so it persists even if the caller rolls back.
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
  );


  -- ==========================================================================
  -- Incident resolution
  -- ==========================================================================

  /**
   * Marks a shield incident as resolved. Sets resolved_yn = 'Y', resolved_by
   * (current APEX/DB user) and resolved_on (current timestamp).
   *
   * @example
   *   ersh_error_handler_api.resolve_incident(
   *       p_incident_id      => 42
   *     , p_resolution_notes => 'Root cause: missing null check in process_payment. Fixed in release 1.2.'
   *   );
   *
   * @issue ERSH-001
   *
   * @param p_incident_id      PK of the ersh_shield_incidents row to resolve
   * @param p_resolution_notes Optional admin notes describing root cause or fix
   */
  procedure resolve_incident(
    p_incident_id                           in ersh_shield_incidents.shield_incident_id%type
  , p_resolution_notes                      in ersh_shield_incidents.resolution_notes%type default null
  );



end ersh_error_handler_api;
/
