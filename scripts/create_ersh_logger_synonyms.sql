-- Creates synonyms from a defined user for ErrorShield ersh_logger objects


-- Parameters
define from_user = '&1' -- Schema that owns the ersh_logger objects


whenever sqlerror exit sql.sqlcode

create or replace synonym ersh_logger for &from_user..ersh_logger;
create or replace synonym ersh_logger_logs for &from_user..ersh_logger_logs;
create or replace synonym ersh_logger_logs_apex_items for &from_user..ersh_logger_logs_apex_items;
create or replace synonym ersh_logger_prefs for &from_user..ersh_logger_prefs;
create or replace synonym ersh_logger_prefs_by_client_id for &from_user..ersh_logger_prefs_by_client_id;
create or replace synonym ersh_logger_logs_5_min for &from_user..ersh_logger_logs_5_min;
create or replace synonym ersh_logger_logs_60_min for &from_user..ersh_logger_logs_60_min;
create or replace synonym ersh_logger_logs_terse for &from_user..ersh_logger_logs_terse;
