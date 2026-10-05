-- =============================================================================
-- ErrorShield Error Lab — uninstall (consumer schema)
-- =============================================================================
-- Removes everything install_error_lab.sql created: app 10402, the ELAB_*
-- objects, and the three ErrorShield registrations from elab_seed.sql.
--
-- Leaves the incidents the lab already recorded in the owner schema alone —
-- they are real history, cleared the normal way (resolve, or
-- ersh_error_handler_api.purge_incidents) from the admin app.
--
-- Usage (connected as the consumer schema):
--   @demos/error_lab/uninstall_error_lab.sql <APEX_WORKSPACE>
--
-- &1 = APEX workspace that owns the consumer schema (e.g. DEV_AI_1).
--
-- @ticket ERSH-049
-- =============================================================================

set serveroutput on size unlimited;
set define on;
set verify off;

define elab_workspace = '&1'
define elab_app_id    = 10402

whenever sqlerror exit sql.sqlcode


prompt *** Removing app &elab_app_id. from workspace &elab_workspace. ***

declare
  l_count pls_integer;
begin
  select count(1)                                                   as app_count
    into l_count
    from apex_applications a
   where a.application_id = &elab_app_id.;

  if l_count > 0 then
    apex_application_install.set_workspace(
        p_workspace                     => '&elab_workspace.'
    );
    apex_application_install.remove_application(
        p_application_id                => &elab_app_id.
    );
    commit;
  end if;
end;
/


prompt *** Removing ErrorShield registrations ***

begin
  ersh_error_handler_api.delete_ersh_constraint_lookup(
      p_constraint_name               => 'UK_ELAB_CUSTOMERS_CODE'
  );

  ersh_error_handler_api.delete_ersh_constraint_lookup(
      p_constraint_name               => 'CK_ELAB_ORDERS_QUANTITY'
  );

  ersh_error_handler_api.delete_ersh_error_lookup(
      p_error_code                    => 'ELAB_CREDIT_LIMIT_EXCEEDED'
  );
  commit;
end;
/


prompt *** Dropping ELAB_* objects ***

declare
  procedure drop_if_exists(
      p_object_type                             in varchar2
    , p_object_name                             in varchar2
  )
  is
    l_count pls_integer;
  begin
    select count(1)                                                 as object_count
      into l_count
      from user_objects o
     where o.object_type = p_object_type
       and o.object_name = p_object_name;

    if l_count > 0 then
      execute immediate 'drop ' || p_object_type || ' ' || dbms_assert.simple_sql_name(p_object_name)
                        || case when p_object_type = 'TABLE' then ' purge' end;
    end if;
  end drop_if_exists;
begin
  drop_if_exists(
      p_object_type                   => 'PACKAGE'
    , p_object_name                   => 'ELAB_ERRORS_API'
  );

  drop_if_exists(
      p_object_type                   => 'TABLE'
    , p_object_name                   => 'ELAB_ORDERS'
  );

  drop_if_exists(
      p_object_type                   => 'TABLE'
    , p_object_name                   => 'ELAB_CUSTOMERS'
  );
end;
/

prompt *** Error Lab removed ***
