--
define env_schema_name = LOGGER_USER
define env_apex_app_ids = NONE
define env_apex_workspace = NONE


prompt ENV variables
select
  '&env_schema_name.' env_schema_name,
  '&env_apex_app_ids.' env_apex_app_ids,
  '&env_apex_workspace.' env_apex_workspace
from dual;
