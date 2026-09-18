-- =============================================================================
-- Seed data for the ErrorShield Demo app (apex/apex_lang/app_10401).
--
-- Run this once, connected as the ErrorShield owner schema, before importing
-- or using app 10401. It is NOT part of release/_release.sql: the demo app
-- is optional and kept entirely separate from the real admin app (10400).
--
-- Creates one demo-only table (errorshield_demo_orders) with a single check
-- constraint, used by the demo's "Constraint Violation" button, plus the
-- ersh_constraint_lookup / ersh_error_lookup rows the demo's four buttons
-- need to exercise ErrorShield's decision tree end to end.
-- =============================================================================

declare
  l_count pls_integer;
begin
  select count(1)
    into l_count
    from user_tables
   where table_name = 'ERRORSHIELD_DEMO_ORDERS';

  if l_count = 0 then
    execute immediate q'!
      create table errorshield_demo_orders (
          order_id  number not null
        , quantity  number not null
        , constraint ck_errorshield_demo_orders_qty check (quantity > 0)
      )
    !';
  end if;
end;
/

begin
  execute immediate 'comment on table errorshield_demo_orders is ''Demo-only table for the ErrorShield Demo app (10401). Not part of the real product.''';
end;
/

-- b) Constraint Violation button: friendly message for the check constraint above.
begin
  ersh_error_handler_api.merge_ersh_constraint_lookup(
    p_constraint_name    => 'CK_ERRORSHIELD_DEMO_ORDERS_QTY'
  , p_constraint_message => 'Quantity must be greater than zero.'
  );
end;
/

-- c) Business Error button: raise_custom_error(-20000) via a registered code.
begin
  ersh_error_handler_api.merge_ersh_error_lookup(
    p_error_code   => 'DEMO_BUSINESS_ERROR'
  , p_ora_sqlcode  => -20000
  , p_message      => 'This is a demo business-rule error. In a real app, this message would explain what the user needs to fix.'
  );
end;
/
