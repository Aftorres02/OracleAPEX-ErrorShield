create or replace package body ut_ersh_core_bugs
as

  gc_active_code        constant ersh_error_lookup.error_code%type := 'UT_ERSH_ACTIVE_CODE';
  gc_active_ora_sqlcode constant ersh_error_lookup.ora_sqlcode%type := -20501;
  gc_active_message     constant ersh_error_lookup.message%type := 'UT test: active code message.';

  gc_inactive_code        constant ersh_error_lookup.error_code%type := 'UT_ERSH_INACTIVE_CODE';
  gc_inactive_ora_sqlcode constant ersh_error_lookup.ora_sqlcode%type := -20502;
  gc_inactive_message     constant ersh_error_lookup.message%type := 'UT test: inactive code message - must never be shown.';

  gc_unknown_code constant ersh_error_lookup.error_code%type := 'UT_ERSH_UNKNOWN_CODE_XYZ';




  -- ===========================================================================
  -- PROCEDURE: seed_active_and_inactive_codes (%beforeeach)
  -- ===========================================================================
  procedure seed_active_and_inactive_codes
  is
  begin
    ersh_error_handler_api.merge_ersh_error_lookup(
        p_error_code   => gc_active_code
      , p_ora_sqlcode  => gc_active_ora_sqlcode
      , p_message      => gc_active_message
      , p_active_yn    => 'Y'
    );

    ersh_error_handler_api.merge_ersh_error_lookup(
        p_error_code   => gc_inactive_code
      , p_ora_sqlcode  => gc_inactive_ora_sqlcode
      , p_message      => gc_inactive_message
      , p_active_yn    => 'N'
    );
  end seed_active_and_inactive_codes;




  -- ===========================================================================
  -- TEST: raise_custom_error_active_code
  -- ===========================================================================
  procedure raise_custom_error_active_code
  is
  begin
    begin
      ersh_error_handler_api.raise_custom_error(p_error_code => gc_active_code);
      ut.fail('Expected raise_custom_error to raise an exception for an active code.');
    exception
      when others then
        ut.expect(sqlcode).to_equal(gc_active_ora_sqlcode);
        ut.expect(sqlerrm).to_be_like('%' || gc_active_message || '%');
    end;
  end raise_custom_error_active_code;




  -- ===========================================================================
  -- TEST: raise_custom_error_inactive_code
  -- ===========================================================================
  /**
   * ERSH-022: a deactivated code must behave as if it did not exist — same
   * generic "not implemented" error as an unknown code, never its own
   * business message.
   */
  procedure raise_custom_error_inactive_code
  is
  begin
    begin
      ersh_error_handler_api.raise_custom_error(p_error_code => gc_inactive_code);
      ut.fail('Expected raise_custom_error to raise an exception for a deactivated code.');
    exception
      when others then
        ut.expect(sqlcode).to_equal(-20001);
        ut.expect(sqlerrm).not_to_be_like('%' || gc_inactive_message || '%');
    end;
  end raise_custom_error_inactive_code;




  -- ===========================================================================
  -- TEST: raise_custom_error_unknown_code
  -- ===========================================================================
  procedure raise_custom_error_unknown_code
  is
  begin
    begin
      ersh_error_handler_api.raise_custom_error(p_error_code => gc_unknown_code);
      ut.fail('Expected raise_custom_error to raise an exception for an unknown code.');
    exception
      when others then
        ut.expect(sqlcode).to_equal(-20001);
    end;
  end raise_custom_error_unknown_code;




  -- ===========================================================================
  -- TEST: get_message_active_code
  -- ===========================================================================
  procedure get_message_active_code
  is
  begin
    ut.expect(
      ersh_error_handler_api.get_message(p_error_code => gc_active_code)
    ).to_equal(gc_active_message);
  end get_message_active_code;




  -- ===========================================================================
  -- TEST: get_message_inactive_code_returns_null
  -- ===========================================================================
  procedure get_message_inactive_code_returns_null
  is
  begin
    ut.expect(
      ersh_error_handler_api.get_message(p_error_code => gc_inactive_code)
    ).to_be_null;
  end get_message_inactive_code_returns_null;




  -- ===========================================================================
  -- TEST: get_message_unknown_code_returns_null
  -- ===========================================================================
  procedure get_message_unknown_code_returns_null
  is
  begin
    ut.expect(
      ersh_error_handler_api.get_message(p_error_code => gc_unknown_code)
    ).to_be_null;
  end get_message_unknown_code_returns_null;




  -- ===========================================================================
  -- TEST: merge_rejects_out_of_range_sqlcode
  -- ===========================================================================
  procedure merge_rejects_out_of_range_sqlcode
  is
  begin
    begin
      ersh_error_handler_api.merge_ersh_error_lookup(
          p_error_code  => 'UT_ERSH_OUT_OF_RANGE'
        , p_ora_sqlcode => -19999
        , p_message     => 'UT test: this insert must never succeed.'
      );
      ut.fail('Expected merge_ersh_error_lookup to reject an out-of-range ora_sqlcode.');
    exception
      when others then
        ut.expect(sqlcode).to_equal(-20001);
        ut.expect(sqlerrm).to_be_like('%-20999 and -20000%');
    end;
  end merge_rejects_out_of_range_sqlcode;




  -- ===========================================================================
  -- TEST: merge_accepts_boundary_sqlcodes
  -- ===========================================================================
  procedure merge_accepts_boundary_sqlcodes
  is
    l_ora_sqlcode ersh_error_lookup.ora_sqlcode%type;
  begin
    ersh_error_handler_api.merge_ersh_error_lookup(
        p_error_code  => 'UT_ERSH_BOUNDARY_LOW'
      , p_ora_sqlcode => -20999
      , p_message     => 'UT test: lower boundary.'
    );

    select ora_sqlcode
      into l_ora_sqlcode
      from ersh_error_lookup
     where error_code = 'UT_ERSH_BOUNDARY_LOW';

    ut.expect(l_ora_sqlcode).to_equal(-20999);

    ersh_error_handler_api.merge_ersh_error_lookup(
        p_error_code  => 'UT_ERSH_BOUNDARY_HIGH'
      , p_ora_sqlcode => -20000
      , p_message     => 'UT test: upper boundary.'
    );

    select ora_sqlcode
      into l_ora_sqlcode
      from ersh_error_lookup
     where error_code = 'UT_ERSH_BOUNDARY_HIGH';

    ut.expect(l_ora_sqlcode).to_equal(-20000);
  end merge_accepts_boundary_sqlcodes;


end ut_ersh_core_bugs;
/
