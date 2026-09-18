-- Grants privileges for ErrorShield objects from the current (owner) schema
-- to a defined consumer user.
--
-- Usage (run connected as the ErrorShield owner schema):
--   @grant_ersh_to_user.sql MY_APP_SCHEMA
--
-- &1 = the consumer schema that will use ErrorShield via synonyms.
--      After running this script, connect as &1 and run:
--        @scripts/consumer/create_ersh_synonyms.sql <owner_schema>
--        @scripts/consumer/create_logger_synonyms.sql <owner_schema>
--
-- ERSH-012: consumers only ever need to READ these tables directly (their own
-- dashboards/reports); every write goes through ersh_error_handler_api, which
-- runs with the OWNER's definer rights. insert/update/delete were never
-- required and let a consumer schema delete its own incidents or rewrite
-- business messages directly. select on all three is kept — a decision, not
-- an oversight to optimize away.


set define &

-- Parameters
define to_user = '&1'


whenever sqlerror exit sql.sqlcode

prompt *** Granting ErrorShield privileges to &to_user ***

-- Packages
grant execute on ersh_error_handler_api to &to_user;

-- Tables (select only — DML goes through the package)
grant select on ersh_error_lookup      to &to_user;
grant select on ersh_constraint_lookup to &to_user;
grant select on ersh_shield_incidents  to &to_user;

-- Views
grant select on ersh_shield_incidents_vw to &to_user;

prompt *** ErrorShield grants to &to_user completed successfully ***


-- =============================================================================
-- ERSH-012: revoke DML for consumer schemas granted it under a previous
-- version of this script. Each revoke is wrapped so a consumer that never
-- had the privilege (e.g. a brand-new onboarding, granted select-only above)
-- does not abort the script with ORA-01927.
-- =============================================================================
whenever sqlerror continue

prompt *** Revoking legacy DML grants from &to_user (if present) ***

declare
  procedure revoke_dml(p_table_name in varchar2) is
  begin
    execute immediate 'revoke insert, update, delete on ' || p_table_name || ' from &to_user';
  exception
    when others then
      if sqlcode != -1927 then raise; end if;
  end revoke_dml;
begin
  revoke_dml('ersh_error_lookup');
  revoke_dml('ersh_constraint_lookup');
  revoke_dml('ersh_shield_incidents');
end;
/

whenever sqlerror exit sql.sqlcode

prompt *** ErrorShield legacy DML revoke for &to_user completed ***
