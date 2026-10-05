prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2026.03.30'
,p_release=>'26.1.5'
,p_default_workspace_id=>14250927745975321
,p_default_application_id=>10402
,p_default_id_offset=>0
,p_default_owner=>'WKSP_DEVAI1'
);
end;
/
 
prompt APPLICATION 10402 - ErrorShield Error Lab
--
-- Application Export:
--   Application:     10402
--   Name:            ErrorShield Error Lab
--   Date and Time:   04:37 Monday October 5, 2026
--   Exported By:     WKSP_DEVAI1
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                      7
--       Items:                    4
--       Processes:               20
--       Regions:                 42
--       Buttons:                 36
--       Dynamic Actions:          8
--     Shared Components:
--       Logic:
--       Navigation:
--         Lists:                  2
--       Security:
--         Authentication:         1
--       User Interface:
--         Themes:                 1
--         Templates:
--         LOVs:                   1
--       PWA:
--       Globalization:
--       Reports:
--       E-Mail:
--     Supporting Objects:  Included
--   Version:         26.1.5
--   Instance ID:     9052336394712143
--

prompt --application/delete_application
begin
wwv_flow_imp.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/create_application
begin
wwv_imp_workspace.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'WKSP_DEVAI1')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'ErrorShield Error Lab')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'ERROR-LAB')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'640C8BAB356501A21C3727A9CF46E87552BD10912CD590A6A643899D9C227384'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'26.1'
,p_accessible_read_only=>'N'
,p_session_state_commits=>'IMMEDIATE'
,p_flow_language=>'en'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'Y'
,p_date_format=>'DS'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix=>nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication_id=>wwv_flow_imp.id(23874777027209933)
,p_application_tab_set=>1
,p_logo_type=>'T'
,p_logo_text=>'ErrorShield Error Lab'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_runtime_api_usage=>'T'
,p_authorize_batch_job=>'N'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_error_handling_function=>'ersh_error_handler_api.apex_error_handling'
,p_tokenize_row_search=>'N'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'ErrorShield Error Lab'
,p_file_prefix=>nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>2461319043647
,p_print_server_type=>'INSTANCE'
,p_file_storage=>'DB'
,p_is_pwa=>'Y'
,p_pwa_is_installable=>'N'
,p_pwa_is_push_enabled=>'N'
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.'
,p_login_url=>'f?p=&APP_ID.:LOGIN:&SESSION.::&DEBUG.'
,p_theme_style_by_user_pref=>false
,p_built_with_love=>false
,p_global_page_id=>0
,p_navigation_list_id=>wwv_flow_imp.id(24859449620638681)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>2469215554099805162
,p_nav_list_template_options=>'#DEFAULT#:js-navCollapsed--hidden:t-TreeNav--styleA'
,p_css_file_urls=>'#APP_FILES#app.css?version=#APP_VERSION#'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_imp.id(23874829999209933)
,p_nav_bar_list_template_id=>2849019392706229583
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
prompt --application/plugin_settings
begin
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23885607409220672)
,p_plugin_type=>'DYNAMIC ACTION'
,p_plugin=>'NATIVE_OPEN_AI_ASSISTANT'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23886069843220674)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'mode', 'FULL')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23885803919220673)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_DATE_PICKER_APEX'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'show_on', 'FOCUS',
  'time_increment', '15')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23885974653220673)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_GEOCODED_ADDRESS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'background', 'default',
  'display_as', 'LIST',
  'map_preview', 'POPUP:ITEM',
  'match_mode', 'RELAX_HOUSE_NUMBER')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23886366075220675)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SELECT_MANY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_values_as', 'separated')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23885740513220672)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'checked_value', 'Y',
  'unchecked_value', 'N')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23886177934220674)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'default_icon', 'fa-star',
  'tooltip', '#VALUE#')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23886257739220675)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_style', 'SWITCH_CB',
  'off_value', 'N',
  'on_value', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23886442138220676)
