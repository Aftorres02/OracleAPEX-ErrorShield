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


set define &

-- Parameters
define to_user = '&1'


whenever sqlerror exit sql.sqlcode

prompt *** Granting ErrorShield privileges to &to_user ***

-- Packages
grant execute on ersh_error_handler_api to &to_user;

-- Tables
grant select, insert, update, delete on ersh_error_lookup      to &to_user;
grant select, insert, update, delete on ersh_constraint_lookup to &to_user;
grant select, insert, update, delete on ersh_shield_incidents  to &to_user;

-- Views (select only — DML goes through the package)
grant select on ersh_shield_incidents_vw to &to_user;

prompt *** ErrorShield grants to &to_user completed successfully ***
