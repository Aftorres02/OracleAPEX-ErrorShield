-- =============================================================================
-- View: ersh_jobs_next_runs_vw
-- Purpose: Jobs scheduled to run within the next 60 minutes. Extracted
--          verbatim from the "Next runs - 60 min" region on page 1000
--          (Jobs - Dashboard).
--
-- Note: next_run_date is exposed in addition to the original column list
--       (next_run_at) purely so this view's own ORDER BY has a raw,
--       unformatted sort key instead of the display-formatted string.
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_jobs_next_runs_vw
as
with w_base as (
  select j.owner                             as owner
       , j.job_name                          as job_name
       , to_char(j.next_run_date, 'HH24:MI') as next_run_at
       , j.next_run_date                     as next_run_date
       , j.schedule_type                     as schedule_type
       , j.repeat_interval                   as repeat_interval
    from all_scheduler_jobs j
   where j.enabled       = 'TRUE'
     and j.next_run_date is not null
     and j.next_run_date <= systimestamp + interval '60' minute
)
select owner
     , job_name
     , next_run_at
     , next_run_date
     , schedule_type
     , repeat_interval
  from w_base
 order by next_run_date;
