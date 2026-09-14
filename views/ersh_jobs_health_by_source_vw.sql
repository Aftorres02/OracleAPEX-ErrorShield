-- =============================================================================
-- View: ersh_jobs_health_by_source_vw
-- Purpose: Job counts (total/problem/running/disabled) grouped by job source
--          (DBMS_JOB legacy vs SCHEDULER). Extracted verbatim from the
--          "Health by source" region on page 1000 (Jobs - Dashboard).
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_jobs_health_by_source_vw
as
with w_jobs as (
  select case
           when j.job_name like 'DBMS\_JOB$\_%' escape '\' then 'DBMS_JOB legacy'
           else 'SCHEDULER'
         end                                                       as job_source
       , j.state                                                   as state
       , j.enabled                                                 as enabled
    from all_scheduler_jobs j
)
select w.job_source                                                as job_source
     , count(*)                                                    as total_cnt
     , count(case when w.state in ('BROKEN', 'FAILED') then 1 end) as problem_cnt
     , count(case when w.state = 'RUNNING'             then 1 end) as running_cnt
     , count(case when w.enabled = 'FALSE'             then 1 end) as disabled_cnt
  from w_jobs w
 group by w.job_source
 order by w.job_source;
