create or replace package body ut_ersh_related_logs
as

  -- Reserved application_id sentinels for this suite (record_internal_incident
  -- rows), cleaned up by range in %aftereach.
  gc_app_log_status    constant number := 999501;

  gc_range_lo          constant number := 999500;
  gc_range_hi          constant number := 999599;

  -- Reserved logger_logs ids, one block of 1000 per test. Real logger ids
  -- come from logger_logs_seq and are nowhere near this range.
  gc_log_same_request  constant number := 999501000;
  gc_log_other_session constant number := 999502000;
  gc_log_other_sid     constant number := 999503000;
  gc_log_window        constant number := 999504000;
  gc_log_no_client     constant number := 999505000;
  gc_log_status        constant number := 999506000;

  gc_log_lo            constant number := 999500000;
  gc_log_hi            constant number := 999599999;

  -- Every fixture row is placed relative to this anchor time, far in the past
  -- so no real logger_logs row can fall inside a trail window.
  gc_anchor_time       constant timestamp := timestamp '2000-01-01 12:00:00';




  -- ===========================================================================
  -- PROCEDURE: cleanup_test_fixtures (%aftereach)
  -- ===========================================================================
  /**
   * Deletes every logger_logs/incident/occurrence row this suite may have
   * created, by the reserved ranges above. Not scoped to the test that just
   * ran: a failed assertion mid-test can leave rows behind from an earlier
   * attempt, so every run clears the whole range.
   */
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

    delete
      from logger_logs
     where id between gc_log_lo and gc_log_hi;

    commit;
  end cleanup_test_fixtures;




  -- ===========================================================================
  -- PROCEDURE: insert_log (fixture helper)
  -- ===========================================================================
  /**
   * Inserts one logger_logs row with exactly the correlation columns the
   * trail view matches on, bypassing logger so the test controls id,
   * time_stamp, sid and client_identifier.
   */
  procedure insert_log(
      p_id                                      in logger_logs.id%type
    , p_time_stamp                              in logger_logs.time_stamp%type
    , p_sid                                     in logger_logs.sid%type
    , p_client_identifier                       in logger_logs.client_identifier%type
    , p_logger_level                            in logger_logs.logger_level%type default 2
  )
  is
  begin
    insert
      into logger_logs (
           id
         , logger_level
         , text
         , time_stamp
         , scope
         , client_identifier
         , sid
    )
    values (
           p_id
         , p_logger_level
         , 'ut_ersh_related_logs fixture'
         , p_time_stamp
         , 'ut_ersh_related_logs'
         , p_client_identifier
         , p_sid
    );
  end insert_log;




  -- ===========================================================================
  -- FUNCTION: trail_count (assertion helper)
  -- ===========================================================================
  /**
   * Number of times p_log_id appears in the trail of p_anchor_log_id: 1 when
   * the view treats it as part of the same request, 0 when it does not.
   */
  function trail_count(
      p_anchor_log_id                           in logger_logs.id%type
    , p_log_id                                  in logger_logs.id%type
  ) return number
  is
    l_count number;
  begin
    select count(1)
      into l_count
      from ersh_related_logs_vw
     where anchor_log_id = p_anchor_log_id
       and log_id        = p_log_id;

    return l_count;
  end trail_count;




  -- ===========================================================================
  -- TEST: trail_includes_same_request
  -- ===========================================================================
  /**
   * The shape of a real APEX failure: the business package logs START and
   * its own 'Unhandled Exception', then the APEX error handler logs the
   * reference code row. Opening the reference must show all three, with only
   * the reference itself flagged as the anchor.
   */
  procedure trail_includes_same_request
  is
    l_total_rows  number;
    l_anchor_id   ersh_related_logs_vw.log_id%type;
    l_start_level ersh_related_logs_vw.level_name%type;
  begin
    insert_log(
        p_id                => gc_log_same_request + 1
      , p_time_stamp        => gc_anchor_time - interval '1' second
      , p_sid               => -51
      , p_client_identifier => 'UT_ERSH_051:1'
      , p_logger_level      => 16
    );

    insert_log(
        p_id                => gc_log_same_request + 2
      , p_time_stamp        => gc_anchor_time - interval '0.5' second
      , p_sid               => -51
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    insert_log(
        p_id                => gc_log_same_request + 3
      , p_time_stamp        => gc_anchor_time
      , p_sid               => -51
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    select count(1)
      into l_total_rows
      from ersh_related_logs_vw
     where anchor_log_id = gc_log_same_request + 3;

    select log_id
      into l_anchor_id
      from ersh_related_logs_vw
     where anchor_log_id = gc_log_same_request + 3
       and anchor_yn     = 'Y';

    select level_name
      into l_start_level
      from ersh_related_logs_vw
     where anchor_log_id = gc_log_same_request + 3
       and log_id        = gc_log_same_request + 1;

    ut.expect(l_total_rows).to_equal(3);
    ut.expect(l_anchor_id).to_equal(gc_log_same_request + 3);
    ut.expect(l_start_level).to_equal('DEBUG');
  end trail_includes_same_request;




  -- ===========================================================================
  -- TEST: trail_excludes_other_apex_session
  -- ===========================================================================
  /**
   * Same pooled database session (sid), different APEX user/session: another
   * user's request must never leak into this reference's trail.
   */
  procedure trail_excludes_other_apex_session
  is
  begin
    insert_log(
        p_id                => gc_log_other_session + 1
      , p_time_stamp        => gc_anchor_time
      , p_sid               => -52
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    insert_log(
        p_id                => gc_log_other_session + 2
      , p_time_stamp        => gc_anchor_time - interval '1' second
      , p_sid               => -52
      , p_client_identifier => 'UT_ERSH_051:2'
    );

    ut.expect(trail_count(gc_log_other_session + 1, gc_log_other_session + 1)).to_equal(1);
    ut.expect(trail_count(gc_log_other_session + 1, gc_log_other_session + 2)).to_equal(0);
  end trail_excludes_other_apex_session;




  -- ===========================================================================
  -- TEST: trail_excludes_other_db_session
  -- ===========================================================================
  /**
   * Same APEX session, different database session: a different request of
   * the same user, served by another pooled session, is not this request.
   */
  procedure trail_excludes_other_db_session
  is
  begin
    insert_log(
        p_id                => gc_log_other_sid + 1
      , p_time_stamp        => gc_anchor_time
      , p_sid               => -53
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    insert_log(
        p_id                => gc_log_other_sid + 2
      , p_time_stamp        => gc_anchor_time - interval '1' second
      , p_sid               => -54
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    ut.expect(trail_count(gc_log_other_sid + 1, gc_log_other_sid + 2)).to_equal(0);
  end trail_excludes_other_db_session;




  -- ===========================================================================
  -- TEST: trail_excludes_outside_window
  -- ===========================================================================
  /**
   * Rows of the same session are only part of the trail from 2 minutes
   * before the anchor through 5 seconds after it.
   */
  procedure trail_excludes_outside_window
  is
  begin
    insert_log(
        p_id                => gc_log_window + 1
      , p_time_stamp        => gc_anchor_time
      , p_sid               => -55
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    -- Just inside the window: 1 minute 59 seconds before.
    insert_log(
        p_id                => gc_log_window + 2
      , p_time_stamp        => gc_anchor_time - numtodsinterval(119, 'second')
      , p_sid               => -55
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    -- Too early: 2 minutes 1 second before.
    insert_log(
        p_id                => gc_log_window + 3
      , p_time_stamp        => gc_anchor_time - numtodsinterval(121, 'second')
      , p_sid               => -55
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    -- Too late: 6 seconds after.
    insert_log(
        p_id                => gc_log_window + 4
      , p_time_stamp        => gc_anchor_time + interval '6' second
      , p_sid               => -55
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    ut.expect(trail_count(gc_log_window + 1, gc_log_window + 2)).to_equal(1);
    ut.expect(trail_count(gc_log_window + 1, gc_log_window + 3)).to_equal(0);
    ut.expect(trail_count(gc_log_window + 1, gc_log_window + 4)).to_equal(0);
  end trail_excludes_outside_window;




  -- ===========================================================================
  -- TEST: trail_matches_by_sid_without_client
  -- ===========================================================================
  /**
   * Scheduler jobs and APEX automations log with a null client_identifier.
   * Their trail falls back to the sid alone (null-safe match), and a row that
   * does carry a client_identifier is a different context.
   */
  procedure trail_matches_by_sid_without_client
  is
  begin
    insert_log(
        p_id                => gc_log_no_client + 1
      , p_time_stamp        => gc_anchor_time
      , p_sid               => -56
      , p_client_identifier => null
    );

    insert_log(
        p_id                => gc_log_no_client + 2
      , p_time_stamp        => gc_anchor_time - interval '1' second
      , p_sid               => -56
      , p_client_identifier => null
    );

    insert_log(
        p_id                => gc_log_no_client + 3
      , p_time_stamp        => gc_anchor_time - interval '1' second
      , p_sid               => -56
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    ut.expect(trail_count(gc_log_no_client + 1, gc_log_no_client + 2)).to_equal(1);
    ut.expect(trail_count(gc_log_no_client + 1, gc_log_no_client + 3)).to_equal(0);
  end trail_matches_by_sid_without_client;




  -- ===========================================================================
  -- TEST: occurrences_report_log_status
  -- ===========================================================================
  /**
   * Three hits of one incident: one whose logger_logs row exists, one whose
   * row is gone (purged), one where logger.log_error failed and no reference
   * code was ever issued. The page only offers a working link for 'Logged'.
   */
  procedure occurrences_report_log_status
  is
    l_incident_id_logged     ersh_shield_incidents.shield_incident_id%type;
    l_incident_id_purged     ersh_shield_incidents.shield_incident_id%type;
    l_incident_id_not_logged ersh_shield_incidents.shield_incident_id%type;
    l_status_logged          ersh_incident_occurrences_vw.log_status%type;
    l_status_purged          ersh_incident_occurrences_vw.log_status%type;
    l_status_not_logged      ersh_incident_occurrences_vw.log_status%type;
    l_client_identifier      ersh_incident_occurrences_vw.client_identifier%type;
  begin
    insert_log(
        p_id                => gc_log_status + 1
      , p_time_stamp        => gc_anchor_time
      , p_sid               => -57
      , p_client_identifier => 'UT_ERSH_051:1'
    );

    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_log_status
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_ONE'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_related_logs: divisor is equal to zero'
      , p_logger_log_id    => gc_log_status + 1
      , o_incident_id      => l_incident_id_logged
    );

    -- No logger_logs row with this id: stands in for a purged log.
    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_log_status
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_TWO'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_related_logs: divisor is equal to zero'
      , p_logger_log_id    => gc_log_status + 2
      , o_incident_id      => l_incident_id_purged
    );

    ersh_error_handler_api.record_internal_incident(
        p_workspace_id     => 1
      , p_application_id   => gc_app_log_status
      , p_page_id          => 1
      , p_app_user         => 'UT_USER_THREE'
      , p_ora_sqlcode      => -1476
      , p_error_message    => 'ut_ersh_related_logs: divisor is equal to zero'
      , p_logger_log_id    => null
      , o_incident_id      => l_incident_id_not_logged
    );

    select log_status
         , client_identifier
      into l_status_logged
         , l_client_identifier
      from ersh_incident_occurrences_vw
     where logger_log_id = gc_log_status + 1;

    select log_status
      into l_status_purged
      from ersh_incident_occurrences_vw
     where logger_log_id = gc_log_status + 2;

    select log_status
      into l_status_not_logged
      from ersh_incident_occurrences_vw
     where shield_incident_id = l_incident_id_not_logged
       and logger_log_id is null;

    ut.expect(l_status_logged).to_equal('Logged');
    ut.expect(l_client_identifier).to_equal('UT_ERSH_051:1');
    ut.expect(l_status_purged).to_equal('Purged');
    ut.expect(l_status_not_logged).to_equal('Not logged');
  end occurrences_report_log_status;

end ut_ersh_related_logs;
/
