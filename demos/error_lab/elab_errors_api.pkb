create or replace package body elab_errors_api
as
-- =============================================================================
-- Every force_* unit below is DESIGNED to fail, so its trailing
-- logger.log('END', ...) would be unreachable dead code and is intentionally
-- omitted. Each still logs START and its OTHERS exception, per
-- plsql-standards.md section 8 — exactly what a real package would do, so
-- the Logger trail next to each ErrorShield incident looks like production.
-- =============================================================================

  gc_scope_prefix        constant varchar2(31)                      := lower($$plsql_unit) || '.';
  -- Seeded by elab_seed.sql; every unit that needs an existing customer uses it.
  gc_seed_customer_code  constant elab_customers.customer_code%type := 'C-1001';
  -- Always above any seeded credit_limit, so force_business_error always trips.
  gc_demo_order_amount   constant number                            := 999999;








  -- ===========================================================================
  -- PROCEDURE: force_division_by_zero
  -- ===========================================================================
  /**
   * Divides by a row count that is always zero — the classic "average over
   * an empty set" bug. Raises ORA-01476.
   *
   * ErrorShield: unexpected technical error -> logged, incident recorded,
   * message masked when the environment is in MASK_IN_ENVIRONMENTS.
   *
   * @example
   * begin
   *   elab_errors_api.force_division_by_zero;
   * end;
   * /
   * -- Expected: ORA-01476: divisor is equal to zero
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_division_by_zero
  is
    l_scope   logger_logs.scope%type := gc_scope_prefix || 'force_division_by_zero';
    l_average number;
  begin
    logger.log('START', l_scope);

    select 100 / count(1)                                           as average_quantity
      into l_average
      from elab_orders o
     where o.customer_id = -1;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_division_by_zero;








  -- ===========================================================================
  -- PROCEDURE: force_value_error
  -- ===========================================================================
  /**
   * Fetches a customer name into a variable that is too small for it.
   * Raises ORA-06502 (character string buffer too small).
   *
   * ErrorShield: unexpected technical error -> incident, masked.
   *
   * @example
   * begin
   *   elab_errors_api.force_value_error;
   * end;
   * /
   * -- Expected: ORA-06502: PL/SQL: value or conversion error: character string buffer too small
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_value_error
  is
    l_scope      logger_logs.scope%type := gc_scope_prefix || 'force_value_error';
    l_short_name varchar2(3 char);
  begin
    logger.log('START', l_scope);

    select c.customer_name                                          as customer_name
      into l_short_name
      from elab_customers c
     where c.customer_code = gc_seed_customer_code
       and c.active_yn     = 'Y';
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_value_error;








  -- ===========================================================================
  -- PROCEDURE: force_invalid_number
  -- ===========================================================================
  /**
   * Converts an alphanumeric customer code ('C-1001') to a number — a data
   * type mismatch. Raises ORA-01722 (invalid number).
   *
   * ErrorShield: unexpected technical error -> incident, masked.
   *
   * @example
   * begin
   *   elab_errors_api.force_invalid_number;
   * end;
   * /
   * -- Expected: ORA-01722: unable to convert string value containing 'C' to a number: CUSTOMER_CODE
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_invalid_number
  is
    l_scope           logger_logs.scope%type := gc_scope_prefix || 'force_invalid_number';
    l_customer_number number;
  begin
    logger.log('START', l_scope);

    select to_number(c.customer_code)                               as customer_number
      into l_customer_number
      from elab_customers c
     where c.customer_code = gc_seed_customer_code
       and c.active_yn     = 'Y';
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_invalid_number;








  -- ===========================================================================
  -- PROCEDURE: force_invalid_date
  -- ===========================================================================
  /**
   * Converts February 31st to a date — what a free-text date field lets a
   * user type. Raises ORA-01839 (date not valid for month specified).
   *
   * ErrorShield: unexpected technical error -> incident, masked.
   *
   * @example
   * begin
   *   elab_errors_api.force_invalid_date;
   * end;
   * /
   * -- Expected: ORA-01839: date not valid for month specified
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_invalid_date
  is
    l_scope         logger_logs.scope%type := gc_scope_prefix || 'force_invalid_date';
    l_delivery_date date;
  begin
    logger.log('START', l_scope);

    select to_date('31/02/2026', 'DD/MM/YYYY')                      as delivery_date
      into l_delivery_date
      from dual;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_invalid_date;








  -- ===========================================================================
  -- PROCEDURE: force_no_data_found
  -- ===========================================================================
  /**
   * Looks up a customer id that does not exist with a bare select-into.
   * Raises ORA-01403 (no data found).
   *
   * ErrorShield: unexpected technical error -> incident, masked.
   *
   * @example
   * begin
   *   elab_errors_api.force_no_data_found;
   * end;
   * /
   * -- Expected: ORA-01403: no data found
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_no_data_found
  is
    l_scope         logger_logs.scope%type := gc_scope_prefix || 'force_no_data_found';
    l_customer_name elab_customers.customer_name%type;
  begin
    logger.log('START', l_scope);

    select c.customer_name                                          as customer_name
      into l_customer_name
      from elab_customers c
     where c.customer_id = -1;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_no_data_found;








  -- ===========================================================================
  -- PROCEDURE: force_too_many_rows
  -- ===========================================================================
  /**
   * Select-into over every active customer (the seed creates three).
   * Raises ORA-01422 (exact fetch returns more than requested number of rows).
   *
   * ErrorShield: unexpected technical error -> incident, masked.
   *
   * @example
   * begin
   *   elab_errors_api.force_too_many_rows;
   * end;
   * /
   * -- Expected: ORA-01422: exact fetch returned more than the requested number of rows
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_too_many_rows
  is
    l_scope         logger_logs.scope%type := gc_scope_prefix || 'force_too_many_rows';
    l_customer_name elab_customers.customer_name%type;
  begin
    logger.log('START', l_scope);

    select c.customer_name                                          as customer_name
      into l_customer_name
      from elab_customers c
     where c.active_yn = 'Y';
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_too_many_rows;








  -- ===========================================================================
  -- PROCEDURE: force_value_too_large
  -- ===========================================================================
  /**
   * Inserts a 47-character name into elab_customers.customer_name
   * (varchar2(30 char)). Raises ORA-12899 (value too large for column).
   *
   * ErrorShield: unexpected technical error -> incident, masked.
   *
   * @example
   * begin
   *   elab_errors_api.force_value_too_large;
   * end;
   * /
   * -- Expected: ORA-12899: value too large for column "WKSP_DEVAI1"."ELAB_CUSTOMERS"."CUSTOMER_NAME" (actual: 47, maximum: 30)
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_value_too_large
  is
    l_scope logger_logs.scope%type := gc_scope_prefix || 'force_value_too_large';
  begin
    logger.log('START', l_scope);

    insert
      into elab_customers (
           customer_code
         , customer_name
    )
    values (
           'C-9001'
         , 'Consolidated International Holdings Corporation'
    );
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_value_too_large;








  -- ===========================================================================
  -- PROCEDURE: force_numeric_overflow
  -- ===========================================================================
  /**
   * Inserts quantity 1,000,000 into elab_orders.quantity (number(5)).
   * Raises ORA-01438 (value larger than specified precision allowed for this
   * column) — the numeric twin of ORA-12899.
   *
   * ErrorShield: unexpected technical error -> incident, masked.
   *
   * @example
   * begin
   *   elab_errors_api.force_numeric_overflow;
   * end;
   * /
   * -- Expected: ORA-01438: value 1000000 greater than specified precision (5, 0) for column
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_numeric_overflow
  is
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'force_numeric_overflow';
    l_customer_id elab_customers.customer_id%type;
  begin
    logger.log('START', l_scope);

    select c.customer_id                                            as customer_id
      into l_customer_id
      from elab_customers c
     where c.customer_code = gc_seed_customer_code
       and c.active_yn     = 'Y';

    insert
      into elab_orders (
           customer_id
         , quantity
    )
    values (
           l_customer_id
         , 1000000
    );
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_numeric_overflow;








  -- ===========================================================================
  -- PROCEDURE: force_not_null
  -- ===========================================================================
  /**
   * Inserts a customer without the mandatory name.
   * Raises ORA-01400 (cannot insert NULL into ... CUSTOMER_NAME).
   *
   * ErrorShield: unexpected technical error -> incident, masked.
   *
   * @example
   * begin
   *   elab_errors_api.force_not_null;
   * end;
   * /
   * -- Expected: ORA-01400: cannot insert NULL into ("WKSP_DEVAI1"."ELAB_CUSTOMERS"."CUSTOMER_NAME")
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_not_null
  is
    l_scope logger_logs.scope%type := gc_scope_prefix || 'force_not_null';
  begin
    logger.log('START', l_scope);

    insert
      into elab_customers (
           customer_code
         , customer_name
    )
    values (
           'C-9002'
         , null
    );
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_not_null;








  -- ===========================================================================
  -- PROCEDURE: force_unique_violation
  -- ===========================================================================
  /**
   * Inserts a second customer with the seeded code 'C-1001'.
   * Raises ORA-00001 (unique constraint UK_ELAB_CUSTOMERS_CODE violated).
   *
   * ErrorShield: UK_ELAB_CUSTOMERS_CODE is registered in
   * ersh_constraint_lookup (elab_seed.sql), so the user gets the friendly
   * message and NO incident is recorded — a known, user-correctable error.
   *
   * @example
   * begin
   *   elab_errors_api.force_unique_violation;
   * end;
   * /
   * -- Expected: ORA-00001: unique constraint (WKSP_DEVAI1.UK_ELAB_CUSTOMERS_CODE) violated on table ...
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_unique_violation
  is
    l_scope logger_logs.scope%type := gc_scope_prefix || 'force_unique_violation';
  begin
    logger.log('START', l_scope);

    insert
      into elab_customers (
           customer_code
         , customer_name
    )
    values (
           gc_seed_customer_code
         , 'Duplicate Acme Supplies'
    );
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_unique_violation;








  -- ===========================================================================
  -- PROCEDURE: force_check_violation
  -- ===========================================================================
  /**
   * Inserts an order with quantity 0.
   * Raises ORA-02290 (check constraint CK_ELAB_ORDERS_QUANTITY violated).
   *
   * ErrorShield: CK_ELAB_ORDERS_QUANTITY is registered in
   * ersh_constraint_lookup (elab_seed.sql) -> friendly message, NO incident.
   *
   * @example
   * begin
   *   elab_errors_api.force_check_violation;
   * end;
   * /
   * -- Expected: ORA-02290: check constraint (WKSP_DEVAI1.CK_ELAB_ORDERS_QUANTITY) violated
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_check_violation
  is
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'force_check_violation';
    l_customer_id elab_customers.customer_id%type;
  begin
    logger.log('START', l_scope);

    select c.customer_id                                            as customer_id
      into l_customer_id
      from elab_customers c
     where c.customer_code = gc_seed_customer_code
       and c.active_yn     = 'Y';

    insert
      into elab_orders (
           customer_id
         , quantity
    )
    values (
           l_customer_id
         , 0
    );
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_check_violation;








  -- ===========================================================================
  -- PROCEDURE: force_parent_not_found
  -- ===========================================================================
  /**
   * Inserts an order for customer_id -1, which does not exist.
   * Raises ORA-02291 (integrity constraint FK_ELAB_ORDERS_CUSTOMERS violated
   * - parent key not found).
   *
   * ErrorShield: FK_ELAB_ORDERS_CUSTOMERS is deliberately NOT registered in
   * ersh_constraint_lookup, so it falls through to the unexpected-error path
   * -> incident, masked. Compare with force_check_violation.
   *
   * @example
   * begin
   *   elab_errors_api.force_parent_not_found;
   * end;
   * /
   * -- Expected: ORA-02291: integrity constraint (WKSP_DEVAI1.FK_ELAB_ORDERS_CUSTOMERS) violated - parent key not found
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_parent_not_found
  is
    l_scope logger_logs.scope%type := gc_scope_prefix || 'force_parent_not_found';
  begin
    logger.log('START', l_scope);

    insert
      into elab_orders (
           customer_id
         , quantity
    )
    values (
           -1
         , 1
    );
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_parent_not_found;








  -- ===========================================================================
  -- PROCEDURE: force_child_found
  -- ===========================================================================
  /**
   * Deletes a customer that still has orders, by primary key.
   * Raises ORA-02292 (integrity constraint FK_ELAB_ORDERS_CUSTOMERS violated
   * - child record found).
   *
   * The parent is picked FROM elab_orders, so it always has children; if
   * every order were ever removed this raises ORA-01403 instead of wiping a
   * seed customer. Deleted by primary key on purpose: a set-based
   * "delete ... where exists" runs as parallel DML on Autonomous Database
   * and surfaces as ORA-12801 wrapping the ORA-02292.
   *
   * ErrorShield: unregistered constraint -> incident, masked.
   *
   * @example
   * begin
   *   elab_errors_api.force_child_found;
   * end;
   * /
   * -- Expected: ORA-02292: integrity constraint (WKSP_DEVAI1.FK_ELAB_ORDERS_CUSTOMERS) violated - child record found
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_child_found
  is
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'force_child_found';
    l_customer_id elab_customers.customer_id%type;
  begin
    logger.log('START', l_scope);

    select o.customer_id                                            as customer_id
      into l_customer_id
      from elab_orders o
     order by o.order_id
     fetch first 1 row only;

    delete
      from elab_customers c
     where c.customer_id = l_customer_id;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope);
      raise;
  end force_child_found;








  -- ===========================================================================
  -- PROCEDURE: force_business_error
  -- ===========================================================================
  /**
   * Places an order above the seed customer's credit limit and refuses it
   * through ersh_error_handler_api.raise_custom_error
   * ('ELAB_CREDIT_LIMIT_EXCEEDED', registered by elab_seed.sql).
   *
   * ErrorShield: -20xxx is a developer-intentional error -> the registered
   * message is shown as written, nothing logged, NO incident.
   *
   * Follows the ERSH-022/023 lesson: the risky lookup has its own handler,
   * and the intentional raise sits outside any exception handler, so it is
   * never logged as an "Unhandled Exception".
   *
   * @example
   * begin
   *   elab_errors_api.force_business_error;
   * end;
   * /
   * -- Expected: ORA-20000: This order exceeds the customer's credit limit. ...
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   */
  procedure force_business_error
  is
    l_scope        logger_logs.scope%type := gc_scope_prefix || 'force_business_error';
    l_credit_limit elab_customers.credit_limit%type;
  begin
    logger.log('START', l_scope);

    begin
      select c.credit_limit                                         as credit_limit
        into l_credit_limit
        from elab_customers c
       where c.customer_code = gc_seed_customer_code
         and c.active_yn     = 'Y';
    exception
      when others then
        logger.log_error('Unhandled Exception', l_scope);
        raise;
    end;

    if gc_demo_order_amount > l_credit_limit then
      ersh_error_handler_api.raise_custom_error(
          p_error_code                  => 'ELAB_CREDIT_LIMIT_EXCEEDED'
      );
    end if;

    logger.log('END', l_scope);
  end force_business_error;








  -- ===========================================================================
  -- PROCEDURE: force_error
  -- ===========================================================================
  /**
   * Dispatches to one force_* unit by scenario code. Used by the AJAX
   * scenarios, which receive the code from the browser (apex.server.process
   * x01 / a Dynamic Action) instead of a page submit request.
   *
   * No OTHERS handler on purpose: the dispatched unit already logged its own
   * failure (logging again would duplicate every Logger row), and
   * force_business_error's intentional -20xxx must never be logged at all.
   * No "else" branch on purpose either: an unknown scenario raises
   * CASE_NOT_FOUND (ORA-06592), which is just one more unexpected error.
   *
   * @example
   * begin
   *   elab_errors_api.force_error(
   *       p_scenario                           => 'DIVIDE_BY_ZERO'
   *   );
   * end;
   * /
   * -- Expected: ORA-01476: divisor is equal to zero
   *
   * @issue   ERSH-049
   *
   * @author  Angel Flores (Consultant)
   * @created October 03, 2026
   *
   * @param p_scenario Scenario code, e.g. DIVIDE_BY_ZERO, INVALID_NUMBER,
   *                   UNIQUE_VIOLATION, BUSINESS_ERROR (case-insensitive).
   */
  procedure force_error(
      p_scenario                                in varchar2
  )
  is
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'force_error';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'p_scenario', p_scenario);
    logger.log('START', l_scope, null, l_params);

    case upper(p_scenario)
      when 'DIVIDE_BY_ZERO'    then force_division_by_zero;
      when 'VALUE_ERROR'       then force_value_error;
      when 'INVALID_NUMBER'    then force_invalid_number;
      when 'INVALID_DATE'      then force_invalid_date;
      when 'NO_DATA_FOUND'     then force_no_data_found;
      when 'TOO_MANY_ROWS'     then force_too_many_rows;
      when 'VALUE_TOO_LARGE'   then force_value_too_large;
      when 'NUMERIC_OVERFLOW'  then force_numeric_overflow;
      when 'NOT_NULL'          then force_not_null;
      when 'UNIQUE_VIOLATION'  then force_unique_violation;
      when 'CHECK_VIOLATION'   then force_check_violation;
      when 'PARENT_NOT_FOUND'  then force_parent_not_found;
      when 'CHILD_FOUND'       then force_child_found;
      when 'BUSINESS_ERROR'    then force_business_error;
    end case;

    logger.log('END', l_scope, null, l_params);
  end force_error;


end elab_errors_api;
/
