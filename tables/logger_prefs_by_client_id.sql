declare
  l_count pls_integer;
  l_nullable user_tab_columns.nullable%type;

  type typ_required_columns is table of varchar2(30) index by pls_integer;
  l_required_columns typ_required_columns;

  l_sql varchar2(2000);

begin
  -- Create Table
  select count(1)
  into l_count
  from user_tables
  where table_name = 'LOGGER_PREFS_BY_CLIENT_ID';

  if l_count = 0 then
    execute immediate q'!
create table logger_prefs_by_client_id(
  client_id varchar2(64) not null,
  logger_level varchar2(20) not null,
  include_call_stack varchar2(5) not null,
  created_date date default sysdate not null,
  expiry_date date not null,
  constraint logger_prefs_by_client_id_pk primary key (client_id) enable,
  constraint logger_prefs_by_client_id_ck1 check (logger_level in ('OFF','PERMANENT','ERROR','WARNING','INFORMATION','DEBUG','TIMING')),
  constraint logger_prefs_by_client_id_ck2 check (expiry_date >= created_date),
  constraint logger_prefs_by_client_id_ck3 check (include_call_stack in ('TRUE', 'FALSE'))
)
    !';
  end if;

  -- COMMENTS
  execute immediate q'!comment on table logger_prefs_by_client_id is 'Client specific logger levels. Only active client_ids/logger_levels will be maintained in this table'!';
  execute immediate q'!comment on column logger_prefs_by_client_id.client_id is 'Client identifier'!';
  execute immediate q'!comment on column logger_prefs_by_client_id.logger_level is 'Logger level. Must be OFF, PERMANENT, ERROR, WARNING, INFORMATION, DEBUG, TIMING'!';
  execute immediate q'!comment on column logger_prefs_by_client_id.include_call_stack is 'Include call stack in logging'!';
  execute immediate q'!comment on column logger_prefs_by_client_id.created_date is 'Date that entry was created on'!';
  execute immediate q'!comment on column logger_prefs_by_client_id.expiry_date is 'After the given expiry date the logger_level will be disabled for the specific client_id. Unless sepcifically removed from this table a job will clean up old entries'!';


  -- ---------------------------------------------------------------------------
  -- 92: Missing APEX and SYS_CONTEXT support
  -- Idempotent: only drop + rebuild the check constraint when the existing
  -- definition is the old/narrow one (i.e. it does not already include 'APEX').
  -- If the constraint was removed manually, it will be re-created below.
  -- ---------------------------------------------------------------------------
  declare
    l_search_condition user_constraints.search_condition_vc%type;
  begin
    select search_condition_vc
      into l_search_condition
      from user_constraints
     where table_name      = 'LOGGER_PREFS_BY_CLIENT_ID'
       and constraint_name = 'LOGGER_PREFS_BY_CLIENT_ID_CK1';

    if l_search_condition is null or l_search_condition not like '%APEX%' then
      execute immediate 'alter table logger_prefs_by_client_id drop constraint logger_prefs_by_client_id_ck1';

      execute immediate q'!alter table logger_prefs_by_client_id
        add constraint logger_prefs_by_client_id_ck1
        check (logger_level in ('OFF','PERMANENT','ERROR','WARNING','INFORMATION','DEBUG','TIMING', 'APEX', 'SYS_CONTEXT'))!';
    end if;
  exception
    when no_data_found then
      execute immediate q'!alter table logger_prefs_by_client_id
        add constraint logger_prefs_by_client_id_ck1
        check (logger_level in ('OFF','PERMANENT','ERROR','WARNING','INFORMATION','DEBUG','TIMING', 'APEX', 'SYS_CONTEXT'))!';
  end;

end;
/
