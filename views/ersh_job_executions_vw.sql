-- =============================================================================
-- View: ersh_job_executions_vw
-- Purpose: Scheduler run history (all_scheduler_job_run_details) with
--          current job state joined in. Extracted verbatim from the
--          "Job-Executions" region on page 1300, minus the day-window /
--          status / job_name filter (moved to the region's Where Clause
--          — see p01300-job-executions.apx).
--
-- Note: log_date is exposed in the outer select (it was previously only
--       used internally for filtering/ordering) so the region's relocated
--       Where Clause has a column to filter the day window on.
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_job_executions_vw
as
with w_runs as (
  select r.owner                                          as owner
       , r.job_name                                       as job_name
       , r.job_subname                                     as job_subname
       , r.log_id                                         as log_id
       , r.log_date                                        as log_date
       , r.status                                         as status
       , r.error#                                        as error_code
       , r.req_start_date                                 as req_start_date
       , r.actual_start_date                              as actual_start_date
       , r.session_id                                     as session_id
       , r.additional_info                                as additional_info
       , round(
           extract(day    from r.run_duration) * 86400
         + extract(hour   from r.run_duration) * 3600
         + extract(minute from r.run_duration) * 60
         + extract(second from r.run_duration)
         , 1)                                              as run_secs
       , round(
           extract(day    from r.cpu_used) * 86400
         + extract(hour   from r.cpu_used) * 3600
         + extract(minute from r.cpu_used) * 60
         + extract(second from r.cpu_used)
         , 2)                                              as cpu_secs
    from all_scheduler_job_run_details r
)
select w.log_id                                           as log_id
     , w.owner                                            as owner
     , w.job_name                                         as job_name
     , w.job_subname                                      as job_subname
     , w.log_date                                         as log_date
     , w.status                                           as status
     , w.error_code                                       as error_code
     , w.actual_start_date                                as actual_start_date
     , w.req_start_date                                   as req_start_date
     , w.run_secs                                         as run_secs
     , w.cpu_secs                                         as cpu_secs
     , w.session_id                                       as session_id
     , w.additional_info                                  as additional_info
     , case when j.job_name is null then 'Y' else 'N' end as job_dropped_yn
     , j.state                                            as current_state
     , j.job_class                                        as job_class
  from w_runs w
  left join all_scheduler_jobs j
    on  j.owner    = w.owner
    and j.job_name = w.job_name
 order by nvl(w.actual_start_date, w.log_date) desc;
