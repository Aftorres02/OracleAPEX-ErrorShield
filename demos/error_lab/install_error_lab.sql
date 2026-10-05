-- =============================================================================
-- ErrorShield Error Lab — install (consumer schema)
-- =============================================================================
-- Installs the Error Lab demo app (10402) into a CONSUMER schema: one that
-- does not own ErrorShield and reaches it only through synonyms. Every error
-- the lab raises lands in the OWNER schema's ersh_shield_incidents (definer's
-- rights), where the admin app (10400) shows it.
--
-- Not part of release/_release.sql — like the 10401 demo, it is optional.
--
-- Prerequisites (once per consumer schema):
--   1. Connected as the ErrorShield owner:
--        @scripts/grant_ersh_to_user.sql   <CONSUMER_SCHEMA>
--        @scripts/grant_logger_to_user.sql <CONSUMER_SCHEMA>
--   2. Connected as the consumer:
--        @scripts/consumer/create_ersh_synonyms.sql   <OWNER_SCHEMA>
--        @scripts/consumer/create_logger_synonyms.sql <OWNER_SCHEMA>
--
-- Usage (connected as the consumer schema; any working directory — SQLcl
-- resolves the apex import path below relative to this script's folder):
--   sql <consumer-connection>
--   @demos/error_lab/install_error_lab.sql <APEX_WORKSPACE>
--
-- &1 = APEX workspace that owns the consumer schema (e.g. DEV_AI_1).
--
-- Re-runnable: DDL is idempotent, seed data merges, and the import targets
-- the fixed id 10402 (a plain `apex import` without -id mints a new id on
-- every run).
--
-- @ticket ERSH-049
-- =============================================================================

set serveroutput on size unlimited;
set define on;
set verify off;

define elab_workspace = '&1'
define elab_app_id    = 10402

column elab_schema new_value elab_schema noprint
select user as elab_schema
  from dual;

whenever sqlerror exit sql.sqlcode


prompt *** Checking ErrorShield / Logger synonyms in &elab_schema. ***

declare
  l_count pls_integer;
begin
  select count(1)                                                   as synonym_count
    into l_count
    from user_synonyms
   where synonym_name in ('ERSH_ERROR_HANDLER_API', 'ERSH_SHIELD_INCIDENTS_VW', 'LOGGER', 'LOGGER_LOGS');

  if l_count < 4 then
    raise_application_error(
        -20001
      , 'ErrorShield/Logger synonyms are missing in this schema. Run the grant and synonym scripts listed in the header of install_error_lab.sql first.'
    );
  end if;
end;
/


prompt *** Tables ***
@@elab_customers.sql
@@elab_orders.sql

prompt *** Package ***
@@elab_errors_api.pks
@@elab_errors_api.pkb

prompt *** Seed data and ErrorShield registrations ***
@@elab_seed.sql


prompt *** Validating ELAB_* objects ***

declare
  l_invalid varchar2(4000 char);
begin
  select listagg(o.object_type || ' ' || o.object_name, ', ')
           within group (order by o.object_name)                    as invalid_objects
    into l_invalid
    from user_objects o
   where o.object_name like 'ELAB\_%' escape '\'
     and o.status <> 'VALID';

  if l_invalid is not null then
    raise_application_error(
        -20002
      , 'Invalid Error Lab objects after install: ' || l_invalid
    );
  end if;
end;
/


prompt *** Importing Error Lab app &elab_app_id. (schema: &elab_schema., workspace: &elab_workspace.) ***
apex import -input ../../apex/apex_lang/app_10402 -id &elab_app_id. -schema &elab_schema. -workspace &elab_workspace.

-- `whenever sqlerror` does not trap a failed `apex import` (it is a SQLcl
-- command, not SQL), so confirm the app actually exists before claiming
-- success.
declare
  l_count pls_integer;
begin
  select count(1)                                                   as app_count
    into l_count
    from apex_applications a
   where a.application_id = &elab_app_id.;

  if l_count = 0 then
    raise_application_error(
        -20002
      , 'apex import did not create application &elab_app_id.. Check the import output above.'
    );
  end if;
end;
/

prompt *** Error Lab installed. Open app &elab_app_id. in workspace &elab_workspace. ***
