-- =============================================================================
-- View: ersh_shield_incidents_vw
-- Purpose: Joins ersh_shield_incidents with logger_logs to surface the full
--          error detail alongside the incident summary. Pre-formats the
--          user-facing reference number so APEX reports do not repeat that
--          logic. Adds the derived, UI-facing incident state (open /
--          regression / resolved) so page 100 never has to re-derive it
--          from resolved_yn. Used by the ErrorShield admin application.
--
-- @author Angel Flores (Consultant)
-- @created April 11, 2026
-- @ticket ERSH-001
-- @ticket ERSH-047 (incident_status, last_occurred_on, affected_users,
--         component_label, app_page_display; reference_display renamed to
--         first_reference_display; error_fingerprint, active_yn,
--         workspace_id, created_by, last_updated_by exposed for page 100's
--         Actions > Columns menu)
-- =============================================================================
-- FORCE: this view calls logger.get_pref, which does not exist yet at this
-- point in a fresh release (views are created before packages). Without
-- FORCE, "create view" fails outright and the view never exists at all;
-- with FORCE it's created invalid and the release's final recompile step
-- fixes it once the logger package exists. Same pattern as the vendored
-- views/logger_logs_5_min.sql etc.
create or replace force view ersh_shield_incidents_vw
as
with w_base as (
  select si.shield_incident_id                                      as shield_incident_id
       -- Zero-padded reference matching the format shown to end users.
       -- Must mirror log_and_mask_error's own formula (ERSH preference
       -- REFERENCE_DISPLAY_MIN_DIGITS, not a hardcoded width) or this column
       -- silently drifts from what the user actually sees on screen (ERSH-017).
       -- ERSH-047: aliased as first_reference_display below — post-ERSH-010
       -- this is only the FIRST occurrence of the bucket, never the code any
       -- single affected user actually saw.
       , lpad(
           to_char(si.logger_log_id)
         , greatest(
             to_number(logger.get_pref('REFERENCE_DISPLAY_MIN_DIGITS', 'ERSH'))
           , length(to_char(si.logger_log_id))
           )
         , '0'
         )                                                          as first_reference_display
       , si.logger_log_id                                           as logger_log_id
       -- APEX correlation
       , si.application_id                                          as application_id
       , si.page_id                                                 as page_id
       -- ERSH-047: page 100's merged "App / Page" column. Null application_id
       -- (record_internal_incident called outside an APEX session) yields a
       -- null display rather than a misleading "/ 100".
       , case
           when si.application_id is null then null
           else to_char(si.application_id) || ' / ' || nvl(to_char(si.page_id), '-')
         end                                                        as app_page_display
       , si.app_user                                                as app_user
       , si.request                                                 as request
       , si.component_type                                          as component_type
       -- ERSH-047: component_type without the APEX_APPLICATION_ prefix, in a
       -- legible label. Explicit case, not a blind replace() — the prefix is
       -- stripped but the remainder still needs real English words, and an
       -- unrecognized future component type falls back to a readable label
       -- instead of a blank column.
       , case si.component_type
             when 'APEX_APPLICATION_PAGE_REGIONS'      then 'Page Region'
             when 'APEX_APPLICATION_PAGE_ITEMS'        then 'Page Item'
             when 'APEX_APPLICATION_PAGE_BUTTONS'      then 'Button'
             when 'APEX_APPLICATION_PAGE_VALIDATIONS'  then 'Validation'
             when 'APEX_APPLICATION_PAGE_BRANCHES'     then 'Branch'
             when 'APEX_APPLICATION_PAGE_COMPUTATIONS' then 'Computation'
             when 'APEX_APPLICATION_PAGE_DA_EVENTS'    then 'Dynamic Action'
             when 'APEX_APPLICATION_PAGE_PROCESSES'    then 'Process'
             when 'APEX_APPLICATION_PROCESSES'         then 'Process'
             when 'APEX_APPLICATION_AUTH'              then 'Authentication'
             when 'APEX_APPLICATION_AUTHORIZATION'     then 'Authorization'
             when 'APEX_APPLICATION_LOVS'              then 'List of Values'
             when 'APEX_APPLICATION_DML'               then 'Automatic DML'
             when 'APEX_APPLICATION_WEB_SERVICES'      then 'Web Service'
             when 'APEX_APPLICATION_JOB'               then 'Job'
             else initcap(regexp_replace(si.component_type, '^APEX_APPLICATION_', ''))
           end                                                      as component_label
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
       -- Dedup / correlation
       , si.error_fingerprint                                       as error_fingerprint
       , si.workspace_id                                            as workspace_id
       -- Standard audit columns
       , si.active_yn                                               as active_yn
       , si.created_by                                              as created_by
       , si.created_on                                              as created_on
       , si.last_updated_by                                         as last_updated_by
       , si.last_updated_on                                         as last_updated_on
       -- Full detail from logger_logs (null when logger row has been purged)
       , ll.text                                                    as logger_text
       , ll.call_stack                                              as call_stack
       , ll.extra                                                   as extra
       , ll.time_stamp                                              as logger_time_stamp
    from ersh_shield_incidents si
    left join logger_logs ll on ll.id = si.logger_log_id
   where si.active_yn = 'Y'
), w_occurrences as (
  -- ERSH-047: per-incident hit stats. Filtered first through w_base so this
  -- aggregation only scans occurrences of incidents already in scope
  -- (sql-format.md #12), and respects active_yn same as every other lookup.
  select io.shield_incident_id                                      as shield_incident_id
       , max(io.occurred_on)                                        as last_occurred_on
       , count(distinct io.app_user)                                as affected_users
    from ersh_incident_occurrences io
    join w_base                      b on b.shield_incident_id = io.shield_incident_id
   where io.active_yn = 'Y'
   group by io.shield_incident_id
)
select b.shield_incident_id                                         as shield_incident_id
     , b.first_reference_display                                    as first_reference_display
     , b.logger_log_id                                              as logger_log_id
     , b.application_id                                             as application_id
     , b.page_id                                                    as page_id
     , b.app_page_display                                           as app_page_display
     , b.app_user                                                   as app_user
     , b.request                                                    as request
     , b.component_type                                             as component_type
     , b.component_label                                            as component_label
     , b.component_name                                             as component_name
     , b.ora_sqlcode                                                as ora_sqlcode
     , b.error_summary                                              as error_summary
     , b.occurrence_count                                           as occurrence_count
     , b.resolved_yn                                                as resolved_yn
     , b.resolved_by                                                as resolved_by
     , b.resolved_on                                                as resolved_on
     , b.resolution_notes                                           as resolution_notes
     -- ERSH-047: state derived here, once, so no page ever re-derives it from
     -- resolved_yn. REGRESSION is resolved_yn = 'Y' with a hit that landed
     -- after resolved_on — an incident closed and then hit again. A history
     -- incident with no occurrences rows (pre-ERSH-010) has a null
     -- last_occurred_on, so the "> resolved_on" test is simply unknown and it
     -- falls through to RESOLVED/OPEN on resolved_yn alone, same as before
     -- ERSH-010 ever existed.
     , case
         when b.resolved_yn = 'N' then 'OPEN'
         when b.resolved_yn = 'Y'
         and o.last_occurred_on > b.resolved_on then 'REGRESSION'
         else 'RESOLVED'
       end                                                          as incident_status
     , o.last_occurred_on                                           as last_occurred_on
     , nvl(o.affected_users, 0)                                     as affected_users
     , b.error_fingerprint                                          as error_fingerprint
     , b.workspace_id                                               as workspace_id
     , b.active_yn                                                  as active_yn
     , b.created_by                                                 as created_by
     , b.created_on                                                 as created_on
     , b.last_updated_by                                            as last_updated_by
     , b.last_updated_on                                            as last_updated_on
     , b.logger_text                                                as logger_text
     , b.call_stack                                                 as call_stack
     , b.extra                                                      as extra
     , b.logger_time_stamp                                          as logger_time_stamp
  from w_base        b
  left join w_occurrences o on o.shield_incident_id = b.shield_incident_id;
