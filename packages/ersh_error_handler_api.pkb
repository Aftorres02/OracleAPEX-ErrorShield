-- Conditional compilation for verbose logging (see https://rimblas.com/blog/2020/05/debugging-logger-conditional-compilation/).
-- Default off. To enable: alter session set plsql_ccflags = 'VERBOSE_OUTPUT:TRUE'; then recompile.
alter session set plsql_ccflags = 'VERBOSE_OUTPUT:FALSE';
create or replace package body ersh_error_handler_api as

gc_scope_prefix constant varchar2(50) := lower($$plsql_unit) || '.';


gc_support_email          constant varchar2(255) := 'help@netgain.tech';

-- ---------------------------------------------------------------------------
-- Private methods
-- ---------------------------------------------------------------------------







-- ---------------------------------------------------------------------------
-- Public methods
-- ---------------------------------------------------------------------------

/**
 * Description: APEX error handling function. Masks internal errors, maps
 * constraint violations to friendly messages from ersh_constraint_lookup.
 *
 * @author Traust Consulting
 *
 * @created Monday, March 09, 2026
 *
 * @issue
 *
 * @example
 *
 *
 * @param p_error - APEX error record (apex_error.t_error)
 * @return apex_error.t_error_result
 */
function apex_error_handling(
  p_error in apex_error.t_error
)
  return apex_error.t_error_result
is
  l_result          apex_error.t_error_result;
  l_reference_id    number;
  l_constraint_name varchar2(255 char);
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
      -- Log error for example with an autonomous transaction and return
      -- l_reference_id as reference#
      -- l_reference_id := log_error(p_error => p_error);

      -- Change the message to the generic error message which doesn't
      -- expose any sensitive information.
      l_result.message := 'An unexpected internal application error has occurred. '
        || 'Please get in contact with ' || gc_support_email || ' and provide reference# '
        || to_char(l_reference_id, '999G999G999G990')
        || ' for further investigation.';
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
          null;
        -- Not every constraint has to be in our lookup table.
      end;

    end if;

    -- If an ORA error has been raised, for example a
    -- raise_application_error(-20xxx, '...') in a table trigger or in a
    -- PL/SQL package called by a process and we haven't found the error
    -- in our lookup table, then we just want to see the actual error text
    -- and not the full error stack with all the ORA error numbers.
    if p_error.ora_sqlcode is not null and l_result.message = p_error.message then
      l_result.message := apex_error.get_first_ora_error_text(p_error => p_error);
    end if;

    -- If no associated page item/tabular form column has been set, we can
    -- use apex_error.auto_set_associated_item to automatically guess the
    -- affected error field by examine the ORA error for constraint names
    -- or column names.
    if l_result.page_item_name is null and l_result.column_alias is null then
      apex_error.auto_set_associated_item(
        p_error        => p_error
        , p_error_result => l_result
      );
    end if;
  end if;

  return l_result;
end apex_error_handling;








/**
 * Description: Adds a custom error code to the ersh_error_lookup table.
 *
 * @author Traust Consulting
 *
 * @created Monday, March 09, 2026
 *
 * @issue
 *
 * @example
 *   ersh_error_handler_api.add_custom_error(
 *       p_error_code   => 'CURRENCY_FETCH_FAILED'
 *     , p_ora_sqlcode  => -20001
 *     , p_message      => 'Failed to fetch currencies from the external service.'
 *   );
 *
 * @param p_error_code - The error code
 * @param p_ora_sqlcode - The ORA SQL code
 * @param p_message - The message
 */
procedure add_custom_error(
    p_error_code                                        in ersh_error_lookup.error_code%type
  , p_ora_sqlcode                                       in ersh_error_lookup.ora_sqlcode%type
  , p_message                                           in ersh_error_lookup.message%type
)
is
  l_scope  ersh_logger_logs.scope%type := gc_scope_prefix || 'add_custom_error';
  l_params ersh_logger.tab_param;

  l_exists                           number;

begin
  ersh_logger.append_param(l_params, 'p_error_code: ', p_error_code);
  ersh_logger.append_param(l_params, 'p_ora_sqlcode: ', p_ora_sqlcode);
  ersh_logger.append_param(l_params, 'p_message: ', p_message);
  ersh_logger.log('START', l_scope, null, l_params);

  select count(1)
    into l_exists
    from ersh_error_lookup
   where error_code = p_error_code;

  if l_exists > 0 then
    raise_application_error(-20001, 'Error code already exists, try update method instead (ersh_error_handler_api.update_custom_error) ');
  end if;

  insert
    into ersh_error_lookup (
         error_code
      , ora_sqlcode, message
    )
  values (p_error_code
       , p_ora_sqlcode
       , p_message
  );

  ersh_logger.log('END', l_scope, null, l_params);

exception
  when others then
    ersh_logger.log_error('Unhandled Exception', l_scope, null, l_params);
    raise;
end add_custom_error;








/**
 * Description: Updates a custom error code in the ersh_error_lookup table.
 *
 * @author Traust Consulting
 *
 * @created Monday, March 09, 2026
 *
 * @issue
 *
 * @example
 *   ersh_error_handler_api.update_custom_error(
 *       p_error_code   => 'CURRENCY_FETCH_FAILED'
 *     , p_ora_sqlcode  => -20001
 *     , p_message      => 'Unable to load currency data. Please try again later.'
 *   );
 *
 * @param p_error_code - The error code
 * @param p_ora_sqlcode - The ORA SQL code
 * @param p_message - The message
 */
procedure update_custom_error(
    p_error_code                                        in ersh_error_lookup.error_code%type
  , p_ora_sqlcode                                       in ersh_error_lookup.ora_sqlcode%type
  , p_message                                           in ersh_error_lookup.message%type
)
is
  l_scope  ersh_logger_logs.scope%type := gc_scope_prefix || 'update_custom_error';
  l_params ersh_logger.tab_param;

begin
  ersh_logger.append_param(l_params, 'p_error_code: ', p_error_code);
  ersh_logger.append_param(l_params, 'p_ora_sqlcode: ', p_ora_sqlcode);
  ersh_logger.append_param(l_params, 'p_message: ', p_message);
  ersh_logger.log('START', l_scope, null, l_params);

  update ersh_error_lookup
     set ora_sqlcode = p_ora_sqlcode
       , message = p_message
   where error_code = p_error_code;

  ersh_logger.log('END', l_scope, null, l_params);

exception
  when others then
    ersh_logger.log_error('Unhandled Exception', l_scope, null, l_params);
    raise;
end update_custom_error;






/**
 * Description: Deletes a custom error code from the ersh_error_lookup table.
 *
 * @author Traust Consulting
 *
 * @created Monday, March 09, 2026
 *
 * @issue
 *
 * @example
 *
 *
 * @param p_error_code - The error code
 */
procedure delete_custom_error(
    p_error_code                                        in ersh_error_lookup.error_code%type
)
is
  l_scope  ersh_logger_logs.scope%type := gc_scope_prefix || 'delete_custom_error';
  l_params ersh_logger.tab_param;

begin
  ersh_logger.append_param(l_params, 'p_error_code: ', p_error_code);
  ersh_logger.log('START', l_scope, null, l_params);

  delete
    from ersh_error_lookup
   where error_code = p_error_code;

  ersh_logger.log('END', l_scope, null, l_params);

exception
  when others then
    ersh_logger.log_error('Unhandled Exception', l_scope, null, l_params);
    raise;
end delete_custom_error;









/**
 * Description: Raises a custom error code.
 *
 * @author Traust Consulting
 *
 * @created Monday, March 09, 2026
 *
 * @issue
 *
 * @example
 *   ersh_error_handler_api.raise_custom_error(p_error_code => 'CURRENCY_FETCH_FAILED');
 *
 * @param p_error_code - The error code from ersh_error_lookup
 */
procedure raise_custom_error(
    p_error_code                                        in ersh_error_lookup.error_code%type
)
is
  l_scope  ersh_logger_logs.scope%type := gc_scope_prefix || 'raise_custom_error';
  l_params ersh_logger.tab_param;

  l_exists                           number := 0;
  l_ora_sqlcode                      number;
  l_message                          varchar2(4000 char);
begin

  $IF $$VERBOSE_OUTPUT $THEN
  ersh_logger.append_param(l_params, 'p_error_code: ', p_error_code);
  ersh_logger.log('START', l_scope, null, l_params);
  $END

  select count(1)
    into l_exists
    from ersh_error_lookup
   where error_code = p_error_code;

  if l_exists = 0 then
    raise_application_error(-20001, p_error_code || ' code, was not implemented in the ersh_error_lookup table');
  end if;

  select ora_sqlcode
       , message
    into l_ora_sqlcode
       , l_message
    from ersh_error_lookup
   where error_code = p_error_code;

  raise_application_error(l_ora_sqlcode, l_message);

  $IF $$VERBOSE_OUTPUT $THEN
  ersh_logger.log('END', l_scope, null, l_params);
  $END

exception
  when others then
    ersh_logger.log_error('Unhandled Exception', l_scope, null, l_params);
    raise;
end raise_custom_error;




end ersh_error_handler_api;
/