-- =============================================================================
-- Package: ut_ersh_core_bugs
-- Purpose: utPLSQL suite for the PR 3 core bugs that had no test coverage:
--          raise_custom_error / get_message respecting active_yn (ERSH-022,
--          ERSH-024), and the ora_sqlcode range validation on
--          merge_ersh_error_lookup (ERSH-025).
--
-- None of the units under test here commit internally, so utPLSQL's default
-- automatic per-test rollback is enough — no %rollback(manual), no explicit
-- cleanup needed.
--
-- @author Angel Flores (Consultant)
-- @created September 18, 2026
-- @ticket ERSH-027
-- =============================================================================
create or replace package ut_ersh_core_bugs
as

  --%suite(ersh_error_handler_api: core bugs without prior test coverage)
  --%suitepath(ersh.core)

  --%beforeeach
  procedure seed_active_and_inactive_codes;


  --%test(raise_custom_error raises the configured error for an active code)
  procedure raise_custom_error_active_code;


  --%test(raise_custom_error treats a deactivated code as not implemented, ERSH-022)
  procedure raise_custom_error_inactive_code;


  --%test(raise_custom_error treats an unknown code as not implemented)
  procedure raise_custom_error_unknown_code;


  --%test(get_message returns the message for an active code)
  procedure get_message_active_code;


  --%test(get_message returns null for a deactivated code, ERSH-024)
  procedure get_message_inactive_code_returns_null;


  --%test(get_message returns null for an unknown code)
  procedure get_message_unknown_code_returns_null;


  --%test(merge_ersh_error_lookup rejects an ora_sqlcode outside -20999..-20000, ERSH-025)
  procedure merge_rejects_out_of_range_sqlcode;


  --%test(merge_ersh_error_lookup accepts the boundary values -20999 and -20000)
  procedure merge_accepts_boundary_sqlcodes;

end ut_ersh_core_bugs;
/
