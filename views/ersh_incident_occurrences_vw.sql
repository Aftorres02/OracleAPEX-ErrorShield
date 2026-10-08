-- =============================================================================
-- View: ersh_incident_occurrences_vw
-- Purpose: One row per individual error occurrence, joined back to its parent
--          ersh_shield_incidents row. Pre-formats reference_display using the
--          same REFERENCE_DISPLAY_MIN_DIGITS preference as
--          ersh_shield_incidents_vw, so a code the DEV main pastes from the
--          support flow always matches what the affected user saw on screen.
--          Used by the ErrorShield admin application (page 100 support
--          lookup, page 110 occurrences region and page 410 incident
--          occurrences region).
--
-- @author Angel Flores (Consultant)
-- @created September 16, 2026
-- @ticket ERSH-010
-- @ticket ERSH-051 (client_identifier and log_status from logger_logs, so
--         a page can tell whether each reference still has a log to open)
-- =============================================================================
-- FORCE: this view calls logger.get_pref, which does not exist yet at this
-- point in a fresh release (views are created before packages). Without
-- FORCE, "create view" fails outright and the view never exists at all;
-- with FORCE it's created invalid and the release's final recompile step
-- fixes it once the logger package exists. Same pattern as the vendored
-- views/logger_logs_5_min.sql etc.
create or replace force view ersh_incident_occurrences_vw
as
with w_base as (
  select io.occurrence_id                                             as occurrence_id
       , io.shield_incident_id                                        as shield_incident_id
       , io.logger_log_id                                             as logger_log_id
       -- Zero-padded reference matching the format shown to end users. Null
       -- when logger.log_error failed for this hit (io.logger_log_id is null).
       , lpad(
           to_char(io.logger_log_id)
         , greatest(
             to_number(logger.get_pref('REFERENCE_DISPLAY_MIN_DIGITS', 'ERSH'))
           , length(to_char(io.logger_log_id))
           )
         , '0'
         )                                                            as reference_display
       , io.app_user                                                  as app_user
       , io.occurred_on                                               as occurred_on
       -- Parent incident data (root cause + resolution state)
       , si.error_fingerprint                                         as error_fingerprint
       , si.application_id                                            as application_id
       , si.page_id                                                   as page_id
       , si.component_type                                            as component_type
       , si.component_name                                            as component_name
       , si.ora_sqlcode                                               as ora_sqlcode
       , si.error_summary                                             as error_summary
       , si.occurrence_count                                          as occurrence_count
       , si.resolved_yn                                                as resolved_yn
       , si.resolved_by                                                as resolved_by
       , si.resolved_on                                                as resolved_on
       , si.resolution_notes                                           as resolution_notes
       -- ERSH-051: logger_logs side of this hit. logger_logs is vendored and
       -- purged by its own job (no FK can exist), so the row may be gone
       -- while the occurrence lives on. 'Purged' warns that the reference
       -- has no log left to open (Logger's default PURGE_MIN_LEVEL keeps
       -- ERROR rows, so this needs a non-default purge); 'Not logged' is a
       -- hit where logger.log_error itself failed and no reference code was
       -- issued.
       , ll.client_identifier                                          as client_identifier
       , case
           when io.logger_log_id is null then 'Not logged'
           when ll.id is null            then 'Purged'
           else                               'Logged'
         end                                                           as log_status
    from ersh_incident_occurrences io
    join ersh_shield_incidents     si on si.shield_incident_id = io.shield_incident_id
    left join logger_logs          ll on ll.id = io.logger_log_id
   where io.active_yn = 'Y'
     and si.active_yn = 'Y'
)
select occurrence_id
     , shield_incident_id
     , logger_log_id
     , reference_display
     , app_user
     , occurred_on
     , error_fingerprint
     , application_id
     , page_id
     , component_type
     , component_name
     , ora_sqlcode
     , error_summary
     , occurrence_count
     , resolved_yn
     , resolved_by
     , resolved_on
     , resolution_notes
     , client_identifier
     , log_status
  from w_base;
