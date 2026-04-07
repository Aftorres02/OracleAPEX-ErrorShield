-- Grants privileges on ersh_logger objects from the current user to a defined user


-- Parameters
define to_user = '&1' -- This is the user to grant the permissions to


whenever sqlerror exit sql.sqlcode

grant execute on ersh_logger to &to_user;
grant select, delete on ersh_logger_logs to &to_user;
grant select on ersh_logger_logs_apex_items to &to_user;
grant select, update on ersh_logger_prefs to &to_user;
grant select on ersh_logger_prefs_by_client_id to &to_user;
grant select on ersh_logger_logs_5_min to &to_user;
grant select on ersh_logger_logs_60_min to &to_user;
grant select on ersh_logger_logs_terse to &to_user;
