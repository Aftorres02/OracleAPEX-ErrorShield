-- =============================================================================
-- View: ersh_apex_automations_vw
-- Purpose: APEX Automations metadata (apex_appl_automations) across all
--          applications. Extracted verbatim from the "Automations" region
--          on page 1600 (APEX Automations).
--
-- Note: apex_appl_automations is an APEX dictionary view (not ALL_*), same
--       as the source already used by this region — no new grants needed,
--       consistent with the "no DBA_*, no new grants" rule this extraction
--       otherwise follows for the ALL_SCHEDULER_* based views.
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_apex_automations_vw
as
with w_base as (
  select a.application_id                                            as application_id
       , a.application_name                                          as application_name
       , a.name                                                      as automation_name
       , a.static_id                                                 as static_id
       , a.trigger_type                                              as trigger_type
       , a.polling_interval                                          as polling_interval
       , a.polling_status                                            as polling_status
       , a.polling_last_run_timestamp                                as last_run_on
       , a.polling_next_run_timestamp                                as next_run_on
       , a.result_type                                               as result_type
       , a.query_type                                                as query_type
       , a.table_owner                                               as table_owner
       , a.table_name                                                as table_name
       , a.max_rows_to_process                                       as max_rows_to_process
       , a.error_handling_type                                       as error_handling_type
       , a.build_option                                              as build_option
       , a.component_comment                                         as component_comment
       , a.last_updated_on                                           as last_updated_on
    from apex_appl_automations a
)
select application_id
     , application_name
     , automation_name
     , static_id
     , trigger_type
     , polling_interval
     , polling_status
     , last_run_on
     , next_run_on
     , result_type
     , query_type
     , table_owner
     , table_name
     , max_rows_to_process
     , error_handling_type
     , build_option
     , component_comment
     , last_updated_on
  from w_base
 order by application_id
        , automation_name;
