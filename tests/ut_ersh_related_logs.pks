-- =============================================================================
-- Package: ut_ersh_related_logs
-- Purpose: utPLSQL suite for the reference code -> Logger navigation used by
--          the admin app's page 410 (ERSH-051):
--            - ersh_related_logs_vw: the "same request" trail around a
--              logger_logs row (same client_identifier, same sid, 2 minutes
--              before through 5 seconds after).
--            - ersh_incident_occurrences_vw.log_status: whether each
--              reference code still has a logger_logs row to open.
--
-- Fixture logger_logs rows use a fixed time in the year 2000 and negative
-- sids, so no real log can ever fall inside a test's trail window.
--
-- @author Angel Flores (Consultant)
-- @created October 5, 2026
-- @ticket ERSH-051
-- =============================================================================
create or replace package ut_ersh_related_logs
as

  --%suite(ersh_related_logs_vw and ersh_incident_occurrences_vw: reference code to Logger trail)
  --%suitepath(ersh.core)

  -- record_internal_incident commits (pragma autonomous_transaction), so
  -- utPLSQL's automatic per-test rollback cannot undo it anyway.
  -- cleanup_test_fixtures does the cleanup explicitly instead.
  --%rollback(manual)

  --%aftereach
  procedure cleanup_test_fixtures;


  --%test(Trail includes the rows the same request wrote before the anchor)
  procedure trail_includes_same_request;


  --%test(Trail excludes rows from another APEX session on the same sid)
  procedure trail_excludes_other_apex_session;


  --%test(Trail excludes rows from another database session)
  procedure trail_excludes_other_db_session;


  --%test(Trail excludes rows outside the 2 minutes before / 5 seconds after window)
  procedure trail_excludes_outside_window;


  --%test(Trail matches by sid alone when the anchor has no client_identifier)
  procedure trail_matches_by_sid_without_client;


  --%test(Occurrences report Logged, Purged and Not logged per reference code)
  procedure occurrences_report_log_status;

end ut_ersh_related_logs;
/
