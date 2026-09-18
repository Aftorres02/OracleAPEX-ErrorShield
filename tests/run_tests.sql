-- =============================================================================
-- Compiles and runs the ErrorShield utPLSQL suite with a human-readable
-- console reporter. See CONTRIBUTING.md for prerequisites (utPLSQL
-- installed, ErrorShield installed via release/_release.sql).
--
-- Usage (connected as the owner schema):
--   cd tests
--   sql <connection-as-owner-schema> @run_tests.sql
-- =============================================================================

whenever sqlerror continue

prompt *** Compiling utPLSQL test packages ***
@ut_ersh_dedup_occurrences.pks
@ut_ersh_dedup_occurrences.pkb
@ut_ersh_decision_tree.pks
@ut_ersh_decision_tree.pkb
@ut_ersh_masking.pks
@ut_ersh_masking.pkb
@ut_ersh_core_bugs.pks
@ut_ersh_core_bugs.pkb
@ut_ersh_observability.pks
@ut_ersh_observability.pkb

prompt *** Running ErrorShield utPLSQL suite ***
set serveroutput on
exec ut.run(user);
