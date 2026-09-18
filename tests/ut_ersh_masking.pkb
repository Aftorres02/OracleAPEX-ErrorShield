create or replace package body ut_ersh_masking
as

  gc_pref_type      constant varchar2(30) := 'ERSH';
  gc_message_prefix constant varchar2(30) := 'UT_ERSH_MASKING:';

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
  -- PROCEDURE: cleanup_test_incidents (%aftereach)
  -- ===========================================================================
  procedure cleanup_test_incidents
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

    commit;
  end cleanup_test_incidents;




  -- ===========================================================================
  -- Private helper: fixture for an "other unexpected ORA" error, the branch
  -- that always reaches the masking logic regardless of which scenario is
  -- under test here.
  -- ===========================================================================
  function unexpected_error_fixture(
    p_marker                                 in varchar2
  ) return apex_error.t_error
  is
    l_error apex_error.t_error;
  begin
    l_error.ora_sqlcode       := -1476;
    l_error.ora_sqlerrm       := 'ORA-01476: divisor is equal to zero';
    l_error.message           := gc_message_prefix || ' ' || p_marker || ' - ' || l_error.ora_sqlerrm;
    l_error.is_internal_error := false;
    return l_error;
  end unexpected_error_fixture;




  -- ===========================================================================
  -- TEST: masks_when_environment_listed
  -- ===========================================================================
  procedure masks_when_environment_listed
  is
    l_error  apex_error.t_error := unexpected_error_fixture('listed');
    l_result apex_error.t_error_result;
  begin
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'ENVIRONMENT', p_pref_value => 'UT_MASK_ENV');
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'MASK_IN_ENVIRONMENTS', p_pref_value => 'UT_MASK_ENV');

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    ut.expect(l_result.message).not_to_equal(l_error.message);
    ut.expect(l_result.message).to_be_like('%support@example.com%');
  end masks_when_environment_listed;




  -- ===========================================================================
  -- TEST: no_mask_when_environment_not_listed
  -- ===========================================================================
  procedure no_mask_when_environment_not_listed
  is
    l_error  apex_error.t_error := unexpected_error_fixture('not-listed');
    l_result apex_error.t_error_result;
  begin
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'ENVIRONMENT', p_pref_value => 'UT_MASK_ENV');
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'MASK_IN_ENVIRONMENTS', p_pref_value => 'UT_OTHER_ENV');

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    ut.expect(l_result.message).to_equal(l_error.message);
  end no_mask_when_environment_not_listed;




  -- ===========================================================================
  -- TEST: prod_old_environment_does_not_match_prod
  -- ===========================================================================
  /**
   * Regression guard: matching is comma-wrapped specifically so a substring
   * like 'PROD' inside 'PROD_OLD' can never accidentally match.
   */
  procedure prod_old_environment_does_not_match_prod
  is
    l_error  apex_error.t_error := unexpected_error_fixture('prod-old-env');
    l_result apex_error.t_error_result;
  begin
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'ENVIRONMENT', p_pref_value => 'PROD_OLD');
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'MASK_IN_ENVIRONMENTS', p_pref_value => 'PROD');

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    ut.expect(l_result.message).to_equal(l_error.message);
  end prod_old_environment_does_not_match_prod;




  -- ===========================================================================
  -- TEST: prod_environment_does_not_match_prod_old_list
  -- ===========================================================================
  procedure prod_environment_does_not_match_prod_old_list
  is
    l_error  apex_error.t_error := unexpected_error_fixture('prod-old-list');
    l_result apex_error.t_error_result;
  begin
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'ENVIRONMENT', p_pref_value => 'PROD');
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'MASK_IN_ENVIRONMENTS', p_pref_value => 'PROD_OLD');

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    ut.expect(l_result.message).to_equal(l_error.message);
  end prod_environment_does_not_match_prod_old_list;




  -- ===========================================================================
  -- TEST: pref_read_failure_fails_safe_to_masked
  -- ===========================================================================
  /**
   * Forces the real exception path (not just a null pref): ENVIRONMENT is
   * declared varchar2(30 char) inside log_and_mask_error, so a value over 30
   * characters overflows on assignment (ORA-06502), which the surrounding
   * "exception when others" turns into l_should_mask := true. A merely
   * missing/null pref does NOT exercise this branch — l_should_mask would
   * just evaluate to false — so the oversized value is the only reliable way
   * to reach the actual fail-safe branch from outside the package.
   */
  procedure pref_read_failure_fails_safe_to_masked
  is
    l_error  apex_error.t_error := unexpected_error_fixture('pref-failure');
    l_result apex_error.t_error_result;
  begin
    logger.set_pref(
        p_pref_type  => gc_pref_type
      , p_pref_name  => 'ENVIRONMENT'
      , p_pref_value => 'UT_ENVIRONMENT_VALUE_LONGER_THAN_THIRTY_CHARS'
    );
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'MASK_IN_ENVIRONMENTS', p_pref_value => 'UT_OTHER_ENV');

    l_result := ersh_error_handler_api.apex_error_handling(p_error => l_error);

    ut.expect(l_result.message).not_to_equal(l_error.message);
    ut.expect(l_result.message).to_be_like('%support@example.com%');
  end pref_read_failure_fails_safe_to_masked;


end ut_ersh_masking;
/
