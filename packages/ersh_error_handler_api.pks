create or replace package ersh_error_handler_api is

  function apex_error_handling(
    p_error                                 in apex_error.t_error
  ) return apex_error.t_error_result;


  -- =========================================================================
  -- Custom error code management
  -- =========================================================================

  procedure add_custom_error(
    p_error_code                            in ersh_error_lookup.error_code%type
  , p_ora_sqlcode                           in ersh_error_lookup.ora_sqlcode%type
  , p_message                               in ersh_error_lookup.message%type
  );


  procedure update_custom_error(
    p_error_code                            in ersh_error_lookup.error_code%type
  , p_ora_sqlcode                           in ersh_error_lookup.ora_sqlcode%type
  , p_message                               in ersh_error_lookup.message%type
  );


  procedure delete_custom_error(
    p_error_code                            in ersh_error_lookup.error_code%type
  );


  procedure raise_custom_error(
    p_error_code                            in ersh_error_lookup.error_code%type
  );


end ersh_error_handler_api;
/
