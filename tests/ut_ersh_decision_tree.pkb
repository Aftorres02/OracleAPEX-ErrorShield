create or replace package body ut_ersh_decision_tree
as

  gc_pref_type      constant varchar2(30) := 'ERSH';
  gc_message_prefix constant varchar2(30) := 'UT_ERSH_DECISION_TREE:';

  gc_known_constraint       constant varchar2(60) := 'UT_ERSH_DT_KNOWN_CONSTRAINT';
  gc_unknown_constraint     constant varchar2(60) := 'UT_ERSH_DT_UNKNOWN_CONSTRAINT';
  gc_deactivated_constraint constant varchar2(60) := 'UT_ERSH_DT_DEACTIVATED_CONSTRAINT';
  gc_known_business_message constant varchar2(200) := 'UT test: please provide a valid quantity.';

  g_orig_environment logger_prefs.pref_value%type;
  g_orig_mask_list   logger_prefs.pref_value%type;




  -- ===========================================================================
  -- PROCEDURE: save_original_prefs (%beforeall)
  -- ===========================================================================
  procedure save_original_prefs
  is
  begin
    g_orig_environment := logger.get_pref('ENVIRONMENT', gc_pref_type);
    g_orig_mask_list    := logger.get_pref('MASK_IN_ENVIRONMENTS', gc_pref_type);
  end save_original_prefs;




  -- ===========================================================================
  -- PROCEDURE: restore_original_prefs (%afterall)
  -- ===========================================================================
  procedure restore_original_prefs
  is
  begin
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'ENVIRONMENT', p_pref_value => g_orig_environment);
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'MASK_IN_ENVIRONMENTS', p_pref_value => g_orig_mask_list);
  end restore_original_prefs;




  -- ===========================================================================
  -- PROCEDURE: cleanup_test_fixtures (%aftereach)
  -- ===========================================================================
  procedure cleanup_test_fixtures
  is
  begin
    delete
      from ersh_incident_occurrences
     where shield_incident_id in (
             select shield_incident_id
               from ersh_shield_incidents
              where error_summary like gc_message_prefix || '%'
           );

    delete
      from ersh_shield_incidents
     where error_summary like gc_message_prefix || '%';

    ersh_error_handler_api.delete_ersh_constraint_lookup(p_constraint_name => gc_known_constraint);
    ersh_error_handler_api.delete_ersh_constraint_lookup(p_constraint_name => gc_deactivated_constraint);

    commit;
  end cleanup_test_fixtures;




  -- ===========================================================================
  -- Private helper: unmask() / mask() — deterministic pref state per test.
  -- ===========================================================================
  procedure unmask
  is
  begin
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'ENVIRONMENT', p_pref_value => 'UT_DECISION_TREE_ENV');
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'MASK_IN_ENVIRONMENTS', p_pref_value => 'UT_SOME_OTHER_ENV');
  end unmask;


  procedure mask
  is
  begin
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'ENVIRONMENT', p_pref_value => 'UT_DECISION_TREE_ENV');
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'MASK_IN_ENVIRONMENTS', p_pref_value => 'UT_DECISION_TREE_ENV');
  end mask;




  -- ===========================================================================
  -- TEST: internal_common_runtime_passthrough
  -- ===========================================================================
  procedure internal_common_runtime_passthrough
  is
    l_error  apex_error.t_error;
    l_result apex_error.t_error_result;
  begin
    unmask;

    l_error.message                 := gc_message_prefix || ' internal common runtime error';
    l_error.additional_info         := 'UT test additional info';
    l_error.is_internal_error       := true;
    l_error.is_common_runtime_error := true;

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    ut.expect(l_result.message).to_equal(l_error.message);
    ut.expect(l_result.additional_info).to_equal(l_error.additional_info);
  end internal_common_runtime_passthrough;




  -- ===========================================================================
  -- TEST: internal_unexpected_masked_with_incident
  -- ===========================================================================
  procedure internal_unexpected_masked_with_incident
  is
    l_error          apex_error.t_error;
    l_result         apex_error.t_error_result;
    l_incident_count pls_integer;
  begin
    mask;

    l_error.message                 := gc_message_prefix || ' internal unexpected error';
    l_error.is_internal_error       := true;
    l_error.is_common_runtime_error := false;

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    ut.expect(l_result.message).not_to_equal(l_error.message);
    ut.expect(l_result.message).to_be_like('%support@example.com%');
    ut.expect(l_result.additional_info).to_be_null;

    select count(1)
      into l_incident_count
      from ersh_shield_incidents
     where error_summary = l_error.message;

    ut.expect(l_incident_count).to_equal(1);
  end internal_unexpected_masked_with_incident;




  -- ===========================================================================
  -- TEST: known_constraint_business_message
  -- ===========================================================================
  /**
   * Once the constraint lookup overrides l_result.message, it no longer
   * equals p_error.message, so the masking check downstream is skipped
   * entirely — the business message wins regardless of environment. Left
   * unmasked here anyway, for a suite-wide deterministic baseline.
   */
  procedure known_constraint_business_message
  is
    l_error  apex_error.t_error;
    l_result apex_error.t_error_result;
  begin
    unmask;

    ersh_error_handler_api.merge_ersh_constraint_lookup(
        p_constraint_name    => gc_known_constraint
      , p_constraint_message => gc_known_business_message
    );

    l_error.ora_sqlcode       := -2290;
    l_error.ora_sqlerrm       := 'ORA-02290: check constraint (LOGGER_USER.' || gc_known_constraint || ') violated';
    l_error.message           := gc_message_prefix || ' known constraint - ' || l_error.ora_sqlerrm;
    l_error.is_internal_error := false;

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    ut.expect(l_result.message).to_equal(gc_known_business_message);
  end known_constraint_business_message;




  -- ===========================================================================
  -- TEST: unknown_constraint_follows_masking
  -- ===========================================================================
  procedure unknown_constraint_follows_masking
  is
    l_error          apex_error.t_error;
    l_result         apex_error.t_error_result;
    l_incident_count pls_integer;
  begin
    unmask;

    l_error.ora_sqlcode       := -2290;
    l_error.ora_sqlerrm       := 'ORA-02290: check constraint (LOGGER_USER.' || gc_unknown_constraint || ') violated';
    l_error.message           := gc_message_prefix || ' unknown constraint - ' || l_error.ora_sqlerrm;
    l_error.is_internal_error := false;

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    -- Not in ersh_constraint_lookup, and unmasked: falls through to the raw
    -- ORA message, unchanged.
    ut.expect(l_result.message).to_equal(l_error.message);

    select count(1)
      into l_incident_count
      from ersh_shield_incidents
     where error_summary = l_error.message;

    ut.expect(l_incident_count).to_equal(1);
  end unknown_constraint_follows_masking;




  -- ===========================================================================
  -- TEST: deactivated_constraint_as_unknown (ERSH-031)
  -- ===========================================================================
  procedure deactivated_constraint_as_unknown
  is
    l_error  apex_error.t_error;
    l_result apex_error.t_error_result;
  begin
    unmask;

    ersh_error_handler_api.merge_ersh_constraint_lookup(
        p_constraint_name    => gc_deactivated_constraint
      , p_constraint_message => 'UT test: this message must never be shown.'
      , p_active_yn          => 'N'
    );

    l_error.ora_sqlcode       := -2290;
    l_error.ora_sqlerrm       := 'ORA-02290: check constraint (LOGGER_USER.' || gc_deactivated_constraint || ') violated';
    l_error.message           := gc_message_prefix || ' deactivated constraint - ' || l_error.ora_sqlerrm;
    l_error.is_internal_error := false;

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    -- active_yn = 'N' must behave exactly like "not in the lookup at all" —
    -- never a distinct "disabled" message (see CLAUDE.md error-handling rules).
    ut.expect(l_result.message).to_equal(l_error.message);
  end deactivated_constraint_as_unknown;




  -- ===========================================================================
  -- TEST: dev_range_message_bypasses_masking
  -- ===========================================================================
  procedure dev_range_message_bypasses_masking
  is
    l_error  apex_error.t_error;
    l_result apex_error.t_error_result;
  begin
    -- Masked on purpose: the dev range must bypass masking entirely, so this
    -- proves it is not just "happened to be unmasked".
    mask;

    l_error.ora_sqlcode       := -20001;
    l_error.ora_sqlerrm       := 'ORA-20001: UT test dev-intentional business error.';
    l_error.message           := l_error.ora_sqlerrm;
    l_error.is_internal_error := false;

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    ut.expect(l_result.message).to_equal('UT test dev-intentional business error.');
  end dev_range_message_bypasses_masking;




  -- ===========================================================================
  -- TEST: other_ora_masked_with_incident
  -- ===========================================================================
  procedure other_ora_masked_with_incident
  is
    l_error          apex_error.t_error;
    l_result         apex_error.t_error_result;
    l_incident_count pls_integer;
  begin
    mask;

    l_error.ora_sqlcode       := -1476;
    l_error.ora_sqlerrm       := 'ORA-01476: divisor is equal to zero';
    l_error.message           := gc_message_prefix || ' other ora - ' || l_error.ora_sqlerrm;
    l_error.is_internal_error := false;

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    ut.expect(l_result.message).not_to_equal(l_error.message);
    ut.expect(l_result.message).to_be_like('%support@example.com%');

    select count(1)
      into l_incident_count
      from ersh_shield_incidents
     where error_summary = l_error.message;

    ut.expect(l_incident_count).to_equal(1);
  end other_ora_masked_with_incident;


end ut_ersh_decision_tree;
/
