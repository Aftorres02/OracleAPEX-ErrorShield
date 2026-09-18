-- =============================================================================
-- Package: ut_ersh_dedup_occurrences
-- Purpose: utPLSQL suite for ersh_error_handler_api.record_internal_incident.
--          Protects ERSH-010 (a per-user reference code must always resolve
--          back to its incident, even after the parent MERGE deduplicates)
--          and ERSH-013 (workspace_id is part of the dedup fingerprint).
--
-- Calls record_internal_incident directly: it is public and takes only
-- scalars, so these tests do not need an apex_error.t_error fixture.
--
-- Fingerprint/time_bucket are internal to record_internal_incident and are
-- not asserted directly here on purpose — the suite treats the procedure as
-- a black box and only checks the outcome a caller can observe (incident_id,
-- occurrence_count, the occurrences table/view).
--
-- @author Angel Flores (Consultant)
-- @created September 18, 2026
-- @ticket ERSH-027
-- =============================================================================
create or replace package ut_ersh_dedup_occurrences
as

  --%suite(ersh_error_handler_api.record_internal_incident: dedup and occurrences)
  --%suitepath(ersh.core)

  -- record_internal_incident always commits (pragma autonomous_transaction),
  -- so utPLSQL's automatic per-test rollback cannot undo it anyway.
  -- cleanup_test_incidents does the cleanup explicitly instead.
  --%rollback(manual)

  --%aftereach
  procedure cleanup_test_incidents;


  --%test(Two identical hits dedupe into one incident with occurrence_count = 2)
  procedure two_hits_same_bucket_dedupe;


  --%test(Both occurrences keep their own logger_log_id and app_user)
  procedure occurrences_keep_own_identity;


  --%test(Either logger_log_id resolves to the same incident via the occurrences view)
  procedure either_reference_resolves_same;


  --%test(Same error in a different workspace creates a separate incident, ERSH-013)
  procedure different_workspace_new_incident;


  --%test(component_type and component_name are stored on the incident, ERSH-016)
  procedure component_type_and_name_stored;

end ut_ersh_dedup_occurrences;
/
