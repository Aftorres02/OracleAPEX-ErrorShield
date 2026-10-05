create or replace package elab_errors_api
as
-- =============================================================================
-- Package: elab_errors_api
-- Purpose: Error Lab demo (app 10402). Every unit here fails ON PURPOSE with
--          one specific, realistic ORA error, so a consumer app wired to
--          ersh_error_handler_api.apex_error_handling can show exactly how
--          ErrorShield treats each kind of failure.
--
--          APEX-unaware by design (error-handling.md): every unit can be run
--          from SQLcl to see the raw error, and the APEX layer is the only
--          place the error is translated for the end user.
--
--          Lives in the CONSUMER schema. Reaches ErrorShield and Logger only
--          through the synonyms created by
--          scripts/consumer/create_ersh_synonyms.sql and
--          scripts/consumer/create_logger_synonyms.sql.
--
-- @author  Angel Flores (Consultant)
-- @created October 03, 2026
-- @ticket  ERSH-049
-- =============================================================================


  -- ===========================================================================
  -- PL/SQL runtime errors
  -- ===========================================================================

  procedure force_division_by_zero;


  procedure force_value_error;


  procedure force_invalid_number;


  procedure force_invalid_date;


  procedure force_no_data_found;


  procedure force_too_many_rows;


  -- ===========================================================================
  -- Table / column errors
  -- ===========================================================================

  procedure force_value_too_large;


  procedure force_numeric_overflow;


  procedure force_not_null;


  procedure force_unique_violation;


  procedure force_check_violation;


  procedure force_parent_not_found;


  procedure force_child_found;


  -- ===========================================================================
  -- Business rule
  -- ===========================================================================

  procedure force_business_error;


  -- ===========================================================================
  -- Dispatcher (used by the AJAX scenarios)
  -- ===========================================================================

  procedure force_error(
      p_scenario                                in varchar2
  );


end elab_errors_api;
/
