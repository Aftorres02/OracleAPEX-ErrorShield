-- =============================================================================
-- View: ersh_related_logs_vw
-- Purpose: For every logger_logs row (the anchor), the logger_logs rows
--          written by the same request around it. This is the trail a
--          support developer needs once a reference code leads them to its
--          logger_logs row: the START / parameter / log_error rows the
--          business package wrote before the error reached the APEX error
--          handler (whose own log_error row IS the reference code).
--          Always filter by anchor_log_id. Used by the ErrorShield admin
--          application (page 410 related logs region).
--
--          Logger does not record a request id, so there is no key to join
--          on. "Same request" is approximated by three conditions, all
--          null-safe (decode treats two nulls as equal):
--            - same client_identifier: APP_USER:APP_SESSION inside APEX, so
--              rows from other users/sessions never mix in. Null for
--              scheduler jobs and APEX automations.
--            - same sid: an APEX request runs on one pooled database session
--              from start to end, so this drops other requests of the same
--              APEX session served by a different pooled session. For jobs
--              and automations (null client_identifier) it is the only
--              session filter.
--            - time window: 2 minutes before the anchor through 5 seconds
--              after it. A request that runs longer than 2 minutes before
--              failing loses its earliest rows; a pooled session reused by
--              the same APEX session within the window brings in rows from
--              that earlier request too.
--
--          Which rows exist depends on the Logger LEVEL at the time: at
--          ERROR only log_error rows are written, so START/params rows only
--          appear when the level was DEBUG. Logger's purge job also removes
--          DEBUG rows sooner than ERROR rows (PURGE_MIN_LEVEL), so an older
--          reference may keep its own row but lose most of its trail.
--
--          Performance: anchor_log_id = :x resolves the anchor through
--          logger_logs_pk; the trail rows come from a time_stamp range scan
--          on logger_logs_idx1 (time_stamp, logger_level), then the
--          sid/client_identifier filter.
--
-- @author Angel Flores (Consultant)
-- @created October 5, 2026
-- @ticket ERSH-051
-- =============================================================================
create or replace view ersh_related_logs_vw
as
with w_anchor as (
  select a.id                                                       as anchor_log_id
       , a.client_identifier                                        as client_identifier
       , a.sid                                                      as sid
       , a.time_stamp                                               as time_stamp
    from logger_logs a
)
select w.anchor_log_id                                              as anchor_log_id
     , l.id                                                         as log_id
     , case when l.id = w.anchor_log_id then 'Y' else 'N' end       as anchor_yn
     , l.logger_level                                               as logger_level
     -- Same names as the logger.g_* level constants (logger.pks).
     , case l.logger_level
         when 1   then 'PERMANENT'
         when 2   then 'ERROR'
         when 4   then 'WARNING'
         when 8   then 'INFORMATION'
         when 16  then 'DEBUG'
         when 32  then 'TIMING'
         when 64  then 'SYS_CONTEXT'
         when 128 then 'APEX'
       end                                                          as level_name
     , l.time_stamp                                                 as time_stamp
     , l.scope                                                      as scope
     , l.text                                                       as text
     , l.module                                                     as module
     , l.action                                                     as action
     , l.client_identifier                                          as client_identifier
     , l.sid                                                        as sid
  from w_anchor                          w
  join logger_logs                       l on l.time_stamp between w.time_stamp - interval '2' minute
                                                               and w.time_stamp + interval '5' second
                                          and decode(l.sid, w.sid, 1, 0) = 1
                                          and decode(l.client_identifier, w.client_identifier, 1, 0) = 1;
