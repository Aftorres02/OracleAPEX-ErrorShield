create or replace package ersh_demo_data_api is
-- =============================================================================
-- Package: ersh_demo_data_api
-- Purpose: Generates bulk, clearly-fake demo data (logger_logs, incidents,
--          occurrences, and Oracle Scheduler job activity) so the admin app's
--          reports and job dashboards look populated for a community demo
--          instead of empty. Demo-only — never referenced by release/_release.sql
--          or any *_api package that is part of the real product surface.
--
-- Every generated logger_logs row is tagged with client_identifier =
-- 'ERRORSHIELD_DEMO_DATA' so purge_demo_data can remove exactly what this
-- package created, and nothing else, from a schema that may also have real
-- data in it.
--
-- @ticket ERSH-046
-- =============================================================================


  /**
   * Inserts p_log_count logger_logs rows with random level/module/action/text,
   * timestamped randomly over the last p_days_back days. Not linked to any
   * incident — this is background "noise" so the Logger Logs report (page
   * 400) looks like a busy real system.
   */
  procedure generate_background_logs(
      p_log_count                                     in pls_integer default 3000
    , p_days_back                                     in pls_integer default 30
  );


  /**
   * Generates p_incident_count rows in ersh_shield_incidents, each with 1 to
   * p_max_occurrences rows in ersh_incident_occurrences (and one backing
   * logger_logs row per occurrence, including the incident's own "first hit").
   * Populates the Incidents list (page 100) and Review Incident (page 110).
   */
  procedure generate_incidents(
      p_incident_count                                in pls_integer default 300
    , p_days_back                                     in pls_integer default 30
    , p_max_occurrences                               in pls_integer default 6
  );


  /**
   * Creates (idempotently) three demo-only DBMS_SCHEDULER jobs — one that
   * always succeeds, one that always fails, one that repeats every 20
   * minutes — and runs the succeed/fail ones several times synchronously so
   * ALL_SCHEDULER_JOB_RUN_DETAILS accumulates real run history. This is what
   * populates the Jobs dashboard (page 1000) and Inventory/Executions pages
   * (1100/1200/1300) — those read Oracle's scheduler dictionary views
   * directly, which cannot be populated with plain INSERT statements.
   */
  procedure generate_scheduler_jobs(
      p_failure_run_count                             in pls_integer default 4
    , p_success_run_count                             in pls_integer default 6
  );


  /**
   * Creates (if missing) and kicks off, in the background, a demo job that
   * just sleeps for p_sleep_seconds. Call this right before showing the
   * "Running now" dashboard (page 1400) so it has something to show — that
   * page only has rows while a job is actually executing, so this can't be
   * baked into generate_scheduler_jobs's synchronous run history.
   */
  procedure run_slow_demo_job(
      p_sleep_seconds                                 in pls_integer default 45
  );


  /**
   * Convenience wrapper: optionally purges existing demo data, then calls
   * generate_background_logs, generate_incidents, and generate_scheduler_jobs
   * with the given (or default) volumes. This is the one call a fresh demo
   * schema needs after installing ErrorShield itself.
   */
  procedure generate_all_demo_data(
      p_reset_first_yn                                in varchar2 default 'Y'
    , p_log_count                                     in pls_integer default 3000
    , p_incident_count                                in pls_integer default 300
    , p_days_back                                     in pls_integer default 30
    , p_max_occurrences                               in pls_integer default 6
  );


  /**
   * Removes every row this package generated (matched by client_identifier =
   * 'ERRORSHIELD_DEMO_DATA', in FK-safe order) and drops every demo
   * scheduler job (job_name like 'ERSH_DEMO_%'). Never touches real data —
   * only rows/jobs this package's own naming convention produced.
   */
  procedure purge_demo_data;


end ersh_demo_data_api;
/
