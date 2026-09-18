create or replace package body ut_ersh_dedup_occurrences
as

  -- Reserved application_id sentinels for this suite. record_internal_incident
  -- commits via pragma autonomous_transaction, so utPLSQL's automatic
  -- per-test rollback never sees these rows — %aftereach deletes them by
  -- range instead.
  gc_app_dedupe    constant number := 999101;
  gc_app_identity  constant number := 999102;
  gc_app_resolve   constant number := 999103;
  gc_app_workspace constant number := 999104;
  gc_app_component constant number := 999105;

  gc_range_lo      constant number := 999100;
  gc_range_hi      constant number := 999199;




  -- ===========================================================================
  -- PROCEDURE: cleanup_test_incidents (%aftereach)
  -- ===========================================================================
  /**
   * Deletes every incident/occurrence row this suite may have created, by
   * the reserved application_id range above. Not scoped to the test that
   * just ran: a failed assertion mid-test can leave rows behind from an
   * earlier attempt, so every run clears the whole range.
   */
  procedure cleanup_test_incidents
  is
  begin
    delete
      from ersh_incident_occurrences
     where shield_incident_id in (
             select shield_incident_id
               from ersh_shield_incidents
              where application_id between gc_range_lo and gc_range_hi
           );

    delete
      from ersh_shield_incidents
     where application_id between gc_range_lo and gc_range_hi;

    commit;
  end cleanup_test_incidents;




  -- ===========================================================================
  -- TEST: two_hits_same_bucket_dedupe
  -- ===========================================================================
  /**
   * Note on flakiness: time_bucket is floor(epoch_seconds / 30), computed
   * inside record_internal_incident from the current time. Two calls made
   * milliseconds apart land in the same bucket except in the astronomically
   * rare case where they straddle a bucket boundary. Not worth mocking the
   * clock to remove — accepted as a known, near-zero flake risk.
   */
  procedure two_hits_same_bucket_dedupe
  is
    l_incident_id_1     ersh_shield_incidents.shield_incident_id%type;
    l_incident_id_2     ersh_shield_incidents.shield_incident_id%type;
    l_occurrence_count  ersh_shield_incidents.occurrence_count%type;
  begin
    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_dedupe
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_ONE'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_dedup_occurrences: divisor is equal to zero'
      , p_logger_log_id    => gc_app_dedupe * 1000 + 1
      , o_incident_id      => l_incident_id_1
    );

    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_dedupe
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_TWO'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_dedup_occurrences: divisor is equal to zero'
      , p_logger_log_id    => gc_app_dedupe * 1000 + 2
      , o_incident_id      => l_incident_id_2
    );

    ut.expect(l_incident_id_2).to_equal(l_incident_id_1);

    select occurrence_count
      into l_occurrence_count
      from ersh_shield_incidents
     where shield_incident_id = l_incident_id_1;

    ut.expect(l_occurrence_count).to_equal(2);
  end two_hits_same_bucket_dedupe;




  -- ===========================================================================
  -- TEST: occurrences_keep_own_identity
  -- ===========================================================================
  procedure occurrences_keep_own_identity
  is
    l_incident_id_1  ersh_shield_incidents.shield_incident_id%type;
    l_incident_id_2  ersh_shield_incidents.shield_incident_id%type;
    l_occurrence_cnt pls_integer;
    l_app_user_one   ersh_incident_occurrences.app_user%type;
    l_app_user_two   ersh_incident_occurrences.app_user%type;
  begin
    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_identity
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_ONE'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_dedup_occurrences: divisor is equal to zero'
      , p_logger_log_id    => gc_app_identity * 1000 + 1
      , o_incident_id      => l_incident_id_1
    );

    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_identity
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_TWO'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_dedup_occurrences: divisor is equal to zero'
      , p_logger_log_id    => gc_app_identity * 1000 + 2
      , o_incident_id      => l_incident_id_2
    );

    select count(1)
      into l_occurrence_cnt
      from ersh_incident_occurrences
     where shield_incident_id = l_incident_id_1;

    ut.expect(l_occurrence_cnt).to_equal(2);

    select app_user
      into l_app_user_one
      from ersh_incident_occurrences
     where logger_log_id = gc_app_identity * 1000 + 1;

    select app_user
      into l_app_user_two
      from ersh_incident_occurrences
     where logger_log_id = gc_app_identity * 1000 + 2;

    ut.expect(l_app_user_one).to_equal('UT_USER_ONE');
    ut.expect(l_app_user_two).to_equal('UT_USER_TWO');
  end occurrences_keep_own_identity;




  -- ===========================================================================
  -- TEST: either_reference_resolves_same
  -- ===========================================================================
  /**
   * This is the test that protects ERSH-010: before the fix, the parent
   * MERGE kept only the first hit's logger_log_id, so the second user's
   * reference code was orphaned — it existed in logger_logs but resolved to
   * nothing. Both codes must resolve to the same incident.
   */
  procedure either_reference_resolves_same
  is
    l_incident_id_1        ersh_shield_incidents.shield_incident_id%type;
    l_incident_id_2        ersh_shield_incidents.shield_incident_id%type;
    l_resolved_from_first  ersh_incident_occurrences_vw.shield_incident_id%type;
    l_resolved_from_second ersh_incident_occurrences_vw.shield_incident_id%type;
  begin
    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_resolve
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_ONE'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_dedup_occurrences: divisor is equal to zero'
      , p_logger_log_id    => gc_app_resolve * 1000 + 1
      , o_incident_id      => l_incident_id_1
    );

    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_resolve
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_TWO'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_dedup_occurrences: divisor is equal to zero'
      , p_logger_log_id    => gc_app_resolve * 1000 + 2
      , o_incident_id      => l_incident_id_2
    );

    select shield_incident_id
      into l_resolved_from_first
      from ersh_incident_occurrences_vw
     where logger_log_id = gc_app_resolve * 1000 + 1;

    select shield_incident_id
      into l_resolved_from_second
      from ersh_incident_occurrences_vw
     where logger_log_id = gc_app_resolve * 1000 + 2;

    ut.expect(l_resolved_from_first).to_equal(l_incident_id_1);
    ut.expect(l_resolved_from_second).to_equal(l_incident_id_1);
  end either_reference_resolves_same;




  -- ===========================================================================
  -- TEST: different_workspace_new_incident
  -- ===========================================================================
  procedure different_workspace_new_incident
  is
    l_incident_id_ws1  ersh_shield_incidents.shield_incident_id%type;
    l_incident_id_ws2  ersh_shield_incidents.shield_incident_id%type;
  begin
    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_workspace
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_ONE'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_dedup_occurrences: divisor is equal to zero'
      , p_logger_log_id    => gc_app_workspace * 1000 + 1
      , o_incident_id      => l_incident_id_ws1
    );

    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 2
      , p_application_id   => gc_app_workspace
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_ONE'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_dedup_occurrences: divisor is equal to zero'
      , p_logger_log_id    => gc_app_workspace * 1000 + 2
      , o_incident_id      => l_incident_id_ws2
    );

    ut.expect(l_incident_id_ws2).not_to_equal(l_incident_id_ws1);
  end different_workspace_new_incident;




  -- ===========================================================================
  -- TEST: component_type_and_name_stored
  -- ===========================================================================
  procedure component_type_and_name_stored
  is
    l_incident_id    ersh_shield_incidents.shield_incident_id%type;
    l_component_type ersh_shield_incidents.component_type%type;
    l_component_name ersh_shield_incidents.component_name%type;
  begin
    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_component
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_ONE'
      , p_component_type   => 'REGION'
      , p_component_name   => 'UT_TEST_REGION'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_dedup_occurrences: divisor is equal to zero'
      , p_logger_log_id    => gc_app_component * 1000 + 1
      , o_incident_id      => l_incident_id
    );

    select component_type
         , component_name
      into l_component_type
         , l_component_name
      from ersh_shield_incidents
     where shield_incident_id = l_incident_id;

    ut.expect(l_component_type).to_equal('REGION');
    ut.expect(l_component_name).to_equal('UT_TEST_REGION');
  end component_type_and_name_stored;


end ut_ersh_dedup_occurrences;
/
