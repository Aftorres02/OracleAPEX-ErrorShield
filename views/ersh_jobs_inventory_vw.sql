-- =============================================================================
-- View: ersh_jobs_inventory_vw
-- Purpose: Full scheduler job inventory (all_scheduler_jobs) with derived
--          job source, one-shot flag, and APEX client user. Extracted
--          verbatim from the " Inventory" region on page 1100.
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_jobs_inventory_vw
as
with w_base as (
  select j.owner                                            as owner
       , j.job_name                                         as job_name
       , j.job_subname                                       as job_subname
       , case
           when j.job_name like 'DBMS\_JOB$\_%' escape '\' then 'DBMS_JOB legacy'
           else 'SCHEDULER'
         end                                                as job_source
       , j.state                                            as state
       , j.enabled                                          as enabled
       , j.job_type                                         as job_type
       , j.job_class                                         as job_class
       , j.schedule_type                                    as schedule_type
       , j.repeat_interval                                  as repeat_interval
       , j.program_name                                     as program_name
       , j.schedule_name                                    as schedule_name
       , j.start_date                                       as start_date
       , j.last_start_date                                  as last_start_date
       , round(
           extract(day    from j.last_run_duration) * 86400
         + extract(hour   from j.last_run_duration) * 3600
         + extract(minute from j.last_run_duration) * 60
         + extract(second from j.last_run_duration)
         , 1)                                               as last_run_secs
       , j.next_run_date                                    as next_run_date
       , j.run_count                                        as run_count
       , j.failure_count                                     as failure_count
       , j.retry_count                                      as retry_count
       , j.max_runs                                         as max_runs
       , j.auto_drop                                        as auto_drop
       , case
           when j.auto_drop       = 'TRUE'
            and j.repeat_interval is null
            and j.schedule_name   is null then 'Y'
           else 'N'
         end                                                as one_shot_yn
       , j.job_creator                                      as job_creator
       , j.client_id                                        as client_id
       , regexp_substr(j.client_id, '^[^:]*')               as apex_user
       , substr(j.job_action, 1, 200)                       as job_action_head
       , j.comments                                         as comments
    from all_scheduler_jobs j
)
select owner
     , job_name
     , job_subname
     , job_source
     , state
     , enabled
     , job_type
     , job_class
     , schedule_type
     , repeat_interval
     , program_name
     , schedule_name
     , start_date
     , last_start_date
     , last_run_secs
     , next_run_date
     , run_count
     , failure_count
     , retry_count
     , max_runs
     , auto_drop
     , one_shot_yn
     , job_creator
     , client_id
     , apex_user
     , job_action_head
     , comments
  from w_base
 order by case
            when state in ('BROKEN', 'FAILED') then 0
            when state = 'RUNNING'             then 1
            else 2
          end
        , next_run_date nulls last
        , job_name;
