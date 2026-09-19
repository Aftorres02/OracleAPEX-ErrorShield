-- =============================================================================
-- Package: ut_ersh_masking
-- Purpose: utPLSQL suite for the ENVIRONMENT / MASK_IN_ENVIRONMENTS masking
--          logic inside ersh_error_handler_api.log_and_mask_error (private —
--          exercised indirectly through apex_error_handling, using the
--          "unexpected ORA code" branch as a stand-in trigger since masking
--          behavior itself is identical across every branch that reaches it).
--
-- @author Angel Flores (Consultant)
-- @created September 18, 2026
-- @ticket ERSH-027
-- =============================================================================
create or replace package ut_ersh_masking
as

  --%suite(ersh_error_handler_api: ENVIRONMENT / MASK_IN_ENVIRONMENTS masking)
  --%suitepath(ersh.core)

  -- logger.set_pref and record_internal_incident (called indirectly) both
  -- commit autonomously — not undone by utPLSQL's automatic rollback.
  --%rollback(manual)

  --%beforeall
  procedure save_original_prefs;

  --%afterall
  procedure restore_original_prefs;

  --%aftereach
  procedure cleanup_test_incidents;


  --%test(Environment listed in MASK_IN_ENVIRONMENTS masks the message)
  procedure masks_when_environment_listed;


  --%test(Environment not listed in MASK_IN_ENVIRONMENTS leaves the message as-is)
  procedure no_mask_when_environment_not_listed;


  --%test(ENVIRONMENT=PROD_OLD does not match a MASK_IN_ENVIRONMENTS of PROD)
  procedure prod_old_environment_does_not_match_prod;


  --%test(MASK_IN_ENVIRONMENTS=PROD_OLD does not match an ENVIRONMENT of PROD)
  procedure prod_environment_does_not_match_prod_old_list;


  --%test(A failure reading preferences fails safe to masked)
  procedure pref_read_failure_fails_safe_to_masked;

end ut_ersh_masking;
/