,p_plugin_type=>'PROCESS TYPE'
,p_plugin=>'NATIVE_GEOCODING'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'match_mode', 'RELAX_HOUSE_NUMBER')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23886767166220677)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'include_slider', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23886597179220676)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'actions_menu_structure', 'IG')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23886641563220677)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_MAP_REGION'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_vector_tile_layers', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23886949561220678)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_ADFBC'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(23886878497220677)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_BOSS'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_bar
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(23874829999209933)
,p_name=>'Navigation Bar'
,p_static_id=>'navigation-bar'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(23876481481209941)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'---'
,p_static_id=>'---'
,p_list_item_link_target=>'separator'
,p_list_item_disp_cond_type=>'USER_IS_NOT_PUBLIC_USER'
,p_parent_list_item_id=>wwv_flow_imp.id(23876569242209941)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(23876569242209941)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'&APP_USER.'
,p_static_id=>'app-user'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(23876633252209941)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Sign Out'
,p_static_id=>'sign-out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_list_item_disp_cond_type=>'USER_IS_NOT_PUBLIC_USER'
,p_parent_list_item_id=>wwv_flow_imp.id(23876569242209941)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_menu
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(24859449620638681)
,p_name=>'Navigation Menu'
,p_static_id=>'navigation-menu'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24861183255638727)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>unistr('1 \00B7 PL/SQL Runtime')
,p_static_id=>'lesson-1'
,p_list_item_link_target=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.'
,p_list_item_icon=>'fa-code'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24861221509638728)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>unistr('2 \00B7 Table and Column')
,p_static_id=>'lesson-2'
,p_list_item_link_target=>'f?p=&APP_ID.:200:&SESSION.::&DEBUG.'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24861383790638728)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>unistr('3 \00B7 AJAX')
,p_static_id=>'lesson-3'
,p_list_item_link_target=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.'
,p_list_item_icon=>'fa-exchange'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24861426403638728)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>unistr('4 \00B7 Rendering and Business')
,p_static_id=>'lesson-4'
,p_list_item_link_target=>'f?p=&APP_ID.:400:&SESSION.::&DEBUG.'
,p_list_item_icon=>'fa-bug'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(24861073292638726)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Overview'
,p_static_id=>'overview'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/listentry
begin
null;
end;
/
prompt --application/shared_components/files/app_css
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A203D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D0A2020204572726F72536869656C64204572726F72204C';
wwv_flow_imp.g_varchar2_table(2) := '6162202831303430322920E28094207363656E6172696F20636172647320616E64206F7574636F6D65206261646765732E0A202020436F6C6F727320636F6D652066726F6D20556E6976657273616C205468656D65207661726961626C65732028776974';
wwv_flow_imp.g_varchar2_table(3) := '682066616C6C6261636B732920736F20746865206261646765730A202020666F6C6C6F7720746865207468656D65207374796C6520696E7374656164206F662068617264636F64696E6720612070616C657474652E0A2020203D3D3D3D3D3D3D3D3D3D3D';
wwv_flow_imp.g_varchar2_table(4) := '3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D202A2F0A0A2E657273682D6C61622D626164676573207B0A2020646973706C61793A20666C';
wwv_flow_imp.g_varchar2_table(5) := '65783B0A2020666C65782D777261703A20777261703B0A2020616C69676E2D6974656D733A2063656E7465723B0A20206761703A20302E33373572656D3B0A20206D617267696E2D626C6F636B2D656E643A20302E373572656D3B0A7D0A0A2E65727368';
wwv_flow_imp.g_varchar2_table(6) := '2D6C61622D6261646765207B0A2020646973706C61793A20696E6C696E652D626C6F636B3B0A202070616464696E673A20302E31323572656D20302E36323572656D3B0A2020626F726465722D7261646975733A2039393970783B0A2020666F6E742D73';
wwv_flow_imp.g_varchar2_table(7) := '697A653A20302E373572656D3B0A2020666F6E742D7765696768743A203630303B0A20206C696E652D6865696768743A20312E353B0A202077686974652D73706163653A206E6F777261703B0A7D0A0A2E657273682D6C61622D62616467652D636F6465';
wwv_flow_imp.g_varchar2_table(8) := '207B0A2020666F6E742D66616D696C793A20766172282D2D612D626173652D666F6E742D66616D696C792D6D6F6E6F2C206D6F6E6F7370616365293B0A2020636F6C6F723A20766172282D2D75742D626F64792D746578742D636F6C6F722C20696E6865';
wwv_flow_imp.g_varchar2_table(9) := '726974293B0A20206261636B67726F756E642D636F6C6F723A20636F6C6F722D6D697828696E20737267622C2063757272656E74636F6C6F722038252C207472616E73706172656E74293B0A7D0A0A2E657273682D6C61622D62616467652D696E636964';
wwv_flow_imp.g_varchar2_table(10) := '656E74207B0A2020636F6C6F723A20766172282D2D75742D70616C657474652D64616E6765722C2023633734363334293B0A20206261636B67726F756E642D636F6C6F723A20636F6C6F722D6D697828696E20737267622C20766172282D2D75742D7061';
wwv_flow_imp.g_varchar2_table(11) := '6C657474652D64616E6765722C202363373436333429203134252C207472616E73706172656E74293B0A7D0A0A2E657273682D6C61622D62616467652D667269656E646C79207B0A2020636F6C6F723A20766172282D2D75742D70616C657474652D7375';
wwv_flow_imp.g_varchar2_table(12) := '63636573732C2023326237613364293B0A20206261636B67726F756E642D636F6C6F723A20636F6C6F722D6D697828696E20737267622C20766172282D2D75742D70616C657474652D737563636573732C202332623761336429203134252C207472616E';
wwv_flow_imp.g_varchar2_table(13) := '73706172656E74293B0A7D0A0A2E657273682D6C61622D62616467652D6E65757472616C207B0A2020636F6C6F723A20766172282D2D75742D70616C657474652D696E666F2C2023316636666232293B0A20206261636B67726F756E642D636F6C6F723A';
wwv_flow_imp.g_varchar2_table(14) := '20636F6C6F722D6D697828696E20737267622C20766172282D2D75742D70616C657474652D696E666F2C202331663666623229203134252C207472616E73706172656E74293B0A7D0A0A2E657273682D6C61622D6E6F7465207B0A20206D617267696E2D';
wwv_flow_imp.g_varchar2_table(15) := '626C6F636B2D656E643A20303B0A2020666F6E742D73697A653A20302E3831323572656D3B0A20206F7061636974793A20302E37353B0A7D0A0A2E657273682D6C61622D6361726420703A6C6173742D6368696C64207B0A20206D617267696E2D626C6F';
wwv_flow_imp.g_varchar2_table(16) := '636B2D656E643A20303B0A7D0A';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(24860978344638721)
,p_file_name=>'app.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_settings
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs/elab_scenarios
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(23876739802209941)
,p_lov_name=>'ELAB_SCENARIOS'
,p_static_id=>'elab-scenarios'
,p_lov_query=>'.'||wwv_flow_imp.id(23876739802209941)||'.'
,p_location=>'STATIC'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23878108743209943)
,p_lov_disp_sequence=>140
,p_lov_disp_value=>'Order over credit limit (ORA-20000, business)'
,p_lov_return_value=>'BUSINESS_ERROR'
,p_static_id=>'business-error'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23878083852209943)
,p_lov_disp_sequence=>130
,p_lov_disp_value=>'Quantity zero (ORA-02290, friendly)'
,p_lov_return_value=>'CHECK_VIOLATION'
,p_static_id=>'check-violation'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23877806944209943)
,p_lov_disp_sequence=>110
,p_lov_disp_value=>'Delete a customer with orders (ORA-02292)'
,p_lov_return_value=>'CHILD_FOUND'
,p_static_id=>'child-found'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23876873895209941)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Division by zero (ORA-01476)'
,p_lov_return_value=>'DIVIDE_BY_ZERO'
,p_static_id=>'divide-by-zero'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23877189750209942)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>'Invalid date, 31-Feb (ORA-01839)'
,p_lov_return_value=>'INVALID_DATE'
,p_static_id=>'invalid-date'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23877091681209942)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Text converted to number (ORA-01722)'
,p_lov_return_value=>'INVALID_NUMBER'
,p_static_id=>'invalid-number'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23877265858209942)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'No data found (ORA-01403)'
,p_lov_return_value=>'NO_DATA_FOUND'
,p_static_id=>'no-data-found'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23877637893209943)
,p_lov_disp_sequence=>90
,p_lov_disp_value=>'Required column left empty (ORA-01400)'
,p_lov_return_value=>'NOT_NULL'
,p_static_id=>'not-null'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23877539037209942)
,p_lov_disp_sequence=>80
,p_lov_disp_value=>'Number too large for column (ORA-01438)'
,p_lov_return_value=>'NUMERIC_OVERFLOW'
,p_static_id=>'numeric-overflow'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23877718069209943)
,p_lov_disp_sequence=>100
,p_lov_disp_value=>'Order for a missing customer (ORA-02291)'
,p_lov_return_value=>'PARENT_NOT_FOUND'
,p_static_id=>'parent-not-found'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23877349714209942)
,p_lov_disp_sequence=>60
,p_lov_disp_value=>'Too many rows (ORA-01422)'
,p_lov_return_value=>'TOO_MANY_ROWS'
,p_static_id=>'too-many-rows'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23877997979209943)
,p_lov_disp_sequence=>120
,p_lov_disp_value=>'Duplicate customer code (ORA-00001, friendly)'
,p_lov_return_value=>'UNIQUE_VIOLATION'
,p_static_id=>'unique-violation'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23876908186209942)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Value too long for a variable (ORA-06502)'
,p_lov_return_value=>'VALUE_ERROR'
,p_static_id=>'value-error'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(23877453003209942)
,p_lov_disp_sequence=>70
,p_lov_disp_value=>'Text too long for column (ORA-12899)'
,p_lov_return_value=>'VALUE_TOO_LARGE'
,p_static_id=>'value-too-large'
);
end;
/
prompt --application/pages/page_groups
begin
null;
end;
/
prompt --application/shared_components/navigation/breadcrumbentry
begin
null;
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(23876328731209939)
,p_theme_id=>42
,p_static_id=>'universal-theme'
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_version_identifier=>'26.1'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_is_locked=>false
,p_current_theme_style_id=>2599349576570175875
,p_default_page_template=>4073832297226169690
,p_default_dialog_template=>2101883943284197310
,p_error_template=>2102634289808461002
,p_printer_friendly_template=>4073832297226169690
,p_login_template=>2102634289808461002
,p_default_button_template=>4073839297780169708
,p_default_region_template=>4073835273271169698
,p_default_chart_template=>4073835273271169698
,p_default_form_template=>4073835273271169698
,p_default_reportr_template=>4073835273271169698
,p_default_wizard_template=>4073835273271169698
,p_default_menur_template=>2532939663579242476
,p_default_listr_template=>4073835273271169698
,p_default_irr_template=>2102002977963900996
,p_default_report_template=>2540130677583398057
,p_default_label_template=>1610598304472262251
,p_default_menu_template=>4073839682315169711
,p_default_list_template=>4073837480889169704
,p_default_top_nav_list_temp=>2528231041045349458
,p_default_side_nav_list_temp=>2469215554099805162
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>2127905476394690047
,p_default_dialogr_template=>4502917002193490937
,p_default_option_label=>1610598304472262251
,p_default_header_template=>2042159785845301134
,p_default_footer_template=>2042159785845301134
,p_default_required_label=>1610598484065263269
,p_default_navbar_list_template=>2849019392706229583
,p_file_prefix=>nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#APEX_FILES#themes/theme_42/26.1/')
,p_files_version=>2461319043647
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_FILES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_FILES#css/Core#MIN#.css?v=#APEX_VERSION#'
,p_reference_id=>wwv_imp_util.get_subscription_id(4073840274158169736,2000,'universal-theme',8842.261)
,p_version_scn_master=>'SH256:WOPVC8vP1TPWUxczh2dJ4mCZcNGSTzA1cn8DjR2oQjY'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
null;
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_options
begin
null;
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/logic/build_options
begin
null;
end;
/
prompt --application/shared_components/globalization/messages
begin
null;
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/security/authentications/application_express_accounts
begin
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(23874777027209933)
,p_name=>'Application Express Accounts'
,p_static_id=>'application-express-accounts'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00000
begin
wwv_flow_imp_page.create_page(
 p_id=>0
,p_name=>'Global Page'
,p_reload_on_submit=>null
,p_warn_on_unsaved_changes=>null
,p_autocomplete_on_off=>'OFF'
,p_protection_level=>'D'
);
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_imp_page.create_page(
 p_id=>1
,p_name=>'Overview'
,p_alias=>'OVERVIEW'
,p_step_title=>'Overview'
,p_autocomplete_on_off=>'ON'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(23878936215209946)
,p_name=>'Recent Incidents (All Lessons)'
,p_static_id=>'incidentsCR'
,p_region_name=>'incidentsCR'
,p_template=>4073835273271169698
,p_display_sequence=>60
,p_icon_css_classes=>'fa-list-alt'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.page_name                                                  as lesson',
'     , i.component_name                                             as component_name',
'     , i.ora_sqlcode                                                as ora_sqlcode',
'     , i.error_summary                                              as error_summary',
'     , i.occurrence_count                                           as occurrence_count',
'     , to_char(i.created_on, ''DD-MON HH24:MI:SS'')                   as first_seen',
'  from ersh_shield_incidents_vw i',
'  left join apex_application_pages p on p.application_id = i.application_id',
'                                    and p.page_id        = i.page_id',
' where i.application_id = :APP_ID',
' order by i.created_on desc',
' fetch first 10 rows only'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No incidents recorded from this app yet. Start with lesson 1.'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23879033280209946)
,p_query_column_id=>2
,p_column_alias=>'COMPONENT_NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Component'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23879102599209946)
,p_query_column_id=>4
,p_column_alias=>'ERROR_SUMMARY'
,p_column_display_sequence=>40
,p_column_heading=>'Error Summary (admin only)'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23879223828209946)
,p_query_column_id=>6
,p_column_alias=>'FIRST_SEEN'
,p_column_display_sequence=>60
,p_column_heading=>'First Seen'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24862133179638738)
,p_query_column_id=>1
,p_column_alias=>'LESSON'
,p_column_display_sequence=>10
,p_column_heading=>'Lesson'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23879397187209946)
,p_query_column_id=>5
,p_column_alias=>'OCCURRENCE_COUNT'
,p_column_display_sequence=>50
,p_column_heading=>'Hits'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23879481440209946)
,p_query_column_id=>3
,p_column_alias=>'ORA_SQLCODE'
,p_column_display_sequence=>30
,p_column_heading=>'SQLCODE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(23878490145209944)
,p_plug_name=>'ErrorShield Error Lab'
,p_static_id=>'introSR'
,p_region_name=>'introSR'
,p_icon_css_classes=>'fa-flask'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675494171183407654
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Four short lessons that force real Oracle errors from a consumer application. This app reaches',
'ErrorShield only through synonyms and uses <code>ersh_error_handler_api.apex_error_handling</code> as its',
'Error Handling Function, exactly like a production app would.</p>',
'<p>In each lesson: raise an error, read what the user sees, then find the incident below or in the',
'ErrorShield admin app (10400, Incidents).</p>',
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span><span class="ersh-lab-note">unexpected technical error: logged, recorded, masked</span></div>',
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-friendly">Friendly message</span><span class="ersh-lab-note">known error: the registered message is shown, nothing recorded</span></div>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24861784665638735)
,p_plug_name=>unistr('Lesson 1 \00B7 PL/SQL Runtime Errors')
,p_static_id=>'lesson1SR'
,p_region_name=>'lesson1SR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>3
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-neutral">6 errors</span></div>',
'<p>Bugs that only appear when the code runs: math, conversions and lookups.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24861878661638735)
,p_plug_name=>unistr('Lesson 2 \00B7 Table and Column Errors')
,p_static_id=>'lesson2SR'
,p_region_name=>'lesson2SR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-neutral">7 errors</span></div>',
'<p>The table refuses the data. Registered constraints get a friendly message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24861948287638735)
,p_plug_name=>unistr('Lesson 3 \00B7 AJAX Errors')
,p_static_id=>'lesson3SR'
,p_region_name=>'lesson3SR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-neutral">3 channels</span></div>',
'<p>The same failures without a page submit, through three background calls.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24862047921638735)
,p_plug_name=>unistr('Lesson 4 \00B7 Rendering and Business Errors')
,p_static_id=>'lesson4SR'
,p_region_name=>'lesson4SR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-neutral">2 errors</span></div>',
'<p>A region that breaks while the page draws, and a business rule on purpose.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23881646119209949)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(23878936215209946)
,p_button_name=>'REFRESH'
,p_static_id=>'REFRESH'
,p_button_static_id=>'REFRESH'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Refresh'
,p_button_position=>'EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24862269628638738)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24861784665638735)
,p_button_name=>'START_LESSON_1'
,p_static_id=>'START_LESSON_1'
,p_button_static_id=>'START_LESSON_1'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2084305881903810008
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Start lesson 1'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-right'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24862314080638739)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24861878661638735)
,p_button_name=>'START_LESSON_2'
,p_static_id=>'START_LESSON_2'
,p_button_static_id=>'START_LESSON_2'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Start lesson 2'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:200:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-right'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24862480603638739)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24861948287638735)
,p_button_name=>'START_LESSON_3'
,p_static_id=>'START_LESSON_3'
,p_button_static_id=>'START_LESSON_3'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Start lesson 3'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-right'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24862548382638739)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24862047921638735)
,p_button_name=>'START_LESSON_4'
,p_static_id=>'START_LESSON_4'
,p_button_static_id=>'START_LESSON_4'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Start lesson 4'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:400:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-right'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(23882319819209951)
,p_name=>'Refresh Incidents'
,p_static_id=>'refresh-click'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(23881646119209949)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23882483927209951)
,p_event_id=>wwv_flow_imp.id(23882319819209951)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'refresh-incidents'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(23878936215209946)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
end;
/
prompt --application/pages/page_00100
begin
wwv_flow_imp_page.create_page(
 p_id=>100
,p_name=>'PL/SQL Runtime Errors'
,p_alias=>'PLSQL-RUNTIME-ERRORS'
,p_step_title=>'PL/SQL Runtime Errors'
,p_autocomplete_on_off=>'ON'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24862895663638741)
,p_plug_name=>'Division by zero'
,p_static_id=>'divideByZeroSR'
,p_region_name=>'divideByZeroSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-01476</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p>An average over zero rows: <code>100 / count(1)</code> for a customer with no orders.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(24863422957638743)
,p_name=>'Incidents From This Lesson'
,p_static_id=>'incidentsCR'
,p_region_name=>'incidentsCR'
,p_template=>4073835273271169698
,p_display_sequence=>80
,p_icon_css_classes=>'fa-list-alt'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.component_name                                             as component_name',
'     , i.ora_sqlcode                                                as ora_sqlcode',
'     , i.error_summary                                              as error_summary',
'     , i.occurrence_count                                           as occurrence_count',
'     , to_char(i.created_on, ''DD-MON HH24:MI:SS'')                   as first_seen',
'  from ersh_shield_incidents_vw i',
' where i.application_id = :APP_ID',
'   and i.page_id        = :APP_PAGE_ID',
' order by i.created_on desc',
' fetch first 10 rows only'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No incidents from this lesson yet. Raise one of the errors above.'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24863507813638744)
,p_query_column_id=>1
,p_column_alias=>'COMPONENT_NAME'
,p_column_display_sequence=>10
,p_column_heading=>'Component'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24863635755638744)
,p_query_column_id=>3
,p_column_alias=>'ERROR_SUMMARY'
,p_column_display_sequence=>30
,p_column_heading=>'Error Summary (admin only)'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24863786833638744)
,p_query_column_id=>5
,p_column_alias=>'FIRST_SEEN'
,p_column_display_sequence=>50
,p_column_heading=>'First Seen'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24863817078638744)
,p_query_column_id=>4
,p_column_alias=>'OCCURRENCE_COUNT'
,p_column_display_sequence=>40
,p_column_heading=>'Hits'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24863963860638744)
,p_query_column_id=>2
,p_column_alias=>'ORA_SQLCODE'
,p_column_display_sequence=>20
,p_column_heading=>'SQLCODE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24862766705638741)
,p_plug_name=>unistr('Lesson 1 \00B7 PL/SQL Runtime Errors')
,p_static_id=>'introSR'
,p_region_name=>'introSR'
,p_icon_css_classes=>'fa-code'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675494171183407654
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Bugs that only show up when the code runs. None of them is something the user can fix, so',
'ErrorShield treats every one as an unexpected technical error: it logs the full detail, records an',
'incident, and shows the user a masked message with a reference number.</p>',
'<p class="ersh-lab-note">Watch for: the reference number on screen matches the incident in the report',
'at the bottom of the page.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24863189759638742)
,p_plug_name=>'Impossible date'
,p_static_id=>'invalidDateSR'
,p_region_name=>'invalidDateSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>50
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-01839</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p><code>to_date(''31/02/2026'')</code>: what a free-text date field lets users type.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24863096821638742)
,p_plug_name=>'Text converted to number'
,p_static_id=>'invalidNumberSR'
,p_region_name=>'invalidNumberSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-01722</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p><code>to_number()</code> on the customer code <code>C-1001</code>: a data type mismatch.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24864019128638744)
,p_plug_name=>'Lesson Navigation'
,p_static_id=>'lessonNavSR'
,p_region_name=>'lessonNavSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>90
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24863273916638743)
,p_plug_name=>'No data found'
,p_static_id=>'noDataFoundSR'
,p_region_name=>'noDataFoundSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>60
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-01403</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p>A <code>select ... into</code> for a customer id that does not exist.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24863385905638743)
,p_plug_name=>'Too many rows'
,p_static_id=>'tooManyRowsSR'
,p_region_name=>'tooManyRowsSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-01422</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p>A <code>select ... into</code> that matches every active customer.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24862995783638742)
,p_plug_name=>'Variable too small'
,p_static_id=>'valueErrorSR'
,p_region_name=>'valueErrorSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-06502</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p>A customer name fetched into a <code>varchar2(3)</code> variable.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24864103683638745)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24862895663638741)
,p_button_name=>'DIVIDE_BY_ZERO'
,p_static_id=>'DIVIDE_BY_ZERO'
,p_button_static_id=>'DIVIDE_BY_ZERO'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24864470601638745)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24863189759638742)
,p_button_name=>'INVALID_DATE'
,p_static_id=>'INVALID_DATE'
,p_button_static_id=>'INVALID_DATE'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24864398892638745)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24863096821638742)
,p_button_name=>'INVALID_NUMBER'
,p_static_id=>'INVALID_NUMBER'
,p_button_static_id=>'INVALID_NUMBER'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24864943368638746)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(24864019128638744)
,p_button_name=>'NEXT_LESSON'
,p_static_id=>'NEXT_LESSON'
,p_button_static_id=>'NEXT_LESSON'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2084305881903810008
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Lesson 2: Table and Column Errors'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:200:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-right'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24864531276638745)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24863273916638743)
,p_button_name=>'NO_DATA_FOUND'
,p_static_id=>'NO_DATA_FOUND'
,p_button_static_id=>'NO_DATA_FOUND'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24864841916638746)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24864019128638744)
,p_button_name=>'PREVIOUS_LESSON'
,p_static_id=>'PREVIOUS_LESSON'
,p_button_static_id=>'PREVIOUS_LESSON'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Overview'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-left'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24864705999638745)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24863422957638743)
,p_button_name=>'REFRESH'
,p_static_id=>'REFRESH'
,p_button_static_id=>'REFRESH'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Refresh'
,p_button_position=>'EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24864657220638745)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24863385905638743)
,p_button_name=>'TOO_MANY_ROWS'
,p_static_id=>'TOO_MANY_ROWS'
,p_button_static_id=>'TOO_MANY_ROWS'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24864214746638745)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24862995783638742)
,p_button_name=>'VALUE_ERROR'
,p_static_id=>'VALUE_ERROR'
,p_button_static_id=>'VALUE_ERROR'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(24865003623638746)
,p_name=>'Refresh Incidents'
,p_static_id=>'refresh-click'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(24864705999638745)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24865149240638746)
,p_event_id=>wwv_flow_imp.id(24865003623638746)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'refresh-incidents'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(24863422957638743)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24865229981638747)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Division by zero (ORA-01476)'
,p_static_id=>'divide-by-zero'
,p_process_sql_clob=>'elab_errors_api.force_division_by_zero;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''DIVIDE_BY_ZERO'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24865229981638747
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24865500085638747)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Impossible date (ORA-01839)'
,p_static_id=>'invalid-date'
,p_process_sql_clob=>'elab_errors_api.force_invalid_date;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''INVALID_DATE'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24865500085638747
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24865418720638747)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Text converted to number (ORA-01722)'
,p_static_id=>'invalid-number'
,p_process_sql_clob=>'elab_errors_api.force_invalid_number;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''INVALID_NUMBER'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24865418720638747
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24865664709638748)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'No data found (ORA-01403)'
,p_static_id=>'no-data-found'
,p_process_sql_clob=>'elab_errors_api.force_no_data_found;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''NO_DATA_FOUND'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24865664709638748
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24865750043638748)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Too many rows (ORA-01422)'
,p_static_id=>'too-many-rows'
,p_process_sql_clob=>'elab_errors_api.force_too_many_rows;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''TOO_MANY_ROWS'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24865750043638748
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24865333365638747)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Variable too small (ORA-06502)'
,p_static_id=>'value-error'
,p_process_sql_clob=>'elab_errors_api.force_value_error;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''VALUE_ERROR'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24865333365638747
);
end;
/
prompt --application/pages/page_00200
begin
wwv_flow_imp_page.create_page(
 p_id=>200
,p_name=>'Table and Column Errors'
,p_alias=>'TABLE-AND-COLUMN-ERRORS'
,p_step_title=>'Table and Column Errors'
,p_autocomplete_on_off=>'ON'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24866879761638803)
,p_plug_name=>'Quantity of zero'
,p_static_id=>'checkViolationSR'
,p_region_name=>'checkViolationSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-02290</span><span class="ersh-lab-badge ersh-lab-badge-friendly">Friendly message</span></div>',
'<p><code>ck_elab_orders_quantity</code> has a message in <code>ersh_constraint_lookup</code>.</p>',
'<p class="ersh-lab-note">ErrorShield shows the registered message. Nothing is recorded.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24866554312638802)
,p_plug_name=>'Delete a customer with orders'
,p_static_id=>'childFoundSR'
,p_region_name=>'childFoundSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-02292</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p>The same unregistered foreign key, hit from the parent side.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(24866924654638804)
,p_name=>'Incidents From This Lesson'
,p_static_id=>'incidentsCR'
,p_region_name=>'incidentsCR'
,p_template=>4073835273271169698
,p_display_sequence=>110
,p_icon_css_classes=>'fa-list-alt'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.component_name                                             as component_name',
'     , i.ora_sqlcode                                                as ora_sqlcode',
'     , i.error_summary                                              as error_summary',
'     , i.occurrence_count                                           as occurrence_count',
'     , to_char(i.created_on, ''DD-MON HH24:MI:SS'')                   as first_seen',
'  from ersh_shield_incidents_vw i',
' where i.application_id = :APP_ID',
'   and i.page_id        = :APP_PAGE_ID',
' order by i.created_on desc',
' fetch first 10 rows only'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No incidents from this lesson yet. Raise one of the errors above.'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24867019007638804)
,p_query_column_id=>1
,p_column_alias=>'COMPONENT_NAME'
,p_column_display_sequence=>10
,p_column_heading=>'Component'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24867112580638804)
,p_query_column_id=>3
,p_column_alias=>'ERROR_SUMMARY'
,p_column_display_sequence=>30
,p_column_heading=>'Error Summary (admin only)'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24867203469638804)
,p_query_column_id=>5
,p_column_alias=>'FIRST_SEEN'
,p_column_display_sequence=>50
,p_column_heading=>'First Seen'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24867321799638804)
,p_query_column_id=>4
,p_column_alias=>'OCCURRENCE_COUNT'
,p_column_display_sequence=>40
,p_column_heading=>'Hits'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24867482566638805)
,p_query_column_id=>2
,p_column_alias=>'ORA_SQLCODE'
,p_column_display_sequence=>20
,p_column_heading=>'SQLCODE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24865925804638748)
,p_plug_name=>unistr('Lesson 2 \00B7 Table and Column Errors')
,p_static_id=>'introSR'
,p_region_name=>'introSR'
,p_icon_css_classes=>'fa-table'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675494171183407654
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The table itself refuses the data: sizes, data types, required columns and constraints. Whether',
'the user gets a friendly message depends on one thing: is the constraint registered in',
'<code>ersh_constraint_lookup</code>?</p>',
'<p class="ersh-lab-note">Watch for: the same kind of error (a constraint) ends up masked and recorded,',
'or friendly and unrecorded, only because of that registration.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24867598500638805)
,p_plug_name=>'Lesson Navigation'
,p_static_id=>'lessonNavSR'
,p_region_name=>'lessonNavSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>120
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24866378356638802)
,p_plug_name=>'Required column left empty'
,p_static_id=>'notNullSR'
,p_region_name=>'notNullSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-01400</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p>A customer inserted without its mandatory name.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24866218222638801)
,p_plug_name=>'Number too large for the column'
,p_static_id=>'numericOverflowSR'
,p_region_name=>'numericOverflowSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-01438</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p>Quantity 1,000,000 into <code>quantity number(5)</code>.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24866429245638802)
,p_plug_name=>'Order for a missing customer'
,p_static_id=>'parentNotFoundSR'
,p_region_name=>'parentNotFoundSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>60
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-02291</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p>Foreign key <code>fk_elab_orders_customers</code>, deliberately not registered.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24866686893638803)
,p_plug_name=>'Registered: Friendly Message'
,p_static_id=>'registeredSR'
,p_region_name=>'registeredSR'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h3'
,p_plug_template=>2323592004483952560
,p_plug_display_sequence=>80
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Registered with <code>ersh_error_handler_api.merge_ersh_constraint_lookup</code> by the lab''s seed',
'script. The user can fix these, so they are shown, not recorded.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24866793616638803)
,p_plug_name=>'Duplicate customer code'
,p_static_id=>'uniqueViolationSR'
,p_region_name=>'uniqueViolationSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>90
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-00001</span><span class="ersh-lab-badge ersh-lab-badge-friendly">Friendly message</span></div>',
'<p><code>uk_elab_customers_code</code> has a message in <code>ersh_constraint_lookup</code>.</p>',
'<p class="ersh-lab-note">ErrorShield shows the registered message. Nothing is recorded.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24866094465638748)
,p_plug_name=>'Not Registered: Masked and Recorded'
,p_static_id=>'unregisteredSR'
,p_region_name=>'unregisteredSR'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h3'
,p_plug_template=>2323592004483952560
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>'<p>Nothing tells ErrorShield these are expected, so they take the unexpected-error path.</p>'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24866140702638801)
,p_plug_name=>'Text too long for the column'
,p_static_id=>'valueTooLargeSR'
,p_region_name=>'valueTooLargeSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-12899</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p>A 47-character name into <code>customer_name varchar2(30 char)</code>.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24868273625638806)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24866879761638803)
,p_button_name=>'CHECK_VIOLATION'
,p_static_id=>'CHECK_VIOLATION'
,p_button_static_id=>'CHECK_VIOLATION'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24868097205638806)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24866554312638802)
,p_button_name=>'CHILD_FOUND'
,p_static_id=>'CHILD_FOUND'
,p_button_static_id=>'CHILD_FOUND'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24868590010638806)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(24867598500638805)
,p_button_name=>'NEXT_LESSON'
,p_static_id=>'NEXT_LESSON'
,p_button_static_id=>'NEXT_LESSON'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2084305881903810008
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Lesson 3: AJAX Errors'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-right'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24867848380638805)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24866378356638802)
,p_button_name=>'NOT_NULL'
,p_static_id=>'NOT_NULL'
,p_button_static_id=>'NOT_NULL'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24867746431638805)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24866218222638801)
,p_button_name=>'NUMERIC_OVERFLOW'
,p_static_id=>'NUMERIC_OVERFLOW'
,p_button_static_id=>'NUMERIC_OVERFLOW'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24867963386638806)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24866429245638802)
,p_button_name=>'PARENT_NOT_FOUND'
,p_static_id=>'PARENT_NOT_FOUND'
,p_button_static_id=>'PARENT_NOT_FOUND'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24868453671638806)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24867598500638805)
,p_button_name=>'PREVIOUS_LESSON'
,p_static_id=>'PREVIOUS_LESSON'
,p_button_static_id=>'PREVIOUS_LESSON'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Lesson 1: PL/SQL Runtime Errors'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-left'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24868310731638806)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24866924654638804)
,p_button_name=>'REFRESH'
,p_static_id=>'REFRESH'
,p_button_static_id=>'REFRESH'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Refresh'
,p_button_position=>'EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24868132785638806)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24866793616638803)
,p_button_name=>'UNIQUE_VIOLATION'
,p_static_id=>'UNIQUE_VIOLATION'
,p_button_static_id=>'UNIQUE_VIOLATION'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24867691758638805)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24866140702638801)
,p_button_name=>'VALUE_TOO_LARGE'
,p_static_id=>'VALUE_TOO_LARGE'
,p_button_static_id=>'VALUE_TOO_LARGE'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(24868625574638807)
,p_name=>'Refresh Incidents'
,p_static_id=>'refresh-click'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(24868310731638806)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24868712276638807)
,p_event_id=>wwv_flow_imp.id(24868625574638807)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'refresh-incidents'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(24866924654638804)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24869491421638808)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Quantity of zero (ORA-02290)'
,p_static_id=>'check-violation'
,p_process_sql_clob=>'elab_errors_api.force_check_violation;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''CHECK_VIOLATION'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24869491421638808
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24869210077638807)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete a customer with orders (ORA-02292)'
,p_static_id=>'child-found'
,p_process_sql_clob=>'elab_errors_api.force_child_found;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''CHILD_FOUND'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24869210077638807
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24869058473638807)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Required column left empty (ORA-01400)'
,p_static_id=>'not-null'
,p_process_sql_clob=>'elab_errors_api.force_not_null;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''NOT_NULL'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24869058473638807
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24868973556638807)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Number too large for the column (ORA-01438)'
,p_static_id=>'numeric-overflow'
,p_process_sql_clob=>'elab_errors_api.force_numeric_overflow;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''NUMERIC_OVERFLOW'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24868973556638807
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24869103377638807)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Order for a missing customer (ORA-02291)'
,p_static_id=>'parent-not-found'
,p_process_sql_clob=>'elab_errors_api.force_parent_not_found;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''PARENT_NOT_FOUND'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24869103377638807
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24869347851638808)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Duplicate customer code (ORA-00001)'
,p_static_id=>'unique-violation'
,p_process_sql_clob=>'elab_errors_api.force_unique_violation;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''UNIQUE_VIOLATION'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24869347851638808
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24868879162638807)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Text too long for the column (ORA-12899)'
,p_static_id=>'value-too-large'
,p_process_sql_clob=>'elab_errors_api.force_value_too_large;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''VALUE_TOO_LARGE'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24868879162638807
);
end;
/
prompt --application/pages/page_00300
begin
wwv_flow_imp_page.create_page(
 p_id=>300
,p_name=>'AJAX Errors'
,p_alias=>'AJAX-ERRORS'
,p_step_title=>'AJAX Errors'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var elab = elab || {};',
'',
'elab.errorLab = (function(namespace, $, undefined) {',
'  ''use strict'';',
'',
'  var MODULE_NAME = ''ErrorLab'';',
'',
'  var CONFIG = {',
'      AJAX_UNHANDLED: ''FORCE_AJAX_UNHANDLED''',
'    , AJAX_HANDLED: ''FORCE_AJAX_HANDLED''',
'    , SCENARIO_ITEM: ''P300_SCENARIO''',
'    , INCIDENTS_REGION: ''incidentsCR''',
'  };',
'',
'  var _PREFIX = ''['' + MODULE_NAME + '']'';',
'  var logger = {',
'      log:     function(msg, data) { console.log(_PREFIX, msg, data || ''''); }',
'    , warning: function(msg, data) { console.warn(_PREFIX, msg, data || ''''); }',
'    , error:   function(msg, data) { console.error(_PREFIX, msg, data || ''''); }',
'  };',
'',
'  /**',
'   * Show one error in the page notification area, replacing any previous one',
'   * @param {string} message - Text to show (escaped, never rendered as HTML)',
'   */',
'  var _showError = function(message) {',
'    apex.message.clearErrors();',
'    apex.message.showErrors([{',
'        type: ''error''',
'      , location: ''page''',
'      , message: message',
'      , unsafe: false',
'    }]);',
'  };',
'',
'  /**',
'   * Read the scenario picked in step 1',
'   * @returns {string} - elab_errors_api.force_error scenario code',
'   */',
'  var _scenario = function() {',
'    return apex.item(CONFIG.SCENARIO_ITEM).getValue();',
'  };',
'',
'  /**',
'   * Refresh the incidents report so a new incident shows up at once',
'   */',
'  var refreshIncidents = function() {',
'    apex.region(CONFIG.INCIDENTS_REGION).refresh();',
'  };',
'',
'  /**',
'   * Call an AJAX callback that lets its exception escape. APEX routes it',
'   * through the app''s Error Handling Function (ErrorShield) on its own and',
'   * answers with the translated message as an error response.',
'   */',
'  var fireUnhandled = function() {',
'    apex.server.process(',
'      CONFIG.AJAX_UNHANDLED,',
'      { x01: _scenario() },',
'      {',
'        success: function(pData) {',
'          logger.warning(''Callback unexpectedly succeeded'', pData);',
'        },',
'        error: function(jqXHR, textStatus, errorThrown) {',
'          logger.error(''AJAX request failed'', {status: textStatus, error: errorThrown});',
'          _showError(errorThrown || textStatus);',
'          refreshIncidents();',
'        }',
'      }',
'    );',
'  };',
'',
'  /**',
'   * Call an AJAX callback that catches its own exception and answers',
'   * success: false plus a sanitized message (apex-ux.md section 2).',
'   */',
'  var fireHandled = function() {',
'    apex.server.process(',
'      CONFIG.AJAX_HANDLED,',
'      { x01: _scenario() },',
'      {',
'        success: function(pData) {',
'          if (pData.success) {',
'            logger.warning(''Callback unexpectedly succeeded'', pData);',
'          } else {',
'            logger.error(''Server returned error'', {error: pData.message});',
'            _showError(pData.message);',
'            refreshIncidents();',
'          }',
'        },',
'        error: function(jqXHR, textStatus, errorThrown) {',
'          logger.error(''AJAX request failed'', {status: textStatus, error: errorThrown});',
'          _showError(errorThrown || textStatus);',
'        }',
'      }',
'    );',
'  };',
'',
'  return {',
'      fireUnhandled: fireUnhandled',
'    , fireHandled: fireHandled',
'    , refreshIncidents: refreshIncidents',
'  };',
'',
'})(elab, apex.jQuery);'))
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24869870024638810)
,p_plug_name=>unistr('Step 2 \00B7 Send It Through a Channel')
,p_static_id=>'channelsSR'
,p_region_name=>'channelsSR'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h3'
,p_plug_template=>2323592004483952560
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>'<p>The outcome follows the scenario: friendly and business errors still record nothing.</p>'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24870087988638811)
,p_plug_name=>'Dynamic Action'
,p_static_id=>'dynamicActionSR'
,p_region_name=>'dynamicActionSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">Execute Server-side Code</span></div>',
'<p>The same path through a declarative Dynamic Action. APEX shows the message in the notification area on its own.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24870101771638811)
,p_plug_name=>'Callback, handled'
,p_static_id=>'handledSR'
,p_region_name=>'handledSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>60
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">success: false</span></div>',
'<p>The callback catches the exception and answers JSON. It logs and records the incident itself, then returns a sanitized message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(24870229060638811)
,p_name=>'Incidents From This Lesson'
,p_static_id=>'incidentsCR'
,p_region_name=>'incidentsCR'
,p_template=>4073835273271169698
,p_display_sequence=>70
,p_icon_css_classes=>'fa-list-alt'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.component_name                                             as component_name',
'     , i.ora_sqlcode                                                as ora_sqlcode',
'     , i.error_summary                                              as error_summary',
'     , i.occurrence_count                                           as occurrence_count',
'     , to_char(i.created_on, ''DD-MON HH24:MI:SS'')                   as first_seen',
'  from ersh_shield_incidents_vw i',
' where i.application_id = :APP_ID',
'   and i.page_id        = :APP_PAGE_ID',
' order by i.created_on desc',
' fetch first 10 rows only'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No incidents from this lesson yet. Raise one of the errors above.'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24870355317638812)
,p_query_column_id=>1
,p_column_alias=>'COMPONENT_NAME'
,p_column_display_sequence=>10
,p_column_heading=>'Component'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24870476690638812)
,p_query_column_id=>3
,p_column_alias=>'ERROR_SUMMARY'
,p_column_display_sequence=>30
,p_column_heading=>'Error Summary (admin only)'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24870509631638812)
,p_query_column_id=>5
,p_column_alias=>'FIRST_SEEN'
,p_column_display_sequence=>50
,p_column_heading=>'First Seen'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24870640176638812)
,p_query_column_id=>4
,p_column_alias=>'OCCURRENCE_COUNT'
,p_column_display_sequence=>40
,p_column_heading=>'Hits'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24870774437638812)
,p_query_column_id=>2
,p_column_alias=>'ORA_SQLCODE'
,p_column_display_sequence=>20
,p_column_heading=>'SQLCODE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24869606637638809)
,p_plug_name=>unistr('Lesson 3 \00B7 AJAX Errors')
,p_static_id=>'introSR'
,p_region_name=>'introSR'
,p_icon_css_classes=>'fa-exchange'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675494171183407654
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The same failures, raised without a page submit. Pick a scenario, then send it through each of',
'the three ways an APEX page talks to the server in the background.</p>',
'<p class="ersh-lab-note">Watch for: the third channel catches its own exception, so the Error',
'Handling Function never sees it. The callback has to record the incident itself.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24870804961638812)
,p_plug_name=>'Lesson Navigation'
,p_static_id=>'lessonNavSR'
,p_region_name=>'lessonNavSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>80
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24869784223638810)
,p_plug_name=>unistr('Step 1 \00B7 Pick a Scenario')
,p_static_id=>'scenarioSR'
,p_region_name=>'scenarioSR'
,p_icon_css_classes=>'fa-list-ul'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24869928559638810)
,p_plug_name=>'Callback, unhandled'
,p_static_id=>'unhandledSR'
,p_region_name=>'unhandledSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>40
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">apex.server.process</span></div>',
'<p>The callback lets the exception escape. APEX hands it to ErrorShield by itself and sends the translated message back to the browser.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24871107128638815)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24870087988638811)
,p_button_name=>'AJAX_DA'
,p_static_id=>'AJAX_DA'
,p_button_static_id=>'AJAX_DA'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Send'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-paper-plane-o'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24871292431638815)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24870101771638811)
,p_button_name=>'AJAX_HANDLED'
,p_static_id=>'AJAX_HANDLED'
,p_button_static_id=>'AJAX_HANDLED'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Send'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-paper-plane-o'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24871058619638815)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24869928559638810)
,p_button_name=>'AJAX_UNHANDLED'
,p_static_id=>'AJAX_UNHANDLED'
,p_button_static_id=>'AJAX_UNHANDLED'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Send'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-paper-plane-o'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24871523422638816)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(24870804961638812)
,p_button_name=>'NEXT_LESSON'
,p_static_id=>'NEXT_LESSON'
,p_button_static_id=>'NEXT_LESSON'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2084305881903810008
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Lesson 4: Rendering and Business Errors'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:400:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-right'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24871436851638816)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24870804961638812)
,p_button_name=>'PREVIOUS_LESSON'
,p_static_id=>'PREVIOUS_LESSON'
,p_button_static_id=>'PREVIOUS_LESSON'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Lesson 2: Table and Column Errors'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:200:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-left'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24871362129638816)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24870229060638811)
,p_button_name=>'REFRESH'
,p_static_id=>'REFRESH'
,p_button_static_id=>'REFRESH'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Refresh'
,p_button_position=>'EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(24870963096638813)
,p_name=>'P300_SCENARIO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(24869784223638810)
,p_prompt=>'Scenario'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ELAB_SCENARIOS'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(24872025304638817)
,p_name=>'AJAX Dynamic Action Error'
,p_static_id=>'ajax-da-click'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(24871107128638815)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24872102269638817)
,p_event_id=>wwv_flow_imp.id(24872025304638817)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'force-error-server-side'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'items_to_submit', 'P300_SCENARIO',
  'language', 'PLSQL',
  'plsql_code', wwv_flow_string.join(wwv_flow_t_varchar2(
    'elab_errors_api.force_error(',
    '    p_scenario                       => :P300_SCENARIO',
    ');')),
  'show_processing', 'N')).to_clob
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(24872264120638817)
,p_name=>'AJAX Handled Error'
,p_static_id=>'ajax-handled-click'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(24871292431638815)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24872378378638817)
,p_event_id=>wwv_flow_imp.id(24872264120638817)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'fire-handled'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'js_code', 'elab.errorLab.fireHandled();')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(24871821638638816)
,p_name=>'AJAX Unhandled Error'
,p_static_id=>'ajax-unhandled-click'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(24871058619638815)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24871904277638817)
,p_event_id=>wwv_flow_imp.id(24871821638638816)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'fire-unhandled'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'js_code', 'elab.errorLab.fireUnhandled();')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(24871676580638816)
,p_name=>'Refresh Incidents'
,p_static_id=>'refresh-click'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(24871362129638816)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24871794477638816)
,p_event_id=>wwv_flow_imp.id(24871676580638816)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'refresh-incidents'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(24870229060638811)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24872507162638817)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'FORCE_AJAX_HANDLED'
,p_static_id=>'force-ajax-handled'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_ora_sqlcode   number;',
'  l_error_message varchar2(4000 char);',
'  l_reference_id  number;',
'  l_incident_id   ersh_shield_incidents.shield_incident_id%type;',
'begin',
'  elab_errors_api.force_error(',
'      p_scenario                       => apex_application.g_x01',
'  );',
'',
'  apex_json.open_object;',
'  apex_json.write(''success'', true);',
'  apex_json.close_object;',
'exception',
'  when others then',
'    l_ora_sqlcode   := sqlcode;',
'    l_error_message := sqlerrm;',
'',
'    if l_ora_sqlcode between -20999 and -20000 then',
'      -- Intentional business error: same treatment as ErrorShield gives it,',
'      -- show the message as written and record nothing.',
'      apex_json.open_object;',
'      apex_json.write(''success'', false);',
'      apex_json.write(''message'', regexp_replace(l_error_message, ''^ORA-\d{5}: ''));',
'      apex_json.close_object;',
'    else',
'      -- The Error Handling Function never sees a caught exception, so this',
'      -- callback logs and records the incident itself. Observability never',
'      -- escalates: a failure here must not hide the JSON answer.',
'      begin',
'        l_reference_id := logger.log_error(',
'            p_text                       => ''Handled AJAX error: '' || l_error_message',
'          , p_scope                      => ''error_lab.force_ajax_handled''',
'        );',
'',
'        ersh_error_handler_api.record_internal_incident(',
'            p_workspace_id               => apex_application.get_security_group_id',
'          , p_application_id             => apex_application.g_flow_id',
'          , p_page_id                    => apex_application.g_flow_step_id',
'          , p_app_user                   => apex_application.g_user',
'          , p_request                    => apex_application.g_request',
'          , p_component_type             => ''APEX_APPLICATION_PAGE_PROCESSES''',
'          , p_component_name             => ''FORCE_AJAX_HANDLED''',
'          , p_ora_sqlcode                => l_ora_sqlcode',
'          , p_error_message              => l_error_message',
'          , p_logger_log_id              => l_reference_id',
'          , o_incident_id                => l_incident_id',
'        );',
'      exception',
'        when others then',
'          null;',
'      end;',
'',
'      apex_json.open_object;',
'      apex_json.write(''success'', false);',
'      apex_json.write(''message'', ''Unable to process this request. Reference: '' || nvl(to_char(l_reference_id), ''n/a'') || ''.'');',
'      apex_json.close_object;',
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>24872507162638817
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24872468227638817)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'FORCE_AJAX_UNHANDLED'
,p_static_id=>'force-ajax-unhandled'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'elab_errors_api.force_error(',
'    p_scenario                       => apex_application.g_x01',
');'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>24872468227638817
);
end;
/
prompt --application/pages/page_00400
begin
wwv_flow_imp_page.create_page(
 p_id=>400
,p_name=>'Rendering and Business Errors'
,p_alias=>'RENDERING-AND-BUSINESS-ERRORS'
,p_step_title=>'Rendering and Business Errors'
,p_autocomplete_on_off=>'ON'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24873096332638819)
,p_plug_name=>'Broken Region'
,p_static_id=>'brokenDC'
,p_region_name=>'brokenDC'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>40
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_count pls_integer;',
'begin',
'  -- The table name lives in a string so the app compiles; the parse',
'  -- error only happens when APEX renders this region, like a report',
'  -- whose table was dropped after deployment. (A literal query on a',
'  -- missing table makes apex validate/import hang ~16 minutes.)',
'  execute immediate ''select count(1) from elab_this_table_does_not_exist''',
'     into l_count;',
'',
'  return to_char(l_count);',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>':REQUEST = ''FORCE_INTERNAL'''
,p_plug_display_when_cond2=>'PLSQL'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24872991236638819)
,p_plug_name=>'Order over the credit limit'
,p_static_id=>'businessSR'
,p_region_name=>'businessSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-20000</span><span class="ersh-lab-badge ersh-lab-badge-friendly">Friendly message</span></div>',
'<p><code>ersh_error_handler_api.raise_custom_error</code> with the registered code <code>ELAB_CREDIT_LIMIT_EXCEEDED</code>.</p>',
'<p class="ersh-lab-note">ErrorShield shows the message as written. Nothing is recorded.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(24873117900638819)
,p_name=>'Incidents From This Lesson'
,p_static_id=>'incidentsCR'
,p_region_name=>'incidentsCR'
,p_template=>4073835273271169698
,p_display_sequence=>50
,p_icon_css_classes=>'fa-list-alt'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.component_name                                             as component_name',
'     , i.ora_sqlcode                                                as ora_sqlcode',
'     , i.error_summary                                              as error_summary',
'     , i.occurrence_count                                           as occurrence_count',
'     , to_char(i.created_on, ''DD-MON HH24:MI:SS'')                   as first_seen',
'  from ersh_shield_incidents_vw i',
' where i.application_id = :APP_ID',
'   and i.page_id        = :APP_PAGE_ID',
' order by i.created_on desc',
' fetch first 10 rows only'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No incidents from this lesson yet. Raise one of the errors above.'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24873252011638820)
,p_query_column_id=>1
,p_column_alias=>'COMPONENT_NAME'
,p_column_display_sequence=>10
,p_column_heading=>'Component'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24873324397638820)
,p_query_column_id=>3
,p_column_alias=>'ERROR_SUMMARY'
,p_column_display_sequence=>30
,p_column_heading=>'Error Summary (admin only)'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24873492412638820)
,p_query_column_id=>5
,p_column_alias=>'FIRST_SEEN'
,p_column_display_sequence=>50
,p_column_heading=>'First Seen'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24873520420638820)
,p_query_column_id=>4
,p_column_alias=>'OCCURRENCE_COUNT'
,p_column_display_sequence=>40
,p_column_heading=>'Hits'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(24873642288638820)
,p_query_column_id=>2
,p_column_alias=>'ORA_SQLCODE'
,p_column_display_sequence=>20
,p_column_heading=>'SQLCODE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24872712200638818)
,p_plug_name=>unistr('Lesson 4 \00B7 Rendering and Business Errors')
,p_static_id=>'introSR'
,p_region_name=>'introSR'
,p_icon_css_classes=>'fa-bug'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675494171183407654
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Errors raised while APEX draws the page, and errors your own code raises on purpose. The first',
'is a bug nobody should see; the second is a business rule the user needs to read.</p>',
'<p class="ersh-lab-note">Watch for: only the first one appears in the incidents report.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24873794986638820)
,p_plug_name=>'Lesson Navigation'
,p_static_id=>'lessonNavSR'
,p_region_name=>'lessonNavSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>60
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24872839062638818)
,p_plug_name=>'Region fails while rendering'
,p_static_id=>'renderingSR'
,p_region_name=>'renderingSR'
,p_region_css_classes=>'ersh-lab-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="ersh-lab-badges"><span class="ersh-lab-badge ersh-lab-badge-code">ORA-00942</span><span class="ersh-lab-badge ersh-lab-badge-incident">Incident</span></div>',
'<p>Reloads this page with a region whose query targets a table that no longer exists, like a report after a bad deployment.</p>',
'<p class="ersh-lab-note">ErrorShield logs it, records an incident and masks the message.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24873956973638821)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24872991236638819)
,p_button_name=>'BUSINESS_ERROR'
,p_static_id=>'BUSINESS_ERROR'
,p_button_static_id=>'BUSINESS_ERROR'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24873873842638821)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24872839062638818)
,p_button_name=>'FORCE_INTERNAL'
,p_static_id=>'FORCE_INTERNAL'
,p_button_static_id=>'FORCE_INTERNAL'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Raise error'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:400:&SESSION.:FORCE_INTERNAL:&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-bolt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24874229999638838)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(24873794986638820)
,p_button_name=>'NEXT_LESSON'
,p_static_id=>'NEXT_LESSON'
,p_button_static_id=>'NEXT_LESSON'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>2084305881903810008
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Back to Overview'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-right'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24874133969638838)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24873794986638820)
,p_button_name=>'PREVIOUS_LESSON'
,p_static_id=>'PREVIOUS_LESSON'
,p_button_static_id=>'PREVIOUS_LESSON'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Lesson 3: AJAX Errors'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-left'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(24874079143638838)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(24873117900638819)
,p_button_name=>'REFRESH'
,p_static_id=>'REFRESH'
,p_button_static_id=>'REFRESH'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Refresh'
,p_button_position=>'EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(24874316529638838)
,p_name=>'Refresh Incidents'
,p_static_id=>'refresh-click'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(24874079143638838)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24874491065638839)
,p_event_id=>wwv_flow_imp.id(24874316529638838)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'refresh-incidents'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(24873117900638819)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24874507567638839)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Order over the credit limit (ORA-20000)'
,p_static_id=>'business-error'
,p_process_sql_clob=>'elab_errors_api.force_business_error;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''BUSINESS_ERROR'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>24874507567638839
);
end;
/
prompt --application/pages/page_09999
begin
wwv_flow_imp_page.create_page(
 p_id=>9999
,p_name=>'Login Page'
,p_alias=>'LOGIN'
,p_step_title=>'&APP_NAME. - Log In'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2102634289808461002
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(23884209292209953)
,p_plug_name=>'&APP_NAME.'
,p_static_id=>'app-name'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675634334296186762
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23884627623209954)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(23884209292209953)
,p_button_name=>'LOGIN'
,p_static_id=>'login'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Sign In'
,p_button_position=>'NEXT'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(23884307540209954)
,p_name=>'P9999_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(23884209292209953)
,p_prompt=>'Password'
,p_placeholder=>'Password'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_tag_attributes=>'autocomplete="current-password"'
,p_label_alignment=>'RIGHT'
,p_field_template=>2042262243893469891
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(23884484098209954)
,p_name=>'P9999_REMEMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(23884209292209953)
,p_prompt=>'Remember username'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_label_alignment=>'RIGHT'
,p_display_when=>'apex_authentication.persistent_cookies_enabled'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>2042262243893469891
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(23884565432209954)
,p_name=>'P9999_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(23884209292209953)
,p_prompt=>'Username'
,p_placeholder=>'Username'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_tag_attributes=>'autocomplete="username"'
,p_label_alignment=>'RIGHT'
,p_field_template=>2042262243893469891
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23884789470209955)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_static_id=>'clear-page-s-cache'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'type', 'CLEAR_CACHE_CURRENT_PAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3073906448829089
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23884851198209955)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_static_id=>'get-username-cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P9999_USERNAME := apex_authentication.get_login_username_cookie;',
':P9999_REMEMBER := case when :P9999_USERNAME is not null then ''Y'' end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>3073526297829089
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23884905461209955)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_INVOKE_API'
,p_process_name=>'Login'
,p_static_id=>'login'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'package', 'APEX_AUTHENTICATION',
  'package_method', 'LOGIN',
  'type', 'PLSQL_PACKAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3070275942829086
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(23885027783209955)
,p_page_process_id=>wwv_flow_imp.id(23884905461209955)
,p_page_id=>9999
,p_name=>'p_password'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>2
,p_value_type=>'ITEM'
,p_value=>'P9999_PASSWORD'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(23885146559209955)
,p_page_process_id=>wwv_flow_imp.id(23884905461209955)
,p_page_id=>9999
,p_name=>'p_set_persistent_auth'
,p_direction=>'IN'
,p_data_type=>'BOOLEAN'
,p_has_default=>true
,p_display_sequence=>3
,p_value_type=>'API_DEFAULT'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(23885209316209955)
,p_page_process_id=>wwv_flow_imp.id(23884905461209955)
,p_page_id=>9999
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>1
,p_value_type=>'ITEM'
,p_value=>'P9999_USERNAME'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23885357869209955)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_INVOKE_API'
,p_process_name=>'Set Username Cookie'
,p_static_id=>'set-username-cookie'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'package', 'APEX_AUTHENTICATION',
  'package_method', 'SEND_LOGIN_USERNAME_COOKIE',
  'type', 'PLSQL_PACKAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3072157592829088
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(23885448837209955)
,p_page_process_id=>wwv_flow_imp.id(23885357869209955)
,p_page_id=>9999
,p_name=>'p_consent'
,p_direction=>'IN'
,p_data_type=>'BOOLEAN'
,p_has_default=>false
,p_display_sequence=>2
,p_value_type=>'ITEM'
,p_value=>'P9999_REMEMBER'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(23885568855209956)
,p_page_process_id=>wwv_flow_imp.id(23885357869209955)
,p_page_id=>9999
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>1
,p_value_type=>'EXPRESSION'
,p_value_language=>'PLSQL'
,p_value=>'lower( :P9999_USERNAME )'
);
end;
/
prompt --application/deployment/definition
begin
null;
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
