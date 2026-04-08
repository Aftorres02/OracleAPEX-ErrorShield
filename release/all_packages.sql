-- =============================================================================
-- Packages (spec then body)
-- =============================================================================
-- Logger packages must compile before ERSH (dependency)
-- =============================================================================

prompt *** Logger Packages ***

prompt @../packages/logger.pks
@../packages/logger.pks

prompt @../packages/logger.pkb
@../packages/logger.pkb


prompt *** ERSH Packages ***

prompt @../packages/ersh_error_handler_api.pks
@../packages/ersh_error_handler_api.pks

prompt @../packages/ersh_error_handler_api.pkb
@../packages/ersh_error_handler_api.pkb
