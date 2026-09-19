-- =============================================================================
-- Package: ut_ersh_observability
-- Purpose: utPLSQL suite for PR 6 — the SCRUB_FUNCTION hook on
--          record_internal_incident (ERSH-032) and the retention purge,
--          ersh_error_handler_api.purge_incidents (ERSH-026).
--
-- @author Angel Flores (Consultant)
-- @created September 18, 2026
-- @ticket ERSH-027
-- =============================================================================
create or replace package ut_ersh_observability
as

  --%suite(ersh_error_handler_api: scrubbing and retention)
  --%suitepath(ersh.core)

  -- logger.set_pref, record_internal_incident and purge_incidents all
  -- commit autonomously — not undone by utPLSQL's automatic rollback.
  --%rollback(manual)

  --%beforeall
  procedure create_fixture_scrub_function;

  --%afterall
  procedure drop_fixture_scrub_function;

  --%aftereach
  procedure cleanup_test_fixtures;


  --%test(error_summary keeps the raw message when SCRUB_FUNCTION is unset)
  procedure scrub_inert_by_default;


  --%test(error_summary is scrubbed when SCRUB_FUNCTION is configured)
  procedure scrub_applies_when_configured;


  --%test(scrubbing never changes the dedup fingerprint)
  procedure scrub_does_not_affect_dedup;


  --%test(a missing/broken scrub function falls back to the raw message)
  procedure scrub_falls_back_when_function_broken;


  --%test(purge_incidents deletes incidents older than the retention window)
  procedure purge_deletes_old_incidents;


  --%test(purge_incidents deletes the old incident's occurrences too)
  procedure purge_deletes_old_occurrences;


  --%test(purge_incidents keeps incidents inside the retention window)
  procedure purge_keeps_recent_incidents;

end ut_ersh_observability;
/
