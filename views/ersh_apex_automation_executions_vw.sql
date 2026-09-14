-- =============================================================================
-- View: ersh_apex_automation_executions_vw
-- Purpose: APEX Automation executions in the last 7 days
--          (apex_automation_log). Extracted verbatim from the
--          "Executions - 7 days" region on page 1600 (APEX Automations).
--          The 7-day window is a fixed business rule, not a page-item
--          bind, so it stays in the view per the extraction rules.
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_apex_automation_executions_vw
as
with w_log as (
  select l.id                                                        as log_id
       , l.application_id                                            as application_id
       , l.automation_id                                             as automation_id
       , l.automation_name                                           as automation_name
       , l.is_job                                                    as is_job
       , l.status                                                    as status
       , l.start_timestamp                                           as start_timestamp
       , l.end_timestamp                                             as end_timestamp
       , l.successful_row_count                                      as successful_row_count
       , l.error_row_count                                           as error_row_count
       , l.end_timestamp - l.start_timestamp                         as run_interval
    from apex_automation_log l
   where l.start_timestamp >= systimestamp - interval '7' day
)
select w.log_id                                                      as log_id
     , w.application_id                                              as application_id
     , w.automation_name                                             as automation_name
     , w.status                                                      as status
     , w.is_job                                                      as is_job
     , to_char(w.start_timestamp, 'YYYY-MM-DD HH24:MI:SS')           as started_at
     , round(
         extract(day    from w.run_interval) * 86400
       + extract(hour   from w.run_interval) * 3600
       + extract(minute from w.run_interval) * 60
       + extract(second from w.run_interval)
       , 1)                                                          as duration_secs
     , w.successful_row_count                                        as successful_row_count
     , w.error_row_count                                             as error_row_count
  from w_log w
 order by w.start_timestamp desc;
