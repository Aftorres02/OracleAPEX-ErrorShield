-- =============================================================================
-- View: ersh_jobs_running_vw
-- Purpose: Currently running scheduler jobs (all_scheduler_running_jobs)
--          with job metadata and an over-max-duration flag. Extracted
--          verbatim from the "Running now" region on page 1400.
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_jobs_running_vw
as
with w_running as (
  select r.owner                                                     as owner
       , r.job_name                                                  as job_name
       , r.job_subname                                                as job_subname
       , r.session_id                                                as session_id
       , r.slave_process_id                                          as slave_process_id
       , r.resource_consumer_group                                    as resource_consumer_group
       , round(
           extract(day    from r.elapsed_time) * 86400
         + extract(hour   from r.elapsed_time) * 3600
         + extract(minute from r.elapsed_time) * 60
         + extract(second from r.elapsed_time)
         , 1)                                                        as elapsed_secs
       , round(
           extract(day    from r.cpu_used) * 86400
         + extract(hour   from r.cpu_used) * 3600
         + extract(minute from r.cpu_used) * 60
         + extract(second from r.cpu_used)
         , 2)                                                        as cpu_secs
    from all_scheduler_running_jobs r
)
select w.owner                                                       as owner
     , w.job_name                                                    as job_name
     , w.job_subname                                                  as job_subname
     , w.elapsed_secs                                                as elapsed_secs
     , w.cpu_secs                                                    as cpu_secs
     , w.session_id                                                  as session_id
     , w.slave_process_id                                            as slave_process_id
     , w.resource_consumer_group                                      as resource_consumer_group
     , j.job_type                                                    as job_type
     , j.job_class                                                    as job_class
     , j.state                                                       as state
     , j.max_run_duration                                            as max_run_duration
     , case
         when j.max_run_duration is null then 'N'
         when w.elapsed_secs >
              extract(day    from j.max_run_duration) * 86400
            + extract(hour   from j.max_run_duration) * 3600
            + extract(minute from j.max_run_duration) * 60
            + extract(second from j.max_run_duration) then 'Y'
         else 'N'
       end                                                           as over_max_duration_yn
     , substr(j.job_action, 1, 200)                                   as job_action_head
  from w_running w
  left join all_scheduler_jobs j
    on  j.owner    = w.owner
    and j.job_name = w.job_name
 order by w.elapsed_secs desc;
