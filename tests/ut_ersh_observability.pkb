create or replace package body ut_ersh_observability
as

  gc_pref_type          constant varchar2(30) := 'ERSH';
  gc_fixture_scrub_func constant varchar2(60) := 'UT_ERSH_OBS_SCRUB_OK';

  gc_app_scrub_default    constant number := 999301;
  gc_app_scrub_configured constant number := 999302;
  gc_app_scrub_dedup      constant number := 999303;
  gc_app_scrub_broken     constant number := 999304;
  gc_app_purge_old        constant number := 999305;
  gc_app_purge_old_occ    constant number := 999306;
  gc_app_purge_recent     constant number := 999307;

  gc_range_lo constant number := 999300;
  gc_range_hi constant number := 999399;




  -- ===========================================================================
  -- PROCEDURE: create_fixture_scrub_function (%beforeall)
  -- ===========================================================================
  procedure create_fixture_scrub_function
  is
  begin
    execute immediate q'{
      create or replace function ut_ersh_obs_scrub_ok(
        p_message in varchar2
      ) return varchar2
      is
      begin
        return 'SCRUBBED[' || length(p_message) || ']';
      end ut_ersh_obs_scrub_ok;
    }';
  end create_fixture_scrub_function;




  -- ===========================================================================
  -- PROCEDURE: drop_fixture_scrub_function (%afterall)
  -- ===========================================================================
  procedure drop_fixture_scrub_function
  is
  begin
    execute immediate 'drop function ut_ersh_obs_scrub_ok';
  end drop_fixture_scrub_function;




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
              where application_id between gc_range_lo and gc_range_hi
           );

    delete
      from ersh_shield_incidents
     where application_id between gc_range_lo and gc_range_hi;

    -- SCRUB_FUNCTION is never seeded (logger_prefs.pref_value is not null,
    -- so there is no "empty but present" value) — restoring the inert
    -- default means deleting the row, not setting it back to something.
    delete
      from logger_prefs
     where pref_type = gc_pref_type
       and pref_name = 'SCRUB_FUNCTION';

    commit;
  end cleanup_test_fixtures;




  -- ===========================================================================
  -- TEST: scrub_inert_by_default
  -- ===========================================================================
  procedure scrub_inert_by_default
  is
    l_incident_id ersh_shield_incidents.shield_incident_id%type;
    l_summary     ersh_shield_incidents.error_summary%type;
    l_message     constant varchar2(200) := 'UT observability: raw message, no scrub configured';
  begin
    ersh_error_handler_api.record_internal_incident(
        p_application_id => gc_app_scrub_default
      , p_ora_sqlcode    => -1476
      , p_error_message  => l_message
      , p_logger_log_id  => gc_app_scrub_default * 1000 + 1
      , o_incident_id    => l_incident_id
    );

    select error_summary
      into l_summary
      from ersh_shield_incidents
     where shield_incident_id = l_incident_id;

    ut.expect(l_summary).to_equal(l_message);
  end scrub_inert_by_default;




  -- ===========================================================================
  -- TEST: scrub_applies_when_configured
  -- ===========================================================================
  procedure scrub_applies_when_configured
  is
    l_incident_id ersh_shield_incidents.shield_incident_id%type;
    l_summary     ersh_shield_incidents.error_summary%type;
    l_message     constant varchar2(200) := 'UT observability: this must not appear verbatim';
  begin
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'SCRUB_FUNCTION', p_pref_value => gc_fixture_scrub_func);

    ersh_error_handler_api.record_internal_incident(
        p_application_id => gc_app_scrub_configured
      , p_ora_sqlcode    => -1476
      , p_error_message  => l_message
      , p_logger_log_id  => gc_app_scrub_configured * 1000 + 1
      , o_incident_id    => l_incident_id
    );

    select error_summary
      into l_summary
      from ersh_shield_incidents
     where shield_incident_id = l_incident_id;

    ut.expect(l_summary).to_equal('SCRUBBED[' || length(l_message) || ']');
  end scrub_applies_when_configured;




  -- ===========================================================================
  -- TEST: scrub_does_not_affect_dedup
  -- ===========================================================================
  /**
   * The fingerprint must be computed from the raw message, not the scrubbed
   * one — otherwise two genuinely different errors that happen to scrub to
   * the same text could wrongly dedupe.
   */
  procedure scrub_does_not_affect_dedup
  is
    l_incident_id_1 ersh_shield_incidents.shield_incident_id%type;
    l_incident_id_2 ersh_shield_incidents.shield_incident_id%type;
    l_occurrence_count ersh_shield_incidents.occurrence_count%type;
    l_message constant varchar2(200) := 'UT observability: same error, scrubbed both times';
  begin
    logger.set_pref(p_pref_type => gc_pref_type, p_pref_name => 'SCRUB_FUNCTION', p_pref_value => gc_fixture_scrub_func);

    ersh_error_handler_api.record_internal_incident(
        p_application_id => gc_app_scrub_dedup
      , p_ora_sqlcode    => -1476
      , p_error_message  => l_message
      , p_logger_log_id  => gc_app_scrub_dedup * 1000 + 1
      , o_incident_id    => l_incident_id_1
    );

    ersh_error_handler_api.record_internal_incident(
        p_application_id => gc_app_scrub_dedup
      , p_ora_sqlcode    => -1476
      , p_error_message  => l_message
      , p_logger_log_id  => gc_app_scrub_dedup * 1000 + 2
      , o_incident_id    => l_incident_id_2
    );

    ut.expect(l_incident_id_2).to_equal(l_incident_id_1);

    select occurrence_count
      into l_occurrence_count
      from ersh_shield_incidents
     where shield_incident_id = l_incident_id_1;

    ut.expect(l_occurrence_count).to_equal(2);
  end scrub_does_not_affect_dedup;




  -- ===========================================================================
  -- TEST: scrub_falls_back_when_function_broken
  -- ===========================================================================
  procedure scrub_falls_back_when_function_broken
  is
    l_incident_id ersh_shield_incidents.shield_incident_id%type;
    l_summary     ersh_shield_incidents.error_summary%type;
    l_message     constant varchar2(200) := 'UT observability: must survive a broken scrub function';
  begin
    logger.set_pref(
        p_pref_type  => gc_pref_type
      , p_pref_name  => 'SCRUB_FUNCTION'
      , p_pref_value => 'UT_FUNCTION_THAT_DOES_NOT_EXIST_XYZ'
    );

    ersh_error_handler_api.record_internal_incident(
        p_application_id => gc_app_scrub_broken
      , p_ora_sqlcode    => -1476
      , p_error_message  => l_message
      , p_logger_log_id  => gc_app_scrub_broken * 1000 + 1
      , o_incident_id    => l_incident_id
    );

    select error_summary
      into l_summary
      from ersh_shield_incidents
     where shield_incident_id = l_incident_id;

    ut.expect(l_summary).to_equal(l_message);
  end scrub_falls_back_when_function_broken;




  -- ===========================================================================
  -- TEST: purge_deletes_old_incidents
  -- ===========================================================================
  procedure purge_deletes_old_incidents
  is
    l_incident_id ersh_shield_incidents.shield_incident_id%type;
    l_count       pls_integer;
  begin
    ersh_error_handler_api.record_internal_incident(
        p_application_id => gc_app_purge_old
      , p_ora_sqlcode    => -1476
      , p_error_message  => 'UT observability: old incident, must be purged'
      , p_logger_log_id  => gc_app_purge_old * 1000 + 1
      , o_incident_id    => l_incident_id
    );

    update ersh_shield_incidents
       set created_on = systimestamp - interval '100' day(3)
     where shield_incident_id = l_incident_id;
    commit;

    ersh_error_handler_api.purge_incidents(p_purge_after_days => 90);

    select count(1)
      into l_count
      from ersh_shield_incidents
     where shield_incident_id = l_incident_id;

    ut.expect(l_count).to_equal(0);
  end purge_deletes_old_incidents;




  -- ===========================================================================
  -- TEST: purge_deletes_old_occurrences
  -- ===========================================================================
  procedure purge_deletes_old_occurrences
  is
    l_incident_id ersh_shield_incidents.shield_incident_id%type;
    l_count       pls_integer;
  begin
    ersh_error_handler_api.record_internal_incident(
        p_application_id => gc_app_purge_old_occ
      , p_ora_sqlcode    => -1476
      , p_error_message  => 'UT observability: old incident, occurrence must be purged too'
      , p_logger_log_id  => gc_app_purge_old_occ * 1000 + 1
      , o_incident_id    => l_incident_id
    );

    update ersh_shield_incidents
       set created_on = systimestamp - interval '100' day(3)
     where shield_incident_id = l_incident_id;
    commit;

    ersh_error_handler_api.purge_incidents(p_purge_after_days => 90);

    select count(1)
      into l_count
      from ersh_incident_occurrences
     where logger_log_id = gc_app_purge_old_occ * 1000 + 1;

    ut.expect(l_count).to_equal(0);
  end purge_deletes_old_occurrences;




  -- ===========================================================================
  -- TEST: purge_keeps_recent_incidents
  -- ===========================================================================
  procedure purge_keeps_recent_incidents
  is
    l_incident_id ersh_shield_incidents.shield_incident_id%type;
    l_count       pls_integer;
  begin
    ersh_error_handler_api.record_internal_incident(
        p_application_id => gc_app_purge_recent
      , p_ora_sqlcode    => -1476
      , p_error_message  => 'UT observability: recent incident, must survive purge'
      , p_logger_log_id  => gc_app_purge_recent * 1000 + 1
      , o_incident_id    => l_incident_id
    );

    ersh_error_handler_api.purge_incidents(p_purge_after_days => 90);

    select count(1)
      into l_count
      from ersh_shield_incidents
     where shield_incident_id = l_incident_id;

    ut.expect(l_count).to_equal(1);
  end purge_keeps_recent_incidents;


end ut_ersh_observability;
/
