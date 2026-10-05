-- =============================================================================
-- Seed data for the ErrorShield Error Lab demo app (10402).
--
-- Run connected as the CONSUMER schema, after elab_customers.sql,
-- elab_orders.sql and elab_errors_api. Re-runnable.
--
--   1. Three customers (merge on customer_code) and a few orders, so the
--      lookups/deletes in elab_errors_api have real rows to trip over.
--   2. ErrorShield registrations, written through ersh_error_handler_api
--      (definer's rights) — the consumer never does DML on ErrorShield's
--      tables directly:
--        - UK_ELAB_CUSTOMERS_CODE and CK_ELAB_ORDERS_QUANTITY get friendly
--          messages -> those two buttons show the message, no incident.
--        - FK_ELAB_ORDERS_CUSTOMERS is deliberately left unregistered ->
--          masked message + incident, to contrast the two paths.
--        - ELAB_CREDIT_LIMIT_EXCEEDED -> the business-rule button. Uses
--          -20000, the same code the 10401 demo's DEMO_BUSINESS_ERROR uses;
--          error-handling.md section 5 still has no -20xxx range convention.
--
-- @author  Angel Flores (Consultant)
-- @created October 03, 2026
-- @ticket  ERSH-049
-- =============================================================================

set define off;

prompt elab_customers data

declare
  l_json clob;
begin
  l_json := q'!
[
  {
    "customer_code": "C-1001",
    "customer_name": "Acme Supplies",
    "credit_limit": 5000
  },
  {
    "customer_code": "C-1002",
    "customer_name": "Globex Retail",
    "credit_limit": 12000
  },
  {
    "customer_code": "C-1003",
    "customer_name": "Initech Labs",
    "credit_limit": 0
  }
]
!';

  for data in (
    select *
      from json_table(l_json, '$[*]' columns
        customer_code varchar2(4000 char) path '$.customer_code'
      , customer_name varchar2(4000 char) path '$.customer_name'
      , credit_limit  number             path '$.credit_limit'
      )
  )
  loop
    merge into elab_customers dest
    using (
      select data.customer_code as customer_code
        from dual
    ) src
    on (dest.customer_code = src.customer_code)
    when matched then
      update
         set dest.customer_name = data.customer_name
           , dest.credit_limit  = data.credit_limit
    when not matched then
      insert (
             customer_code
           , customer_name
           , credit_limit
      )
      values (
             data.customer_code
           , data.customer_name
           , data.credit_limit
      );
  end loop;
end;
/


prompt elab_orders data

-- Orders have no natural key to merge on, so they are only seeded when
-- C-1001 has none yet. force_child_found needs at least one order to exist.
declare
  l_count       pls_integer;
  l_customer_id elab_customers.customer_id%type;
begin
  select c.customer_id                                              as customer_id
    into l_customer_id
    from elab_customers c
   where c.customer_code = 'C-1001';

  select count(1)                                                   as order_count
    into l_count
    from elab_orders o
   where o.customer_id = l_customer_id;

  if l_count = 0 then
    insert
      into elab_orders (
           customer_id
         , quantity
         , status
         , notes
    )
    with w_seed as (
      select 'C-1001'                                               as customer_code
           , 10                                                     as quantity
           , 'NEW'                                                  as status
           , 'First demo order'                                     as notes
        from dual
      union all
      select 'C-1001'                                               as customer_code
           , 25                                                     as quantity
           , 'PAID'                                                 as status
           , 'Second demo order'                                    as notes
        from dual
      union all
      select 'C-1002'                                               as customer_code
           , 5                                                      as quantity
           , 'SHIPPED'                                              as status
           , 'Third demo order'                                     as notes
        from dual
    )
    select c.customer_id                                            as customer_id
         , s.quantity                                               as quantity
         , s.status                                                 as status
         , s.notes                                                  as notes
      from elab_customers                                         c
      join w_seed                                                 s on s.customer_code = c.customer_code;
  end if;

  commit;
end;
/


prompt ErrorShield registrations

begin
  ersh_error_handler_api.merge_ersh_constraint_lookup(
      p_constraint_name               => 'UK_ELAB_CUSTOMERS_CODE'
    , p_constraint_message            => 'That customer code is already in use. Please choose a different one.'
  );

  ersh_error_handler_api.merge_ersh_constraint_lookup(
      p_constraint_name               => 'CK_ELAB_ORDERS_QUANTITY'
    , p_constraint_message            => 'Quantity must be greater than zero.'
  );

  ersh_error_handler_api.merge_ersh_error_lookup(
      p_error_code                    => 'ELAB_CREDIT_LIMIT_EXCEEDED'
    , p_ora_sqlcode                   => -20000
    , p_message                       => 'This order exceeds the customer''s credit limit. Reduce the amount or ask Finance to raise the limit.'
  );

  commit;
end;
/

set define on;
