-- =============================================================================
-- View: ersh_jobs_recent_failures_vw
-- Purpose: Most recent 20 non-successful scheduler runs in the last 72
--          hours. Extracted verbatim from the "Recent failures - 72 h"
--          region on page 1000 (Jobs - Dashboard).
--
-- Note: the ORDER BY / FETCH FIRST 20 ROWS stays inside the CTE (rather
--       than moving to the outer SELECT) because it determines which 20
--       rows are returned at all, not just their display order.
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_jobs_recent_failures_vw
as
with w_base as (
  select d.log_id                                           as log_id
       , d.owner                                            as owner
       , d.job_name                                         as job_name
       , d.status                                           as status
       , d.error#                                           as error_code
       , to_char(d.actual_start_date, 'YYYY-MM-DD HH24:MI') as started_at
       , round(
           extract(day    from d.run_duration) * 86400
         + extract(hour   from d.run_duration) * 3600
         + extract(minute from d.run_duration) * 60
         + extract(second from d.run_duration)
         , 1)                                               as run_secs
       , substr(d.additional_info, 1, 200)                  as additional_info
    from all_scheduler_job_run_details d
   where d.log_date >= systimestamp - interval '3' day
     and nvl(d.status, 'UNKNOWN') <> 'SUCCEEDED'
   order by d.log_date desc
   fetch first 20 rows only
)
select log_id
     , owner
     , job_name
     , status
     , error_code
     , started_at
     , run_secs
     , additional_info
  from w_base;
