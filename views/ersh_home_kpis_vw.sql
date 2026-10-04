-- =============================================================================
-- View: ersh_home_kpis_vw
-- Purpose: Single-row KPI summary for the Home page (page 1): open/regressed
--          incident counts, occurrences in the last 24h, jobs currently
--          broken or failed, and logger errors in the last 24h. Reuses
--          ersh_shield_incidents_vw's already-derived incident_status
--          (ERSH-047) rather than re-deriving OPEN/REGRESSION here.
--
-- @author Angel Flores (Consultant)
-- @created September 24, 2026
-- @ticket ERSH-048
-- =============================================================================
-- FORCE: depends on ersh_shield_incidents_vw, itself FORCE (views are created
-- before packages on a fresh release, and that view calls logger.get_pref).
-- Same reasoning applies transitively here.
create or replace force view ersh_home_kpis_vw
as
with w_incidents as (
  select count(case when incident_status = 'OPEN'       then 1 end) as open_cnt
       , count(case when incident_status = 'REGRESSION' then 1 end) as regression_cnt
    from ersh_shield_incidents_vw
), w_occurrences as (
  select count(1)                                                   as occurrences_24h_cnt
    from ersh_incident_occurrences
   where active_yn = 'Y'
     and occurred_on > systimestamp - 1
), w_jobs as (
  select broken_or_failed                                           as jobs_failing_cnt
    from ersh_jobs_status_vw
), w_logger as (
  -- 2 = logger.g_error. A package constant can't be read directly from SQL
  -- (PLS-221: only PL/SQL can see it) -- verified live against this repo's
  -- vendored packages/logger.pks, not guessed.
  select count(1)                                                   as logger_errors_24h_cnt
    from logger_logs
   where logger_level = 2
     and time_stamp > systimestamp - 1
)
select i.open_cnt                                                   as open_incidents_cnt
     , i.regression_cnt                                             as regression_incidents_cnt
     , o.occurrences_24h_cnt                                        as occurrences_24h_cnt
     , j.jobs_failing_cnt                                           as jobs_failing_cnt
     , l.logger_errors_24h_cnt                                      as logger_errors_24h_cnt
  from w_incidents  i
 cross join w_occurrences o
 cross join w_jobs        j
 cross join w_logger      l;
