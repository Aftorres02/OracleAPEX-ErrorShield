-- =============================================================================
-- View: ersh_shield_incidents_vw
-- Purpose: Joins ersh_shield_incidents with logger_logs to surface the full
--          error detail alongside the incident summary. Pre-formats the
--          user-facing reference number so APEX reports do not repeat that
--          logic. Used by the ErrorShield admin application.
--
-- @author Angel Flores (Consultant)
-- @created April 11, 2026
-- @ticket ERSH-001
-- =============================================================================
create or replace view ersh_shield_incidents_vw
as
with w_base as (
  select si.shield_incident_id                                      as shield_incident_id
       -- Zero-padded reference matching the format shown to end users
       , lpad(to_char(si.logger_log_id), 10, '0')                  as reference_display
       , si.logger_log_id                                           as logger_log_id
       -- APEX correlation
       , si.application_id                                          as application_id
       , si.page_id                                                 as page_id
       , si.app_user                                                as app_user
       , si.request                                                 as request
       , si.component_type                                          as component_type
       , si.component_name                                          as component_name
       -- Error detail
       , si.ora_sqlcode                                             as ora_sqlcode
       , si.error_summary                                           as error_summary
       -- Dedup stats (created_on = first occurrence; last_updated_on = most recent hit)
       , si.occurrence_count                                        as occurrence_count
       -- Resolution
       , si.resolved_yn                                             as resolved_yn
       , si.resolved_by                                             as resolved_by
       , si.resolved_on                                             as resolved_on
       , si.resolution_notes                                        as resolution_notes
       -- Timestamps
       , si.created_on                                              as created_on
       , si.last_updated_on                                         as last_updated_on
       -- Full detail from logger_logs (null when logger row has been purged)
       , ll.text                                                    as logger_text
       , ll.call_stack                                              as call_stack
       , ll.extra                                                   as extra
       , ll.time_stamp                                              as logger_time_stamp
    from ersh_shield_incidents si
    left join logger_logs ll on ll.id = si.logger_log_id
   where si.active_yn = 'Y'
)
select shield_incident_id
     , reference_display
     , logger_log_id
     , application_id
     , page_id
     , app_user
     , request
     , component_type
     , component_name
     , ora_sqlcode
     , error_summary
     , occurrence_count
     , resolved_yn
     , resolved_by
     , resolved_on
     , resolution_notes
     , created_on
     , last_updated_on
     , logger_text
     , call_stack
     , extra
     , logger_time_stamp
  from w_base;
