-- =============================================================================
-- Tables
-- =============================================================================
-- Logger tables (order matters: prefs -> logs -> dependents)
-- =============================================================================

prompt *** Logger Tables ***

prompt @../tables/logger_prefs.sql
@../tables/logger_prefs.sql

prompt @../tables/logger_logs.sql
@../tables/logger_logs.sql

prompt @../tables/logger_logs_apex_items.sql
@../tables/logger_logs_apex_items.sql

prompt @../tables/logger_prefs_by_client_id.sql
@../tables/logger_prefs_by_client_id.sql


-- =============================================================================
-- ERSH tables
-- =============================================================================

prompt *** ERSH Tables ***

prompt @../tables/ersh_constraint_lookup.sql
@../tables/ersh_constraint_lookup.sql

prompt @../tables/ersh_error_lookup.sql
@../tables/ersh_error_lookup.sql

prompt @../tables/ersh_shield_incidents.sql
@../tables/ersh_shield_incidents.sql
