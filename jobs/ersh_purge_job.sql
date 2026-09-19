-- =============================================================================
-- ERSH_PURGE_JOB
-- Purpose: scheduled retention for ersh_shield_incidents /
--          ersh_incident_occurrences via ersh_error_handler_api.purge_incidents,
--          using the ERSH_PURGE_AFTER_DAYS preference (default 90 days — kept
--          greater than Logger's own PURGE_AFTER_DAYS of 7, see
--          data/ersh_preferences.sql).
--
-- NOT created during install (release/all_jobs.sql does not reference this
-- file) — run it manually to activate. See docs/OBSERVABILITY.md.
--
-- @author Angel Flores (Consultant)
-- @created September 18, 2026
-- @ticket ERSH-026
-- =============================================================================
declare
  l_count    pls_integer;
  l_job_name user_scheduler_jobs.job_name%type := 'ERSH_PURGE_JOB';
begin

  select count(1)
    into l_count
    from user_scheduler_jobs
   where job_name = l_job_name;

  if l_count = 0 then
    dbms_scheduler.create_job(
        job_name        => l_job_name
      , job_type        => 'PLSQL_BLOCK'
      , job_action      => 'begin ersh_error_handler_api.purge_incidents; end;'
      , start_date      => systimestamp
      , repeat_interval => 'FREQ=DAILY; BYHOUR=2'
      , enabled         => true
      , comments        => 'Purges ersh_shield_incidents/ersh_incident_occurrences using ERSH_PURGE_AFTER_DAYS from logger_prefs.'
    );
  end if;
end;
/
