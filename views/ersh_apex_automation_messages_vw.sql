-- =============================================================================
-- View: ersh_apex_automation_messages_vw
-- Purpose: APEX Automation message log (apex_automation_msg_log).
--          Extracted verbatim from the "Messages" region on page 1600
--          (APEX Automations), minus the automation_log_id filter (moved
--          to the region's Where Clause — see p01600-apex-automations.apx,
--          P1600_LOG_ID).
--
-- @author Angel Flores (Consultant)
-- @created September 14, 2026
-- @ticket #10
-- =============================================================================
create or replace view ersh_apex_automation_messages_vw
as
with w_base as (
  select m.automation_log_id                                         as automation_log_id
       , to_char(m.message_timestamp, 'YYYY-MM-DD HH24:MI:SS')       as message_at
       , m.message_type                                              as message_type
       , m.action_name                                               as action_name
       , m.pk_value                                                  as pk_value
       , m.message                                                   as message
    from apex_automation_msg_log m
)
select automation_log_id
     , message_at
     , message_type
     , action_name
     , pk_value
     , message
  from w_base
 order by message_at desc;
