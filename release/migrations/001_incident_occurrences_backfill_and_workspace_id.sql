-- =============================================================================
-- Migration: 001_incident_occurrences_backfill_and_workspace_id.sql
--
-- Data transformations for ERSH-013 (workspace_id) and the historical
-- backfill promised by the PR that introduced ersh_incident_occurrences
-- (ERSH-010). The idempotent DDL in tables/ersh_shield_incidents.sql already
-- added the workspace_id column structurally; this script is only about
-- EXISTING DATA in an already-installed schema.
--
-- CONVENTION
--   release/migrations/ scripts are named NNN_<short-description>.sql, run
--   by hand, once, in ascending numeric order, AFTER a release that changed
--   something they care about. They are never invoked automatically by
--   release/_release.sql, which only owns idempotent structure.
--
--   Each script reads the ERSH_VERSION preference (logger_prefs, pref_type
--   'ERSH', read via logger.get_pref) for visibility and stamps it forward
--   at the end via logger.set_pref. This is the FIRST such script:
--   ERSH_VERSION has been a static '1.0.0' default since it was introduced
--   (data/ersh_preferences.sql), with nothing yet distinguishing an install
--   that has these fixes from one that doesn't — so unlike future
--   migrations, this one cannot gate "should I run" on the version number.
--   Both parts below are instead made safe to run against ANY state
--   (already migrated, partially migrated, or never migrated) by being
--   idempotent on their own terms — see each part. Once this script has run
--   once, ERSH_VERSION becomes a meaningful baseline that migration 002
--   onward can actually compare against.
--
-- PART A -- ERSH-010 backfill: one occurrence per pre-existing incident.
--   Any ersh_shield_incidents row with zero ersh_incident_occurrences
--   children predates that fix, and only ever recorded the one
--   logger_log_id/app_user the original MERGE happened to keep on its
--   first hit. This backfills exactly that one occurrence, so the incident
--   is at least resolvable by the one reference code it still has. It
--   cannot recover the reference codes shown to any OTHER user who hit the
--   same bucket before the fix existed -- those were never stored anywhere,
--   there is nothing left to recover them from.
--   Idempotent via NOT EXISTS: safe to re-run.
--
-- PART B -- ERSH-013 workspace_id: DECISION -- mark previous rows as
--   legacy, do not attempt to recompute their fingerprint.
--   Recomputing would require knowing which workspace produced each
--   historical row, but that is exactly the information the original bug
--   lost: application_id alone does not disambiguate workspaces, and
--   nothing else stored on the row can substitute for it. Guessing would
--   risk silently merging or splitting incidents that were never related.
--   workspace_id is left null on every row created before this migration;
--   ersh_shield_incidents_vw and the admin app show that plainly rather
--   than papering over it with a fabricated value. No data is changed by
--   this part -- the column addition in the table DDL already leaves it
--   null on old rows -- it exists to record the decision in one place and
--   give an operator a visibility query.
-- =============================================================================

set serveroutput on
set define '&'
set verify off

whenever sqlerror exit sql.sqlcode

prompt loading environment variables
@@../load_env_vars.sql

prompt check DB user is expected user
declare
begin
  if upper(user) != upper('&env_schema_name') or '&env_schema_name' is null then
    raise_application_error(-20001, 'Must be run as &env_schema_name');
  end if;
end;
/


prompt *** ERSH_VERSION before this migration ***
select logger.get_pref('ERSH_VERSION', 'ERSH') as ersh_version_before from dual;


prompt *** PART A: backfilling ersh_incident_occurrences for pre-existing incidents ***
insert into ersh_incident_occurrences (
  shield_incident_id
, logger_log_id
, app_user
, occurred_on
)
select si.shield_incident_id
     , si.logger_log_id
     , si.app_user
     , si.created_on
  from ersh_shield_incidents si
 where not exists (
         select 1
           from ersh_incident_occurrences io
          where io.shield_incident_id = si.shield_incident_id
       );

commit;


prompt *** PART B: workspace_id on legacy rows (informational only -- no data changed, see header) ***
select count(1) as legacy_rows_without_workspace_id
  from ersh_shield_incidents
 where workspace_id is null;


prompt *** Stamping ERSH_VERSION ***
begin
  logger.set_pref('ERSH', 'ERSH_VERSION', '1.0.0');
end;
/

select logger.get_pref('ERSH_VERSION', 'ERSH') as ersh_version_after from dual;

prompt *** Migration 001 complete ***
