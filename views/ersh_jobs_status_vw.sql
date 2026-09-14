-- =============================================================================
-- View: ersh_jobs_status_vw
-- Purpose: Dashboard status summary (visible/enabled/broken/running job
--          counts plus 24h failed run count). Extracted verbatim from the
--          "Status" region on page 1000 (Jobs - Dashboard).
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_jobs_status_vw
as
with w_jobs as (
  select count(*)                                                    as visible_cnt
       , count(case when j.enabled = 'TRUE'              then 1 end) as enabled_cnt
       , count(case when j.state in ('BROKEN', 'FAILED') then 1 end) as broken_cnt
    from all_scheduler_jobs j
)
, w_running as (
  select count(*)                                                    as running_cnt
    from all_scheduler_running_jobs r
)
, w_failed as (
  select count(*)                                                    as failed_cnt
    from all_scheduler_job_run_details d
   where d.log_date >= systimestamp - interval '1' day
     and nvl(d.status, 'UNKNOWN') <> 'SUCCEEDED'
)
select j.visible_cnt                                                 as visible_jobs
     , j.enabled_cnt                                                 as enabled
     , j.broken_cnt                                                  as broken_or_failed
     , r.running_cnt                                                 as running_now
     , f.failed_cnt                                                  as failed_runs_24h
  from w_jobs      j
 cross join w_running r
 cross join w_failed  f;
