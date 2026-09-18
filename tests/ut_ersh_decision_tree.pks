-- =============================================================================
-- Package: ut_ersh_decision_tree
-- Purpose: utPLSQL suite for ersh_error_handler_api.apex_error_handling — the
--          branches of the decision tree: internal vs. business error,
--          known/unknown/deactivated constraint lookup (ERSH-031), the
--          developer raise_application_error range, and the generic
--          "unexpected ORA" masking fallback.
--
-- Masking itself (ENVIRONMENT / MASK_IN_ENVIRONMENTS matching) has its own
-- suite: ut_ersh_masking. Here each test sets whichever of the two states it
-- needs to make its own assertion deterministic, independent of whatever the
-- schema's real preferences happen to be.
--
-- apex_error.t_error is a plain PL/SQL record — fixtures are built by hand,
-- no live APEX session required. Field names/behavior (extract_constraint_name,
-- get_first_ora_error_text, init_error_result defaults) were confirmed against
-- the real apex_error package (APEX 26.1) before writing these tests, not
-- assumed from documentation.
--
-- @author Angel Flores (Consultant)
-- @created September 18, 2026
-- @ticket ERSH-027
-- =============================================================================
create or replace package ut_ersh_decision_tree
as

  --%suite(ersh_error_handler_api.apex_error_handling: decision tree)
  --%suitepath(ersh.core)

  -- logger.set_pref commits autonomously, and record_internal_incident
  -- (called from inside apex_error_handling) does too — neither is undone by
  -- utPLSQL's automatic per-test rollback.
  --%rollback(manual)

  --%beforeall
  procedure save_original_prefs;

  --%afterall
  procedure restore_original_prefs;

  --%aftereach
  procedure cleanup_test_fixtures;


  --%test(Internal error + common runtime error passes through unmasked)
  procedure internal_common_runtime_passthrough;


  --%test(Internal error + not a common runtime error is masked and recorded)
  procedure internal_unexpected_masked_with_incident;


  --%test(Known constraint violation returns the configured business message)
  procedure known_constraint_business_message;


  --%test(Unknown constraint violation follows the normal masking path)
  procedure unknown_constraint_follows_masking;


  --%test(Deactivated constraint (ERSH-031) behaves like an unknown one)
  procedure deactivated_constraint_as_unknown;


  --%test(Developer raise_application_error in -20999..-20000 bypasses masking)
  procedure dev_range_message_bypasses_masking;


  --%test(Unexpected ORA code outside the dev range is masked and recorded)
  procedure other_ora_masked_with_incident;

end ut_ersh_decision_tree;
/
