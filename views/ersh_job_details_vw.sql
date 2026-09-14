-- =============================================================================
-- View: ersh_job_details_vw
-- Purpose: Full attribute detail for a single scheduler job. Extracted
--          verbatim from the "Job - Details" region on page 1200, minus
--          the owner/job_name filter (moved to the region's Where Clause
--          — see p01200-job-details.apx, P1200_OWNER / P1200_JOB_NAME).
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_job_details_vw
as
with w_base as (
  select j.owner                                            as owner
       , j.job_name                                         as job_name
       , j.job_subname                                       as job_subname
       , j.state                                            as state
       , j.enabled                                          as enabled
       , j.job_type                                         as job_type
       , j.job_action                                       as job_action
       , j.number_of_arguments                              as number_of_arguments
       , j.program_owner                                    as program_owner
       , j.program_name                                     as program_name
       , j.schedule_owner                                   as schedule_owner
       , j.schedule_name                                    as schedule_name
       , j.schedule_type                                    as schedule_type
       , j.repeat_interval                                  as repeat_interval
       , j.start_date                                       as start_date
       , j.end_date                                         as end_date
       , j.job_class                                        as job_class
       , j.job_priority                                     as job_priority
       , j.restartable                                      as restartable
       , j.auto_drop                                        as auto_drop
       , j.max_runs                                         as max_runs
       , j.max_failures                                     as max_failures
       , j.max_run_duration                                 as max_run_duration
       , j.logging_level                                    as logging_level
       , j.run_count                                        as run_count
       , j.failure_count                                     as failure_count
       , j.retry_count                                      as retry_count
       , j.last_start_date                                  as last_start_date
       , round(
           extract(day    from j.last_run_duration) * 86400
         + extract(hour   from j.last_run_duration) * 3600
         + extract(minute from j.last_run_duration) * 60
         + extract(second from j.last_run_duration)
         , 1)                                               as last_run_secs
       , j.next_run_date                                    as next_run_date
       , j.job_creator                                      as job_creator
       , j.client_id                                        as client_id
       , j.comments                                          as comments
    from all_scheduler_jobs j
)
select owner
     , job_name
     , job_subname
     , state
     , enabled
     , job_type
     , job_action
     , number_of_arguments
     , program_owner
     , program_name
     , schedule_owner
     , schedule_name
     , schedule_type
     , repeat_interval
     , start_date
     , end_date
     , job_class
     , job_priority
     , restartable
     , auto_drop
     , max_runs
     , max_failures
     , max_run_duration
     , logging_level
     , run_count
     , failure_count
     , retry_count
     , last_start_date
     , last_run_secs
     , next_run_date
     , job_creator
     , client_id
     , comments
  from w_base;
