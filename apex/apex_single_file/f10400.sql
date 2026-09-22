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
,p_release=>'26.1.4'
,p_default_workspace_id=>15633453762491019
,p_default_application_id=>10400
,p_default_id_offset=>0
,p_default_owner=>'LOGGER_USER'
);
end;
/
 
prompt APPLICATION 10400 - Error Shield
--
-- Application Export:
--   Application:     10400
--   Name:            Error Shield
--   Date and Time:   20:13 Tuesday September 22, 2026
--   Exported By:     LOGGER_USER
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     20
--       Items:                   55
--       Validations:              1
--       Processes:               17
--       Regions:                 42
--       Buttons:                 16
--       Dynamic Actions:          1
--     Shared Components:
--       Logic:
--         Build Options:          3
--       Navigation:
--         Lists:                  3
--         Breadcrumbs:            1
--           Entries:             11
--       Security:
--         Authentication:         1
--         Authorization:          1
--       User Interface:
--         Themes:                 1
--         Templates:
--         LOVs:                   4
--       PWA:
--       Globalization:
--       Reports:
--       E-Mail:
--     Supporting Objects:  Included
--   Version:         26.1.4
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
,p_owner=>nvl(wwv_flow_application_install.get_schema,'LOGGER_USER')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Error Shield')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'ERROR-SHIELD')
,p_application_group=>wwv_flow_imp.id(367853243872100598)
,p_application_group_name=>'CapWorks'
,p_application_group_static_id=>'capworks'
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'440E012DBECC62720B78F9121E12379314EE6D7B50B595D3B6101B5165649410'
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
,p_authentication_id=>wwv_flow_imp.id(381905898510018348)
,p_application_tab_set=>1
,p_logo_type=>'T'
,p_logo_text=>'Error Shield'
,p_app_builder_icon_name=>'app-icon.svg'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_runtime_api_usage=>'T'
,p_pass_ecid=>'N'
,p_authorize_batch_job=>'N'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_error_handling_function=>'ersh_error_handler_api.apex_error_handling'
,p_tokenize_row_search=>'N'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'Error Shield'
,p_file_prefix=>nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>2461306201328
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
,p_navigation_list_id=>wwv_flow_imp.id(381906604775018353)
,p_navigation_list_position=>'TOP'
,p_navigation_list_template_id=>2528231041045349458
,p_nav_list_template_options=>'#DEFAULT#'
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APP_FILES#app-icon.css?version=#APP_VERSION#',
'#APP_FILES#app.css?version=#APP_VERSION#'))
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_imp.id(382093913629018484)
,p_nav_bar_list_template_id=>2849019392706229583
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
prompt --application/plugin_settings
begin
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(16838085899911377)
,p_plugin_type=>'DYNAMIC ACTION'
,p_plugin=>'NATIVE_OPEN_AI_ASSISTANT'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(381904952928018345)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'mode', 'FULL')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(16838271858911378)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_DATE_PICKER_APEX'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'show_on', 'FOCUS',
  'time_increment', '15')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(381902817989018343)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_GEOCODED_ADDRESS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'background', 'default',
  'display_as', 'LIST',
  'map_preview', 'POPUP:ITEM',
  'match_mode', 'RELAX_HOUSE_NUMBER')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(16838743222911381)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SELECT_MANY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_values_as', 'separated')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(381904063846018345)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'checked_value', 'Y',
  'unchecked_value', 'N')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(381904339597018345)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'default_icon', 'fa-star',
  'tooltip', '#VALUE#')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(381903798945018345)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_style', 'SWITCH_CB',
  'off_value', 'N',
  'on_value', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(16838899537911381)
,p_plugin_type=>'PROCESS TYPE'
,p_plugin=>'NATIVE_GEOCODING'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'match_mode', 'RELAX_HOUSE_NUMBER')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(381902585610018343)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'include_slider', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(381905251126018345)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'actions_menu_structure', 'IG')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(16839074903911382)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_MAP_REGION'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_vector_tile_layers', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(16839358301911383)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_ADFBC'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(16839256267911383)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_BOSS'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_bar
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(382093913629018484)
,p_name=>'Navigation Bar'
,p_static_id=>'navigation-bar'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382112326251018562)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'About'
,p_static_id=>'about'
,p_list_item_icon=>'fa-question-circle-o'
,p_list_text_02=>'icon-only'
,p_required_patch=>wwv_flow_imp.id(382096455746018510)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382113689630018564)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'About Page'
,p_static_id=>'about-page'
,p_list_item_link_target=>'f?p=&APP_ID.:10020:&SESSION.::&DEBUG.:10020'
,p_list_item_icon=>'fa-info-circle-o'
,p_parent_list_item_id=>wwv_flow_imp.id(382112326251018562)
,p_required_patch=>wwv_flow_imp.id(382096455746018510)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382113950109018564)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'&APP_USER.'
,p_static_id=>'app-user'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382113212994018564)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'---'
,p_static_id=>'list_item'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_imp.id(382112326251018562)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382114439899018564)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'---'
,p_static_id=>'list_item-2'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_imp.id(382113950109018564)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382112878124018564)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Page Help'
,p_static_id=>'page-help'
,p_list_item_link_target=>'f?p=&APP_ID.:10021:&SESSION.::&DEBUG.::P10021_PAGE_ID:&APP_PAGE_ID.'
,p_list_item_icon=>'fa-question-circle-o'
,p_parent_list_item_id=>wwv_flow_imp.id(382112326251018562)
,p_list_text_02=>'icon-only'
,p_required_patch=>wwv_flow_imp.id(382096455746018510)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382114886446018564)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'Sign Out'
,p_static_id=>'sign-out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_parent_list_item_id=>wwv_flow_imp.id(382113950109018564)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_menu
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(381906604775018353)
,p_name=>'Navigation Menu'
,p_static_id=>'navigation-menu'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382115413880018564)
,p_list_item_display_sequence=>10000
,p_list_item_link_text=>'Administration'
,p_static_id=>'administration'
,p_list_item_link_target=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.'
,p_list_item_icon=>'fa-user-wrench'
,p_security_scheme=>wwv_flow_imp.id(382097282347018512)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(428265892990285620)
,p_list_item_display_sequence=>120
,p_list_item_link_text=>'APEX automations'
,p_static_id=>'apex-automations'
,p_list_item_link_target=>'f?p=&APP_ID.:1600:&SESSION.::&DEBUG.'
,p_parent_list_item_id=>wwv_flow_imp.id(422972072521875614)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1600'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382142791505074935)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Application Preferences'
,p_static_id=>'error-shield-preferences'
,p_list_item_link_target=>'f?p=&APP_ID.:200:&SESSION.::&DEBUG.'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'200,210'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382103000798018532)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Home'
,p_static_id=>'home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382121027853033209)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Incidents'
,p_static_id=>'incidents'
,p_list_item_link_target=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'100'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(422974412459897995)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'Inventory'
,p_static_id=>'inventory'
,p_list_item_link_target=>'f?p=&APP_ID.:1100:&SESSION.::&DEBUG.'
,p_parent_list_item_id=>wwv_flow_imp.id(422972072521875614)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1100'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(422987381778905196)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'Job - Details'
,p_static_id=>'job-details'
,p_list_item_link_target=>'f?p=&APP_ID.:1200:&SESSION.::&DEBUG.'
,p_list_item_disp_cond_type=>'NEVER'
,p_parent_list_item_id=>wwv_flow_imp.id(422972072521875614)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1200'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(423003296884911410)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'Job-Executions'
,p_static_id=>'job-executions'
,p_list_item_link_target=>'f?p=&APP_ID.:1300:&SESSION.::&DEBUG.'
,p_parent_list_item_id=>wwv_flow_imp.id(422972072521875614)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1300'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(422972072521875614)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Jobs - dashboard'
,p_static_id=>'jobs-dashboard'
,p_list_item_link_target=>'f?p=&APP_ID.:1000:&SESSION.::&DEBUG.'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1000,1100,1200,1300,1400,1500,1600'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382489367394296420)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Logger Logs'
,p_static_id=>'looger-logs'
,p_list_item_link_target=>'f?p=&APP_ID.:400:&SESSION.::&DEBUG.'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'400,410'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(428262650622277896)
,p_list_item_display_sequence=>100
,p_list_item_link_text=>'Running now'
,p_static_id=>'running-now'
,p_list_item_link_target=>'f?p=&APP_ID.:1400:&SESSION.::&DEBUG.'
,p_parent_list_item_id=>wwv_flow_imp.id(422972072521875614)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1400'
);
end;
/
prompt --application/shared_components/navigation/lists/user_interface
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(382116524098018567)
,p_name=>'User Interface'
,p_static_id=>'user-interface'
,p_required_patch=>wwv_flow_imp.id(382096531916018510)
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(382116957213018567)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Theme Style Selection'
,p_static_id=>'theme-style-selection'
,p_list_item_link_target=>'f?p=&APP_ID.:10010:&SESSION.::&DEBUG.:10010'
,p_list_item_icon=>'fa-paint-brush'
,p_list_text_01=>'Set the default application look and feel'
,p_required_patch=>wwv_flow_imp.id(382096531916018510)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/listentry
begin
null;
end;
/
prompt --application/shared_components/files/app_icon_css
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E6170702D69636F6E207B0A202020206261636B67726F756E642D696D6167653A2075726C286170702D69636F6E2E737667293B0A202020206261636B67726F756E642D7265706561743A206E6F2D7265706561743B0A202020206261636B67726F756E';
wwv_flow_imp.g_varchar2_table(2) := '642D73697A653A20636F7665723B0A202020206261636B67726F756E642D706F736974696F6E3A203530253B0A202020206261636B67726F756E642D636F6C6F723A20233645383539383B0A7D';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(382095575270018509)
,p_file_name=>'app-icon.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/app_icon_svg
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '3C73766720786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F737667222076696577426F783D22302030203634203634222077696474683D22363422206865696768743D223634223E3C726563742077696474683D2231303025';
wwv_flow_imp.g_varchar2_table(2) := '22206865696768743D2231303025222066696C6C3D222336453835393822202F3E3C67206F7061636974793D222E32223E3C7061746820643D224D333220323661322E3520322E3520302031203020322E3520322E3541322E35303320322E3530332030';
wwv_flow_imp.g_varchar2_table(3) := '203020302033322032367A6D30203461312E3520312E3520302031203120312E352D312E3541312E35303220312E3530322030203020312033322033307A222F3E3C7061746820643D224D34322E3533362033362E3832386C2D322E3637332D322E3637';
wwv_flow_imp.g_varchar2_table(4) := '324131382E3937332031382E39373320302030203020343020333263302D352E3835352D322E3732332D31312E3439332D372E3636382D31352E383734612E352E352030203020302D2E36363420304332362E3732332032302E3530372032342032362E';
wwv_flow_imp.g_varchar2_table(5) := '3134352032342033326131382E3937332031382E393733203020302030202E31333720322E3135366C2D322E36373320322E36373341342E39363720342E3936372030203020302032302034302E3336345634372E35612E352E35203020302030202E35';
wwv_flow_imp.g_varchar2_table(6) := '2E3568312E30373561332E30303220332E30303220302030203020312E3935322D2E3732326C342E332D332E363835632E3431312E3538322E38343720312E31353520312E33323220312E37313261322E30303120322E30303120302030203020312E35';
wwv_flow_imp.g_varchar2_table(7) := '32372E363935682E38323476312E35612E352E3520302030203020312030563436682E38323461322E30303120322E30303120302030203020312E3532372D2E3639352032332E37382032332E373820302030203020312E3332332D312E3731326C342E';
wwv_flow_imp.g_varchar2_table(8) := '32393820332E36383461332E30303220332E30303220302030203020312E3935332E3732334834332E35612E352E35203020302030202E352D2E35762D372E31333661342E393720342E39372030203020302D312E3436342D332E3533367A4D33322031';
wwv_flow_imp.g_varchar2_table(9) := '372E3137334132322E3839372032322E3839372030203020312033362E363237203233682D392E3235344132322E3839372032322E3839372030203020312033322031372E3137337A4D32322E3837362034362E3532613220322030203020312D312E33';
wwv_flow_imp.g_varchar2_table(10) := '2E343831483231762D362E36333661332E39373320332E39373320302030203120312E3137312D322E3832386C322E31342D322E31346132302E3330312032302E33303120302030203020322E39353920372E3335377A6D31312E3231342D312E383633';
wwv_flow_imp.g_varchar2_table(11) := '61312E30313420312E3031342030203020312D2E3736362E3334344833322E35762D392E35612E352E352030203020302D312030563435682D2E38323461312E30313420312E3031342030203020312D2E3736362D2E3334344131392E342031392E3420';
wwv_flow_imp.g_varchar2_table(12) := '30203020312032352033326131382E3434362031382E34343620302030203120312E3835382D386831302E3238344131382E3434362031382E3434362030203020312033392033326131392E342031392E342030203020312D342E39312031322E363536';
wwv_flow_imp.g_varchar2_table(13) := '7A4D3433203437682D2E353735613220322030203020312D312E3330322D2E3438326C2D342E3339332D332E3736356132302E332032302E3320302030203020322E3935382D372E3335386C322E313420322E313441332E39373520332E393735203020';
wwv_flow_imp.g_varchar2_table(14) := '3020312034332034302E3336347A222F3E3C2F673E3C7061746820643D224D33322031372E3137334132322E3839372032322E3839372030203020312033362E363237203233682D392E3235344132322E3839372032322E383937203020302031203332';
wwv_flow_imp.g_varchar2_table(15) := '2031372E3137337A4D32322E3837362034362E3532613220322030203020312D312E332E343831483231762D362E36333661332E39373320332E39373320302030203120312E3137312D322E3832386C322E31342D322E31346132302E3330312032302E';
wwv_flow_imp.g_varchar2_table(16) := '33303120302030203020322E39353920372E3335377A4D3433203437682D2E353735613220322030203020312D312E3330322D2E3438326C2D342E3339332D332E3736356132302E332032302E3320302030203020322E3935382D372E3335386C322E31';
wwv_flow_imp.g_varchar2_table(17) := '3420322E313441332E39373520332E3937352030203020312034332034302E3336347A222066696C6C3D222366636662666122206F7061636974793D222E34222F3E3C7061746820643D224D33372E3134322032344832362E3835384131382E34343620';
wwv_flow_imp.g_varchar2_table(18) := '31382E3434362030203020302032352033326131392E342031392E3420302030203020342E39312031322E36353620312E30313420312E303134203020302030202E3736362E333434682E383234762D392E35612E352E35203020302031203120305634';
wwv_flow_imp.g_varchar2_table(19) := '35682E38323461312E30313420312E303134203020302030202E3736362D2E3334344131392E342031392E342030203020302033392033326131382E3434362031382E3434362030203020302D312E3835382D387A4D333220333161322E3520322E3520';
wwv_flow_imp.g_varchar2_table(20) := '302031203120322E352D322E3541322E35303320322E3530332030203020312033322033317A222066696C6C3D222366666622206F7061636974793D222E3935222F3E3C7061746820643D224D333220333061312E3520312E3520302031203120312E35';
wwv_flow_imp.g_varchar2_table(21) := '2D312E3541312E35303220312E3530322030203020312033322033307A222066696C6C3D222366636662666122206F7061636974793D222E36222F3E3C2F7376673E';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(382095234345018504)
,p_file_name=>'app-icon.svg'
,p_mime_type=>'image/svg+xml'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/app_css
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A20455253482D3034373A20696E636964656E7420737461747573206261646765732028706167652031303020496E636964656E74732049522C20706167652031313020686561646572292E0A202020507265666978656420746F2061766F69642063';
wwv_flow_imp.g_varchar2_table(2) := '6C617368696E67207769746820556E6976657273616C205468656D652773206F776E20742D20636C61737365733B20636F6C6F72730A20202066616C6C206261636B20746F206120574341472D41412D736166652068617264636F6465642076616C7565';
wwv_flow_imp.g_varchar2_table(3) := '207768656E20746865202D2D75742D2A20637573746F6D0A20202070726F70657274792069736E277420646566696E65642062792074686520616374697665207468656D65207374796C652E202A2F0A2E657273682D6261646765207B0A2020666F6E74';
wwv_flow_imp.g_varchar2_table(4) := '2D7765696768743A203630303B0A7D0A0A2F2A20436F6D706F756E642028626F7468206F776E20636C61737365732920736F20746869732072656C6961626C792077696E73206F76657220746865207468656D652773206F776E0A2020202E742D426164';
wwv_flow_imp.g_varchar2_table(5) := '6765206261636B67726F756E64207265676172646C657373206F66207374796C657368656574206C6F6164206F726465722C20776974686F75740A20202073656C656374696E67202E742D4261646765206469726563746C792E202A2F0A2E657273682D';
wwv_flow_imp.g_varchar2_table(6) := '62616467652E657273682D62616467652D6F70656E207B0A20206261636B67726F756E642D636F6C6F723A20766172282D2D75742D7761726E696E672D636F6C6F722C2023396335323030293B0A2020636F6C6F723A20236666666666663B0A7D0A0A2E';
wwv_flow_imp.g_varchar2_table(7) := '657273682D62616467652E657273682D62616467652D72656772657373696F6E207B0A20206261636B67726F756E642D636F6C6F723A20766172282D2D75742D64616E6765722D636F6C6F722C2023633030663063293B0A2020636F6C6F723A20236666';
wwv_flow_imp.g_varchar2_table(8) := '666666663B0A7D0A0A2E657273682D62616467652E657273682D62616467652D7265736F6C766564207B0A20206261636B67726F756E642D636F6C6F723A20766172282D2D75742D737563636573732D636F6C6F722C2023326137643265293B0A202063';
wwv_flow_imp.g_varchar2_table(9) := '6F6C6F723A20236666666666663B0A7D0A0A2F2A2053756D6D617279204261646765204C697374202852656772657373696F6E732074696C65293A20636F6C6F72206F6E6C792C206E6F206261636B67726F756E642F70616464696E670A202020E28094';
wwv_flow_imp.g_varchar2_table(10) := '2061204261646765204C6973742076616C756520736C6F74206578706563747320706C61696E206269672D6E756D62657220746578742C20736F2074686973206D7573740A20202073746179206120746578742D636F6C6F722D6F6E6C79206F76657272';
wwv_flow_imp.g_varchar2_table(11) := '6964652C206E65766572206120742D42616467652063686970202877686963682062726F6B65207468650A20202074696C652773206C61796F7574207768656E207472696564292E202A2F0A2E657273682D73756D6D6172792D76616C75652D64616E67';
wwv_flow_imp.g_varchar2_table(12) := '6572207B0A2020636F6C6F723A20766172282D2D75742D64616E6765722D636F6C6F722C2023633030663063293B0A7D0A';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(19834658910484661)
,p_file_name=>'app.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/security/authorizations/administration_rights
begin
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(382097282347018512)
,p_name=>'Administration Rights'
,p_static_id=>'administration-rights'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'plsql_function_body', wwv_flow_string.join(wwv_flow_t_varchar2(
    '-- TODO_AF_09-17-2026 Replace with a real role model. Today every',
    '-- authenticated user is an administrator. See ERSH-043.',
    'return true;')))).to_clob
,p_error_message=>'Insufficient privileges, user is not an Administrator'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
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
prompt --application/shared_components/user_interface/lovs/desktop_theme_styles
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(382107818468018553)
,p_lov_name=>'DESKTOP THEME STYLES'
,p_static_id=>'desktop-theme-styles'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.name d,',
'       s.theme_style_id r',
'  from apex_application_theme_styles s,',
'       apex_application_themes t',
' where s.application_id = :app_id',
'   and t.application_id = s.application_id',
'   and t.theme_number   = s.theme_number',
'   and t.ui_type_name   = ''DESKTOP''',
'   and t.is_current     = ''Yes''',
' order by 1'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
);
end;
/
prompt --application/shared_components/user_interface/lovs/logger_level_values
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(17079722012553922)
,p_lov_name=>'LOGGER_LEVEL_VALUES'
,p_static_id=>'logger-level'
,p_lov_query=>'.'||wwv_flow_imp.id(17079722012553922)||'.'
,p_location=>'STATIC'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(17080628018553924)
,p_lov_disp_sequence=>90
,p_lov_disp_value=>'APEX'
,p_lov_return_value=>'APEX'
,p_static_id=>'apex'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(17080305144553923)
,p_lov_disp_sequence=>60
,p_lov_disp_value=>'DEBUG'
,p_lov_return_value=>'DEBUG'
,p_static_id=>'debug'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(17080025484553923)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'ERROR'
,p_lov_return_value=>'ERROR'
,p_static_id=>'error'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(17080251136553923)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'INFORMATION'
,p_lov_return_value=>'INFORMATION'
,p_static_id=>'information'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(17079824274553922)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'OFF'
,p_lov_return_value=>'OFF'
,p_static_id=>'off'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(17079910216553923)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'PERMANENT'
,p_lov_return_value=>'PERMANENT'
,p_static_id=>'permanent'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(17080557462553924)
,p_lov_disp_sequence=>80
,p_lov_disp_value=>'SYS_CONTEXT'
,p_lov_return_value=>'SYS_CONTEXT'
,p_static_id=>'sys-context'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(17080414547553924)
,p_lov_disp_sequence=>70
,p_lov_disp_value=>'TIMING'
,p_lov_return_value=>'TIMING'
,p_static_id=>'timing'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(17080124881553923)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>'WARNING'
,p_lov_return_value=>'WARNING'
,p_static_id=>'warning'
);
end;
/
prompt --application/shared_components/user_interface/lovs/login_remember_username
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(382099422074018525)
,p_lov_name=>'LOGIN_REMEMBER_USERNAME'
,p_static_id=>'login-remember-username'
,p_lov_query=>'.'||wwv_flow_imp.id(382099422074018525)||'.'
,p_location=>'STATIC'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(382099889074018526)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Remember username'
,p_lov_return_value=>'Y'
,p_static_id=>'remember-username'
);
end;
/
prompt --application/shared_components/user_interface/lovs/user_theme_preference
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(382108507957018559)
,p_lov_name=>'USER_THEME_PREFERENCE'
,p_static_id=>'user-theme-preference'
,p_lov_query=>'.'||wwv_flow_imp.id(382108507957018559)||'.'
,p_location=>'STATIC'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(382108835540018559)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Allow End Users to choose Theme Style'
,p_lov_return_value=>'Yes'
,p_static_id=>'allow-end-users-to-choose-theme-style'
);
end;
/
prompt --application/pages/page_groups
begin
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(382097521246018512)
,p_group_name=>'Administration'
,p_static_id=>'administration'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(382352415602665873)
,p_group_name=>'CapWorks'
,p_static_id=>'capworks'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(422974168485887415)
,p_group_name=>'Jobs'
,p_static_id=>'jobs'
);
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_imp_shared.create_menu(
 p_id=>wwv_flow_imp.id(381906105739018350)
,p_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(382116309613018567)
,p_short_name=>'Administration'
,p_static_id=>'administration'
,p_link=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.'
,p_page_id=>10000
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(428267012336285621)
,p_parent_id=>wwv_flow_imp.id(422972960694875614)
,p_short_name=>'APEX automations'
,p_static_id=>'apex-automations'
,p_link=>'f?p=&APP_ID.:1600:&SESSION.::&DEBUG.'
,p_page_id=>1600
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(381906352478018350)
,p_short_name=>'Home'
,p_static_id=>'home'
,p_link=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.'
,p_page_id=>1
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(422975606510897996)
,p_parent_id=>wwv_flow_imp.id(422972960694875614)
,p_short_name=>' Inventory'
,p_static_id=>'inventory'
,p_link=>'f?p=&APP_ID.:1100:&SESSION.::&DEBUG.'
,p_page_id=>1100
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(422988547835905198)
,p_parent_id=>wwv_flow_imp.id(422972960694875614)
,p_short_name=>'Job - Details'
,p_static_id=>'job-details'
,p_link=>'f?p=&APP_ID.:1200:&SESSION.::&DEBUG.'
,p_page_id=>1200
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(423004472259911412)
,p_parent_id=>wwv_flow_imp.id(422972960694875614)
,p_short_name=>'Job-Executions'
,p_static_id=>'job-executions'
,p_link=>'f?p=&APP_ID.:1300:&SESSION.::&DEBUG.'
,p_page_id=>1300
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(422972960694875614)
,p_short_name=>'Jobs - Dashboard'
,p_static_id=>'jobs-dashboard'
,p_link=>'f?p=&APP_ID.:1000:&SESSION.::&DEBUG.'
,p_page_id=>1000
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(382491297109296423)
,p_parent_id=>wwv_flow_imp.id(382490036921296421)
,p_short_name=>'Log'
,p_static_id=>'log'
,p_link=>'f?p=&APP_ID.:410:&SESSION.::&DEBUG.'
,p_page_id=>410
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(382490036921296421)
,p_short_name=>'Logger Logs'
,p_static_id=>'looger-logs'
,p_link=>'f?p=&APP_ID.:400:&SESSION.::&DEBUG.'
,p_page_id=>400
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(428263800602277909)
,p_parent_id=>wwv_flow_imp.id(422972960694875614)
,p_short_name=>'Running now '
,p_static_id=>'running-now'
,p_link=>'f?p=&APP_ID.:1400:&SESSION.::&DEBUG.'
,p_page_id=>1400
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(428265490153282521)
,p_short_name=>'Timeline'
,p_static_id=>'timeline'
,p_link=>'f?p=&APP_ID.:1500:&SESSION.::&DEBUG.'
,p_page_id=>1500
);
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
 p_id=>wwv_flow_imp.id(382072586552018462)
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
,p_files_version=>2461306201328
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
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(381905544746018346)
,p_build_option_name=>'Commented Out'
,p_static_id=>'commented-out'
,p_build_option_status=>'EXCLUDE'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(382096455746018510)
,p_build_option_name=>'Feature: About Page'
,p_static_id=>'feature-about-page'
,p_build_option_status=>'INCLUDE'
,p_feature_identifier=>'APPLICATION_ABOUT_PAGE'
,p_build_option_comment=>'About this application page.'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(382096531916018510)
,p_build_option_name=>'Feature: Theme Style Selection'
,p_static_id=>'feature-theme-style-selection'
,p_build_option_status=>'INCLUDE'
,p_feature_identifier=>'APPLICATION_THEME_STYLE_SELECTION'
,p_build_option_comment=>'Allow administrators to select a default color scheme (theme style) for the application. Administrators can also choose to allow end users to choose their own theme style. '
);
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
 p_id=>wwv_flow_imp.id(381905898510018348)
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
,p_name=>'Home'
,p_alias=>'HOME'
,p_step_title=>'Error Shield'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382103927468018535)
,p_plug_name=>'Error Shield'
,p_static_id=>'error-shield'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675494171183407654
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
end;
/
prompt --application/pages/page_00100
begin
wwv_flow_imp_page.create_page(
 p_id=>100
,p_name=>'Incidents'
,p_alias=>'INCIDENTS'
,p_step_title=>'Incidents'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(17640820228968005)
,p_plug_name=>'Find Incident'
,p_static_id=>'find-incident'
,p_region_name=>'findIncidentSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>5
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_column=>9
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382121469095033210)
,p_plug_name=>'Incidents'
,p_static_id=>'incidents'
,p_region_name=>'INCIDENTS_IR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_SHIELD_INCIDENTS_VW'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Incidents'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(382121529995033210)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::P110_SHIELD_INCIDENT_ID:#SHIELD_INCIDENT_ID#'
,p_detail_link_text=>'<img src="#APEX_FILES#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_internal_uid=>382121529995033210
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19836304063484686)
,p_db_column_name=>'ACTIVE_YN'
,p_display_order=>24
,p_column_identifier=>'V'
,p_column_label=>'Active Yn'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19836014530484686)
,p_db_column_name=>'AFFECTED_USERS'
,p_display_order=>21
,p_column_identifier=>'S'
,p_column_label=>'Users'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19835636797484685)
,p_db_column_name=>'APP_PAGE_DISPLAY'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'App / Page'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19835763739484685)
,p_db_column_name=>'COMPONENT_LABEL'
,p_display_order=>10
,p_column_identifier=>'H'
,p_column_label=>'Component'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382124710029033217)
,p_db_column_name=>'COMPONENT_NAME'
,p_display_order=>11
,p_column_identifier=>'I'
,p_column_label=>'Component Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19836436088484686)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>25
,p_column_identifier=>'W'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382129561517033221)
,p_db_column_name=>'CREATED_ON'
,p_display_order=>26
,p_column_identifier=>'X'
,p_column_label=>'Created On'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'Y'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19836139975484686)
,p_db_column_name=>'ERROR_FINGERPRINT'
,p_display_order=>22
,p_column_identifier=>'T'
,p_column_label=>'Error Fingerprint'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382125563677033218)
,p_db_column_name=>'ERROR_SUMMARY'
,p_display_order=>13
,p_column_identifier=>'K'
,p_column_label=>'Error Summary'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19835545541484684)
,p_db_column_name=>'FIRST_REFERENCE_DISPLAY'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'First ref'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19835898964484685)
,p_db_column_name=>'INCIDENT_STATUS'
,p_display_order=>19
,p_column_identifier=>'Q'
,p_column_label=>'Status'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{case INCIDENT_STATUS/}',
'    {when REGRESSION/}',
'        <span class="t-Badge ersh-badge ersh-badge-regression">Regression</span>',
'    {when OPEN/}',
'        <span class="t-Badge ersh-badge ersh-badge-open">Open</span>',
'    {otherwise/}',
'        <span class="t-Badge ersh-badge ersh-badge-resolved">Resolved</span>',
'{endcase/}'))
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19835970175484686)
,p_db_column_name=>'LAST_OCCURRED_ON'
,p_display_order=>20
,p_column_identifier=>'R'
,p_column_label=>'Last hit'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'Y'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19836595901484686)
,p_db_column_name=>'LAST_UPDATED_BY'
,p_display_order=>27
,p_column_identifier=>'Y'
,p_column_label=>'Last Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382130340268033221)
,p_db_column_name=>'LAST_UPDATED_ON'
,p_display_order=>28
,p_column_identifier=>'Z'
,p_column_label=>'Last Updated On'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'Y'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382126782289033220)
,p_db_column_name=>'OCCURRENCE_COUNT'
,p_display_order=>14
,p_column_identifier=>'L'
,p_column_label=>'Hits'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382125159606033218)
,p_db_column_name=>'ORA_SQLCODE'
,p_display_order=>12
,p_column_identifier=>'J'
,p_column_label=>'Ora Sqlcode'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382128341046033220)
,p_db_column_name=>'RESOLUTION_NOTES'
,p_display_order=>18
,p_column_identifier=>'P'
,p_column_label=>'Resolution Notes'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382127570471033220)
,p_db_column_name=>'RESOLVED_BY'
,p_display_order=>16
,p_column_identifier=>'N'
,p_column_label=>'Resolved By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382127948125033220)
,p_db_column_name=>'RESOLVED_ON'
,p_display_order=>17
,p_column_identifier=>'O'
,p_column_label=>'Resolved On'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'Y'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382121939963033215)
,p_db_column_name=>'SHIELD_INCIDENT_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Shield Incident Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19836246562484686)
,p_db_column_name=>'WORKSPACE_ID'
,p_display_order=>23
,p_column_identifier=>'U'
,p_column_label=>'Workspace Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(19837324640484802)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'All'
,p_report_seq=>10
,p_report_alias=>'all'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INCIDENT_STATUS:APP_PAGE_DISPLAY:ERROR_SUMMARY:COMPONENT_LABEL:COMPONENT_NAME:ORA_SQLCODE:OCCURRENCE_COUNT:AFFECTED_USERS:LAST_OCCURRED_ON:FIRST_REFERENCE_DISPLAY'
,p_sort_column_1=>'LAST_OCCURRED_ON'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(19836682997484688)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'pending'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INCIDENT_STATUS:APP_PAGE_DISPLAY:ERROR_SUMMARY:COMPONENT_LABEL:COMPONENT_NAME:ORA_SQLCODE:OCCURRENCE_COUNT:AFFECTED_USERS:LAST_OCCURRED_ON:FIRST_REFERENCE_DISPLAY'
,p_sort_column_1=>'LAST_OCCURRED_ON'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(19851869390103127)
,p_report_id=>wwv_flow_imp.id(19836682997484688)
,p_static_id=>'pending-filter'
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'INCIDENT_STATUS'
,p_operator=>'!='
,p_expr=>'RESOLVED'
,p_condition_sql=>'"INCIDENT_STATUS" != #APXWS_EXPR#'
,p_condition_display=>'#APXWS_COL_NAME# != ''RESOLVED''  '
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(19836952520484707)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Regressions'
,p_report_seq=>10
,p_report_alias=>'regressions'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INCIDENT_STATUS:APP_PAGE_DISPLAY:ERROR_SUMMARY:COMPONENT_LABEL:COMPONENT_NAME:ORA_SQLCODE:OCCURRENCE_COUNT:AFFECTED_USERS:LAST_OCCURRED_ON:FIRST_REFERENCE_DISPLAY'
,p_sort_column_1=>'LAST_OCCURRED_ON'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(19851990543103191)
,p_report_id=>wwv_flow_imp.id(19836952520484707)
,p_static_id=>'regressions-filter'
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'INCIDENT_STATUS'
,p_operator=>'='
,p_expr=>'REGRESSION'
,p_condition_sql=>'"INCIDENT_STATUS" = #APXWS_EXPR#'
,p_condition_display=>'#APXWS_COL_NAME# = ''REGRESSION''  '
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(19837162877484801)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Resolved'
,p_report_seq=>10
,p_report_alias=>'resolved'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INCIDENT_STATUS:APP_PAGE_DISPLAY:ERROR_SUMMARY:COMPONENT_LABEL:COMPONENT_NAME:ORA_SQLCODE:OCCURRENCE_COUNT:AFFECTED_USERS:LAST_OCCURRED_ON:FIRST_REFERENCE_DISPLAY:RESOLVED_BY:RESOLVED_ON'
,p_sort_column_1=>'LAST_OCCURRED_ON'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_worksheet_condition(
 p_id=>wwv_flow_imp.id(19852057586103193)
,p_report_id=>wwv_flow_imp.id(19837162877484801)
,p_static_id=>'resolved-filter'
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'INCIDENT_STATUS'
,p_operator=>'='
,p_expr=>'RESOLVED'
,p_condition_sql=>'"INCIDENT_STATUS" = #APXWS_EXPR#'
,p_condition_display=>'#APXWS_COL_NAME# = ''RESOLVED''  '
,p_enabled=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(19835023226484680)
,p_name=>'Summary'
,p_static_id=>'summary'
,p_region_name=>'summaryCR'
,p_template=>4073835273271169698
,p_display_sequence=>3
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-BadgeList--medium:t-BadgeList--dash:t-BadgeList--fixed:t-Report--hideNoPagination'
,p_grid_column_span=>8
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with w_status as (',
'  select count(case when incident_status = ''OPEN'' then 1 end)       as open_cnt',
'       , count(case when incident_status = ''REGRESSION'' then 1 end) as regression_cnt',
'    from ersh_shield_incidents_vw',
'), w_recent as (',
'  select count(1)                 as hits_24h',
'       , count(distinct app_user)  as users_24h',
'    from ersh_incident_occurrences',
'   where active_yn = ''Y''',
'     and occurred_on > systimestamp - 1',
')',
'select s.open_cnt        as open',
'     , s.regression_cnt  as regressions',
'     , r.hits_24h        as hits_24h',
'     , r.users_24h       as users_24h',
'  from w_status  s',
'  cross join w_recent r'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2106120299521025145
,p_query_num_rows=>1
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19835308926484682)
,p_query_column_id=>3
,p_column_alias=>'HITS_24H'
,p_column_display_sequence=>30
,p_column_heading=>'Hits 24h'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19835196012484681)
,p_query_column_id=>1
,p_column_alias=>'OPEN'
,p_column_display_sequence=>10
,p_column_heading=>'Open'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19835229572484682)
,p_query_column_id=>2
,p_column_alias=>'REGRESSIONS'
,p_column_display_sequence=>20
,p_column_heading=>'Regressions'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if REGRESSIONS/}',
'    <span class="ersh-summary-value-danger">#REGRESSIONS#</span>',
'{endif/}',
'{if !REGRESSIONS/}',
'    #REGRESSIONS#',
'{endif/}'))
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19835410820484682)
,p_query_column_id=>4
,p_column_alias=>'USERS_24H'
,p_column_display_sequence=>40
,p_column_heading=>'Users 24h'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(17641222761968059)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(17640820228968005)
,p_button_name=>'FIND_INCIDENT'
,p_static_id=>'find-incident'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Find Incident'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(19852143961103195)
,p_branch_name=>'Go to Found Incident'
,p_branch_action=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::P110_SHIELD_INCIDENT_ID:&P100_FOUND_INCIDENT_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'ITEM_IS_NOT_NULL'
,p_branch_condition=>'P100_FOUND_INCIDENT_ID'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17641164220968059)
,p_name=>'P100_FOUND_INCIDENT_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(17640820228968005)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17641064191968056)
,p_name=>'P100_SEARCH_CODE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(17640820228968005)
,p_prompt=>'Reference Code'
,p_placeholder=>'e.g. 0000005003'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cMaxlength=>20
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>3033038003750078790
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(17641373874968060)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Find Incident'
,p_static_id=>'find-incident'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_code           varchar2(4000);',
'  l_logger_log_id  number;',
'begin',
'  :P100_FOUND_INCIDENT_ID := null;',
'  l_code := trim(:P100_SEARCH_CODE);',
'',
'  begin',
'    l_logger_log_id := to_number(l_code);',
'  exception',
'    when others then',
'      l_logger_log_id := null;',
'  end;',
'',
'  if l_logger_log_id is null then',
'    apex_error.add_error(',
'        p_message          => ''Enter a valid reference code (digits only).''',
'      , p_display_location => apex_error.c_inline_with_field_and_notif',
'      , p_page_item_name   => ''P100_SEARCH_CODE''',
'    );',
'    return;',
'  end if;',
'',
'  begin',
'    select shield_incident_id',
'      into :P100_FOUND_INCIDENT_ID',
'      from ersh_incident_occurrences_vw',
'     where logger_log_id = l_logger_log_id;',
'  exception',
'    when no_data_found then',
'      apex_error.add_error(',
'          p_message          => ''No incident found for reference code '' || l_code || ''.''',
'        , p_display_location => apex_error.c_inline_with_field_and_notif',
'        , p_page_item_name   => ''P100_SEARCH_CODE''',
'      );',
'  end;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'FIND_INCIDENT'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>17641373874968060
);
end;
/
prompt --application/pages/page_00110
begin
wwv_flow_imp_page.create_page(
 p_id=>110
,p_name=>'Review Incident'
,p_alias=>'REVIEW-INCIDENT'
,p_page_mode=>'MODAL'
,p_step_title=>'Review Incident'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'1000'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(377204084152175333)
,p_plug_name=>'Audit'
,p_static_id=>'audit'
,p_parent_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(377204248008175335)
,p_plug_name=>'Dialog'
,p_static_id=>'dialog'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(17641694344968062)
,p_name=>'Occurrences'
,p_static_id=>'occurrences'
,p_parent_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_template=>4073835273271169698
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select o.app_user          as app_user',
'     , o.reference_display as reference_display',
'     , o.occurred_on       as occurred_on',
'  from ersh_incident_occurrences_vw o',
' where o.shield_incident_id = :P110_SHIELD_INCIDENT_ID',
' order by o.occurred_on desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P110_SHIELD_INCIDENT_ID'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No occurrences recorded.'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17641774190968063)
,p_query_column_id=>1
,p_column_alias=>'APP_USER'
,p_column_display_sequence=>10
,p_column_heading=>'App User'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17641978509968064)
,p_query_column_id=>3
,p_column_alias=>'OCCURRED_ON'
,p_column_display_sequence=>30
,p_column_heading=>'Occurred On'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17641817694968064)
,p_query_column_id=>2
,p_column_alias=>'REFERENCE_DISPLAY'
,p_column_display_sequence=>20
,p_column_heading=>'Reference Display'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(377201688333175309)
,p_plug_name=>'Review Incident'
,p_static_id=>'review-incident'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_SHIELD_INCIDENTS'
,p_include_rowid_column=>false
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(19837623828484809)
,p_plug_name=>'Status'
,p_static_id=>'status'
,p_region_name=>'statusSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>5
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{case P110_INCIDENT_STATUS/}',
'    {when REGRESSION/}',
'        <span class="t-Badge ersh-badge ersh-badge-regression">Regression</span>',
'    {when OPEN/}',
'        <span class="t-Badge ersh-badge ersh-badge-open">Open</span>',
'    {otherwise/}',
'        <span class="t-Badge ersh-badge ersh-badge-resolved">Resolved</span>',
'{endcase/}'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(377204453787175337)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(377204248008175335)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(377204399179175336)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(377204248008175335)
,p_button_name=>'SAVE'
,p_static_id=>'save'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save'
,p_button_position=>'CREATE'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377203544880175328)
,p_name=>'P110_ACTIVE_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(377204084152175333)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Active Yn'
,p_source=>'ACTIVE_YN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377202097136175313)
,p_name=>'P110_APPLICATION_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Application Id'
,p_source=>'APPLICATION_ID'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377202241853175315)
,p_name=>'P110_APP_USER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'App User'
,p_source=>'APP_USER'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377202505933175318)
,p_name=>'P110_COMPONENT_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Component Name'
,p_source=>'COMPONENT_NAME'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377202461023175317)
,p_name=>'P110_COMPONENT_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Component Type'
,p_source=>'COMPONENT_TYPE'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377203600066175329)
,p_name=>'P110_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(377204084152175333)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Created By'
,p_source=>'CREATED_BY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377203729173175330)
,p_name=>'P110_CREATED_ON'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(377204084152175333)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Created On'
,p_source=>'CREATED_ON'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377202869219175321)
,p_name=>'P110_ERROR_FINGERPRINT'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Error Fingerprint'
,p_source=>'ERROR_FINGERPRINT'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377202779038175320)
,p_name=>'P110_ERROR_SUMMARY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Error Summary'
,p_source=>'ERROR_SUMMARY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(19837729698484814)
,p_name=>'P110_INCIDENT_STATUS'
,p_item_sequence=>4
,p_item_plug_id=>wwv_flow_imp.id(19837623828484809)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377203854134175331)
,p_name=>'P110_LAST_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(377204084152175333)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Last Updated By'
,p_source=>'LAST_UPDATED_BY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377203924687175332)
,p_name=>'P110_LAST_UPDATED_ON'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(377204084152175333)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Last Updated On'
,p_source=>'LAST_UPDATED_ON'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377201973512175312)
,p_name=>'P110_LOGGER_LOG_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_source=>'LOGGER_LOG_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377203065716175323)
,p_name=>'P110_OCCURRENCE_COUNT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Occurrence Count'
,p_source=>'OCCURRENCE_COUNT'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377202602962175319)
,p_name=>'P110_ORA_SQLCODE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Ora Sqlcode'
,p_source=>'ORA_SQLCODE'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377202104515175314)
,p_name=>'P110_PAGE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Page Id'
,p_source=>'PAGE_ID'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377202316087175316)
,p_name=>'P110_REQUEST'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Request'
,p_source=>'REQUEST'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377203446674175327)
,p_name=>'P110_RESOLUTION_NOTES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Resolution Notes'
,p_source=>'RESOLUTION_NOTES'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'N',
  'format', 'MARKDOWN',
  'min_height', '180')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377203211324175325)
,p_name=>'P110_RESOLVED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(377204084152175333)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Resolved By'
,p_source=>'RESOLVED_BY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377203377979175326)
,p_name=>'P110_RESOLVED_ON'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(377204084152175333)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Resolved On'
,p_source=>'RESOLVED_ON'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377203142471175324)
,p_name=>'P110_RESOLVED_YN'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Resolved?'
,p_source=>'RESOLVED_YN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377201865865175311)
,p_name=>'P110_SHIELD_INCIDENT_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_source=>'SHIELD_INCIDENT_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377202915355175322)
,p_name=>'P110_TIME_BUCKET'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_item_source_plug_id=>wwv_flow_imp.id(377201688333175309)
,p_prompt=>'Time Bucket'
,p_source=>'TIME_BUCKET'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(377201756385175310)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(377201688333175309)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Review Incident'
,p_static_id=>'initialize-form-review-incident'
,p_internal_uid=>377201756385175310
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(19837890911484817)
,p_process_sequence=>5
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load Incident Status'
,p_static_id=>'load-incident-status'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select incident_status',
'  into :P110_INCIDENT_STATUS',
'  from ersh_shield_incidents_vw',
' where shield_incident_id = :P110_SHIELD_INCIDENT_ID;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'P110_SHIELD_INCIDENT_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_internal_uid=>19837890911484817
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(377204103111175334)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(377201688333175309)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Review Incident'
,p_static_id=>'review-incident'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>377204103111175334
);
end;
/
prompt --application/pages/page_00200
begin
wwv_flow_imp_page.create_page(
 p_id=>200
,p_name=>'Application Preferences'
,p_alias=>'ERROR-SHIELD-PREFERENCES'
,p_step_title=>'Application Preferences'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382140660269074934)
,p_plug_name=>'Report 1'
,p_static_id=>'report'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'LOGGER_PREFS'
,p_include_rowid_column=>true
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Report 1'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(382141059926074934)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:210:&SESSION.::&DEBUG.:RP:P210_ROWID:\#ROWID#\'
,p_detail_link_text=>'<span aria-label="Edit"><span class="fa fa-edit" aria-hidden="true" title="Edit"></span></span>'
,p_internal_uid=>382141059926074934
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382141514506074935)
,p_db_column_name=>'PREF_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Pref Name'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382142344049074935)
,p_db_column_name=>'PREF_TYPE'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Pref Type'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382141923539074935)
,p_db_column_name=>'PREF_VALUE'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Pref Value'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382141197907074935)
,p_db_column_name=>'ROWID'
,p_display_order=>0
,p_column_identifier=>'A'
,p_column_label=>'ROWID'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(382144869736075451)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'3821449'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ROWID:PREF_NAME:PREF_VALUE:PREF_TYPE'
,p_break_on=>'PREF_TYPE'
,p_break_enabled_on=>'PREF_TYPE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382144463913074939)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(382140660269074934)
,p_button_name=>'CREATE'
,p_static_id=>'create'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:210:&SESSION.::&DEBUG.:210'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(382143437445074937)
,p_name=>'Edit Report - Dialog Closed'
,p_static_id=>'edit-report-dialog-closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(382140660269074934)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(382143995803074937)
,p_event_id=>wwv_flow_imp.id(382143437445074937)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(382140660269074934)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
end;
/
prompt --application/pages/page_00210
begin
wwv_flow_imp_page.create_page(
 p_id=>210
,p_name=>'Application Preference'
,p_alias=>'ERROR-SHIELD-PREFERENCE'
,p_page_mode=>'MODAL'
,p_step_title=>'Application Preference'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382136278258074929)
,p_plug_name=>'Buttons'
,p_static_id=>'buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382133108270074923)
,p_plug_name=>'Error Shield Preference'
,p_static_id=>'error-shield-preference'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'LOGGER_PREFS'
,p_include_rowid_column=>true
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382136611036074929)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(382136278258074929)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA_ACTION'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_component_da_action(
 p_id=>wwv_flow_imp.id(382137572457074931)
,p_button_id=>wwv_flow_imp.id(382136611036074929)
,p_action_sequence=>10
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_static_id=>'native-dialog-cancel'
,p_stop_execution_on_error=>true
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382138888286074932)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(382136278258074929)
,p_button_name=>'CREATE'
,p_static_id=>'create'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'NEXT'
,p_button_condition=>'P210_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_grid_new_row=>'Y'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382138064643074932)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(382136278258074929)
,p_button_name=>'DELETE'
,p_static_id=>'delete'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P210_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_row=>'Y'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382138414576074932)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(382136278258074929)
,p_button_name=>'SAVE'
,p_static_id=>'save'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_condition=>'P210_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_row=>'Y'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382133853658074926)
,p_name=>'P210_PREF_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(382133108270074923)
,p_item_source_plug_id=>wwv_flow_imp.id(382133108270074923)
,p_prompt=>'Pref Name'
,p_source=>'PREF_NAME'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cMaxlength=>255
,p_read_only_when=>'P210_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382134652163074928)
,p_name=>'P210_PREF_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(382133108270074923)
,p_item_source_plug_id=>wwv_flow_imp.id(382133108270074923)
,p_prompt=>'Pref Type'
,p_source=>'PREF_TYPE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cMaxlength=>30
,p_read_only_when=>'P210_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382134269288074928)
,p_name=>'P210_PREF_VALUE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(382133108270074923)
,p_item_source_plug_id=>wwv_flow_imp.id(382133108270074923)
,p_prompt=>'Pref Value'
,p_source=>'PREF_VALUE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>255
,p_display_when=>'nvl(:P210_PREF_TYPE, ''x'') != logger.g_pref_type_logger or nvl(:P210_PREF_NAME, ''x'') != ''LEVEL'''
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17081327086554009)
,p_name=>'P210_PREF_VALUE_LOV'
,p_is_required=>true
,p_item_sequence=>41
,p_item_plug_id=>wwv_flow_imp.id(382133108270074923)
,p_prompt=>'Pref Value'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOGGER_LEVEL_VALUES'
,p_lov_display_null=>'YES'
,p_display_when=>':P210_PREF_TYPE = logger.g_pref_type_logger and :P210_PREF_NAME = ''LEVEL'''
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382133461577074925)
,p_name=>'P210_ROWID'
,p_source_data_type=>'ROWID'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(382133108270074923)
,p_item_source_plug_id=>wwv_flow_imp.id(382133108270074923)
,p_source=>'ROWID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382140088463074932)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_static_id=>'close-dialog'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'show_success_messages', 'N')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>382140088463074932
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382139214047074932)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(382133108270074923)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Error Shield Preference'
,p_static_id=>'initialize-form-error-shield-preference'
,p_internal_uid=>382139214047074932
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(17081442765554011)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Populate Pref Value LOV'
,p_static_id=>'populate-pref-value-lov'
,p_process_sql_clob=>':P210_PREF_VALUE_LOV := :P210_PREF_VALUE;'
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>17081442765554011
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382139607707074932)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(382133108270074923)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Error Shield Preference'
,p_static_id=>'process-form-error-shield-preference'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>382139607707074932
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(17081534770554011)
,p_process_sequence=>5
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Sync Pref Value LOV'
,p_static_id=>'sync-pref-value-lov'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if 1=1',
'  and :P210_PREF_TYPE = logger.g_pref_type_logger',
'  and :P210_PREF_NAME = ''LEVEL''',
'  and :P210_PREF_VALUE_LOV is not null then',
'  :P210_PREF_VALUE := :P210_PREF_VALUE_LOV;',
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>17081534770554011
);
end;
/
prompt --application/pages/page_00400
begin
wwv_flow_imp_page.create_page(
 p_id=>400
,p_name=>'Logger Logs'
,p_alias=>'LOGGER-LOGS'
,p_step_title=>'Logger Logs'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382490259525296421)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(381906105739018350)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382482473407296415)
,p_plug_name=>'Report 1'
,p_static_id=>'report'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'LOGGER_LOGS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Report 1'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(382482885811296415)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:410:&SESSION.::&DEBUG.:RP:P410_ID:\#ID#\'
,p_detail_link_text=>'<span aria-label="Edit"><span class="fa fa-edit" aria-hidden="true" title="Edit"></span></span>'
,p_internal_uid=>382482885811296415
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382485394190296418)
,p_db_column_name=>'ACTION'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Action'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382486503246296418)
,p_db_column_name=>'CALL_STACK'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Call Stack'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382486110941296418)
,p_db_column_name=>'CLIENT_IDENTIFIER'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Client Identifier'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382488903970296420)
,p_db_column_name=>'CLIENT_INFO'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Client Info'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382488129800296420)
,p_db_column_name=>'EXTRA'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Extra'
,p_allow_sorting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'CLOB'
,p_heading_alignment=>'LEFT'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382482959461296415)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382487308923296418)
,p_db_column_name=>'LINE_NO'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Line No'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382483355015296417)
,p_db_column_name=>'LOGGER_LEVEL'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Logger Level'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382484905414296418)
,p_db_column_name=>'MODULE'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Module'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382487774154296418)
,p_db_column_name=>'SCN'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Scn'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382484513349296417)
,p_db_column_name=>'SCOPE'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Scope'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382488598301296420)
,p_db_column_name=>'SID'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Sid'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382483735527296417)
,p_db_column_name=>'TEXT'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Text'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382484147563296417)
,p_db_column_name=>'TIME_STAMP'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Time Stamp'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'DD-MON-YYYY HH24:MI:SS'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382486909345296418)
,p_db_column_name=>'UNIT_NAME'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Unit Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(382485787812296418)
,p_db_column_name=>'USER_NAME'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'User Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(382493166660303062)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'3824932'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LOGGER_LEVEL:TEXT:TIME_STAMP:SCOPE:MODULE:ACTION:USER_NAME:SCN'
,p_sort_column_1=>'TIME_STAMP'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382491477110296423)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(382482473407296415)
,p_button_name=>'CREATE'
,p_static_id=>'create'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:410:&SESSION.::&DEBUG.:410'
,p_grid_new_row=>'Y'
);
end;
/
prompt --application/pages/page_00410
begin
wwv_flow_imp_page.create_page(
 p_id=>410
,p_name=>'Log'
,p_alias=>'LOG'
,p_step_title=>'Log'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382490801523296423)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(381906105739018350)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382467233093296401)
,p_plug_name=>'Log'
,p_static_id=>'log'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'LOGGER_LOGS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_read_only_when_type=>'ALWAYS'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382479228102296410)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:400:&SESSION.::&DEBUG.'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382480690080296412)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_button_name=>'CREATE'
,p_static_id=>'create'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'CREATE'
,p_button_condition=>'P410_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_grid_new_row=>'Y'
,p_database_action=>'INSERT'
,p_required_patch=>wwv_flow_imp.id(381905544746018346)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382479850169296412)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_button_name=>'DELETE'
,p_static_id=>'delete'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P410_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_row=>'Y'
,p_database_action=>'DELETE'
,p_required_patch=>wwv_flow_imp.id(381905544746018346)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382480253854296412)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_button_name=>'SAVE'
,p_static_id=>'save'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CHANGE'
,p_button_condition=>'P410_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_row=>'Y'
,p_database_action=>'UPDATE'
,p_required_patch=>wwv_flow_imp.id(381905544746018346)
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(19852793684103265)
,p_branch_action=>'f?p=&APP_ID.:400:&SESSION.::&DEBUG.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382470497123296406)
,p_name=>'P410_ACTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Action'
,p_source=>'ACTION'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>100
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382471666671296406)
,p_name=>'P410_CALL_STACK'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Call Stack'
,p_source=>'CALL_STACK'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382471299022296406)
,p_name=>'P410_CLIENT_IDENTIFIER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Client Identifier'
,p_source=>'CLIENT_IDENTIFIER'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>255
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382474036092296407)
,p_name=>'P410_CLIENT_INFO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Client Info'
,p_source=>'CLIENT_INFO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>64
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382473214749296407)
,p_name=>'P410_EXTRA'
,p_source_data_type=>'CLOB'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Extra'
,p_source=>'EXTRA'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>255
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382467689942296401)
,p_name=>'P410_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_source=>'ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382472456813296407)
,p_name=>'P410_LINE_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Line No'
,p_source=>'LINE_NO'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>100
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382468039637296403)
,p_name=>'P410_LOGGER_LEVEL'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Logger Level'
,p_source=>'LOGGER_LEVEL'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382470043378296406)
,p_name=>'P410_MODULE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Module'
,p_source=>'MODULE'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>100
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382472828906296407)
,p_name=>'P410_SCN'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Scn'
,p_source=>'SCN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382469630967296404)
,p_name=>'P410_SCOPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Scope'
,p_source=>'SCOPE'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>1000
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382473672327296407)
,p_name=>'P410_SID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Sid'
,p_source=>'SID'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382468427174296403)
,p_name=>'P410_TEXT'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Text'
,p_source=>'TEXT'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382468871398296403)
,p_name=>'P410_TIME_STAMP'
,p_source_data_type=>'TIMESTAMP'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Time Stamp'
,p_source=>'TIME_STAMP'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382472076390296407)
,p_name=>'P410_UNIT_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'Unit Name'
,p_source=>'UNIT_NAME'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>255
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382470822542296406)
,p_name=>'P410_USER_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_item_source_plug_id=>wwv_flow_imp.id(382467233093296401)
,p_prompt=>'User Name'
,p_source=>'USER_NAME'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>255
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(382469374127296404)
,p_validation_name=>'P410_TIME_STAMP must be timestamp'
,p_static_id=>'p410-time-stamp-must-be-timestamp'
,p_validation_sequence=>30
,p_validation=>'P410_TIME_STAMP'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(382468871398296403)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382481499053296414)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(382467233093296401)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Log'
,p_static_id=>'initialize-form-log'
,p_internal_uid=>382481499053296414
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382481893555296414)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(382467233093296401)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Log'
,p_static_id=>'process-form-log'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>382481893555296414
);
end;
/
prompt --application/pages/page_01000
begin
wwv_flow_imp_page.create_page(
 p_id=>1000
,p_name=>'Jobs - Dashboard'
,p_alias=>'JOBS-DASHBOARD'
,p_step_title=>'Jobs - dashboard'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(422972579763875614)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(381906105739018350)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(428267681277295505)
,p_name=>'Health by source'
,p_static_id=>'health-by-source'
,p_template=>4073835273271169698
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_JOBS_HEALTH_BY_SOURCE_VW'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428268104861295510)
,p_query_column_id=>5
,p_column_alias=>'DISABLED_CNT'
,p_column_display_sequence=>50
,p_column_heading=>'Disabled Cnt'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428267711352295506)
,p_query_column_id=>1
,p_column_alias=>'JOB_SOURCE'
,p_column_display_sequence=>10
,p_column_heading=>'Job Source'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428267941664295508)
,p_query_column_id=>3
,p_column_alias=>'PROBLEM_CNT'
,p_column_display_sequence=>30
,p_column_heading=>'Problem Cnt'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428268010612295509)
,p_query_column_id=>4
,p_column_alias=>'RUNNING_CNT'
,p_column_display_sequence=>40
,p_column_heading=>'Running Cnt'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428267832407295507)
,p_query_column_id=>2
,p_column_alias=>'TOTAL_CNT'
,p_column_display_sequence=>20
,p_column_heading=>'Total Cnt'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(428268251830295511)
,p_name=>unistr('Next runs \00B7 60 min')
,p_static_id=>'next-runs-60-min'
,p_template=>4073835273271169698
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_JOBS_NEXT_RUNS_VW'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>5
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428268432118295513)
,p_query_column_id=>2
,p_column_alias=>'JOB_NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Job Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428268528944295514)
,p_query_column_id=>3
,p_column_alias=>'NEXT_RUN_AT'
,p_column_display_sequence=>30
,p_column_heading=>'Next Run At'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428268376614295512)
,p_query_column_id=>1
,p_column_alias=>'OWNER'
,p_column_display_sequence=>10
,p_column_heading=>'Owner'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428268751205295516)
,p_query_column_id=>5
,p_column_alias=>'REPEAT_INTERVAL'
,p_column_display_sequence=>50
,p_column_heading=>'Repeat Interval'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428268620696295515)
,p_query_column_id=>4
,p_column_alias=>'SCHEDULE_TYPE'
,p_column_display_sequence=>40
,p_column_heading=>'Schedule Type'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(428268879714295517)
,p_name=>unistr('Recent failures \00B7 72 h')
,p_static_id=>'recent-failures-72-h'
,p_template=>4073835273271169698
,p_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_JOBS_RECENT_FAILURES_VW'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428269617049295525)
,p_query_column_id=>8
,p_column_alias=>'ADDITIONAL_INFO'
,p_column_display_sequence=>80
,p_column_heading=>'Additional Info'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428269334306295522)
,p_query_column_id=>5
,p_column_alias=>'ERROR_CODE'
,p_column_display_sequence=>50
,p_column_heading=>'Error Code'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428269148576295520)
,p_query_column_id=>3
,p_column_alias=>'JOB_NAME'
,p_column_display_sequence=>30
,p_column_heading=>'Job Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428268946820295518)
,p_query_column_id=>1
,p_column_alias=>'LOG_ID'
,p_column_display_sequence=>10
,p_column_heading=>'Log Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428269053044295519)
,p_query_column_id=>2
,p_column_alias=>'OWNER'
,p_column_display_sequence=>20
,p_column_heading=>'Owner'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428269508981295524)
,p_query_column_id=>7
,p_column_alias=>'RUN_SECS'
,p_column_display_sequence=>70
,p_column_heading=>'Run Secs'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428269465525295523)
,p_query_column_id=>6
,p_column_alias=>'STARTED_AT'
,p_column_display_sequence=>60
,p_column_heading=>'Started At'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428269228389295521)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>40
,p_column_heading=>'Status'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(428267253271295501)
,p_name=>'Status'
,p_static_id=>'status'
,p_template=>4073835273271169698
,p_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors:t-BadgeList--medium:t-BadgeList--dash:t-BadgeList--fixed:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_JOBS_STATUS_VW'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2106120299521025145
,p_query_num_rows=>1
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428269945246295528)
,p_query_column_id=>3
,p_column_alias=>'BROKEN_OR_FAILED'
,p_column_display_sequence=>30
,p_column_heading=>'Broken Or Failed'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428269842616295527)
,p_query_column_id=>2
,p_column_alias=>'ENABLED'
,p_column_display_sequence=>20
,p_column_heading=>'Enabled'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428270136159295530)
,p_query_column_id=>5
,p_column_alias=>'FAILED_RUNS_24H'
,p_column_display_sequence=>50
,p_column_heading=>'Failed Runs 24h'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428270043663295529)
,p_query_column_id=>4
,p_column_alias=>'RUNNING_NOW'
,p_column_display_sequence=>40
,p_column_heading=>'Running Now'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428269703976295526)
,p_query_column_id=>1
,p_column_alias=>'VISIBLE_JOBS'
,p_column_display_sequence=>10
,p_column_heading=>'Visible Jobs'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
end;
/
prompt --application/pages/page_01100
begin
wwv_flow_imp_page.create_page(
 p_id=>1100
,p_name=>' Inventory'
,p_alias=>'INVENTORY'
,p_step_title=>' Inventory'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(422975217770897996)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(381906105739018350)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(422975880640897998)
,p_plug_name=>' Inventory'
,p_static_id=>'inventory'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_JOBS_INVENTORY_VW'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>' Inventory'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(422975994900897998)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>422975994900897998
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422985916547898014)
,p_db_column_name=>'APEX_USER'
,p_display_order=>25
,p_column_identifier=>'Y'
,p_column_label=>'Apex User'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422984317157898012)
,p_db_column_name=>'AUTO_DROP'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Auto Drop'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422985516373898014)
,p_db_column_name=>'CLIENT_ID'
,p_display_order=>24
,p_column_identifier=>'X'
,p_column_label=>'Client Id'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422986738947898014)
,p_db_column_name=>'COMMENTS'
,p_display_order=>27
,p_column_identifier=>'AA'
,p_column_label=>'Comments'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422978398450898007)
,p_db_column_name=>'ENABLED'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Enabled'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422983167033898012)
,p_db_column_name=>'FAILURE_COUNT'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Failure Count'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422986362512898014)
,p_db_column_name=>'JOB_ACTION_HEAD'
,p_display_order=>26
,p_column_identifier=>'Z'
,p_column_label=>'Job Action Head'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422979108969898009)
,p_db_column_name=>'JOB_CLASS'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Job Class'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422985158059898012)
,p_db_column_name=>'JOB_CREATOR'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>'Job Creator'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422976746863898006)
,p_db_column_name=>'JOB_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Job Name'
,p_column_link=>'f?p=&APP_ID.:1200:&SESSION.::&DEBUG.::P1200_OWNER,P1200_JOB_NAME:#OWNER#,#JOB_NAME#'
,p_column_linktext=>'#JOB_NAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422977566136898007)
,p_db_column_name=>'JOB_SOURCE'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Job Source'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422977142406898007)
,p_db_column_name=>'JOB_SUBNAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Job Subname'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422978796127898009)
,p_db_column_name=>'JOB_TYPE'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Job Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422981936621898010)
,p_db_column_name=>'LAST_RUN_SECS'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Last Run Secs'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422981538958898010)
,p_db_column_name=>'LAST_START_DATE'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Last Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422983956859898012)
,p_db_column_name=>'MAX_RUNS'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Max Runs'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422982327242898010)
,p_db_column_name=>'NEXT_RUN_DATE'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Next Run Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422984756213898012)
,p_db_column_name=>'ONE_SHOT_YN'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'One Shot Yn'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422976378866898003)
,p_db_column_name=>'OWNER'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422980308350898009)
,p_db_column_name=>'PROGRAM_NAME'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Program Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422979946186898009)
,p_db_column_name=>'REPEAT_INTERVAL'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Repeat Interval'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422983578459898012)
,p_db_column_name=>'RETRY_COUNT'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Retry Count'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422982777396898010)
,p_db_column_name=>'RUN_COUNT'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Run Count'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422980705637898010)
,p_db_column_name=>'SCHEDULE_NAME'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Schedule Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422979530670898009)
,p_db_column_name=>'SCHEDULE_TYPE'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Schedule Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422981151795898010)
,p_db_column_name=>'START_DATE'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(422977990199898007)
,p_db_column_name=>'STATE'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'State'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(423013025673929082)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'4230131'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'OWNER:JOB_NAME:JOB_SUBNAME:JOB_SOURCE:STATE:ENABLED:JOB_TYPE:JOB_CLASS:SCHEDULE_TYPE:REPEAT_INTERVAL:PROGRAM_NAME:SCHEDULE_NAME:START_DATE:LAST_START_DATE:LAST_RUN_SECS:NEXT_RUN_DATE:RUN_COUNT:FAILURE_COUNT:RETRY_COUNT:MAX_RUNS:AUTO_DROP:ONE_SHOT_YN:'
||'JOB_CREATOR:CLIENT_ID:APEX_USER:JOB_ACTION_HEAD:COMMENTS'
);
end;
/
prompt --application/pages/page_01200
begin
wwv_flow_imp_page.create_page(
 p_id=>1200
,p_name=>'Job - Details'
,p_alias=>'JOB-DETAILS'
,p_step_title=>'Job - Details'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(422988109211905198)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(381906105739018350)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(422988717472905200)
,p_name=>'Job - Details'
,p_static_id=>'job-details'
,p_template=>2102002977963900996
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--fixedLabelLarge:t-AVPList--leftAligned:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_JOB_DETAILS_VW'
,p_query_where=>wwv_flow_string.join(wwv_flow_t_varchar2(
'owner = :P1200_OWNER',
'  and job_name = :P1200_JOB_NAME'))
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P1200_OWNER,P1200_JOB_NAME'
,p_lazy_loading=>false
,p_query_row_template=>2101991776017792140
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428286945451424203)
,p_query_column_id=>20
,p_column_alias=>'AUTO_DROP'
,p_column_display_sequence=>200
,p_column_heading=>'Auto Drop'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428288108369424215)
,p_query_column_id=>32
,p_column_alias=>'CLIENT_ID'
,p_column_display_sequence=>320
,p_column_heading=>'Client Id'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428288259629424216)
,p_query_column_id=>33
,p_column_alias=>'COMMENTS'
,p_column_display_sequence=>330
,p_column_heading=>'Comments'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428270923335295538)
,p_query_column_id=>5
,p_column_alias=>'ENABLED'
,p_column_display_sequence=>50
,p_column_heading=>'Enabled'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428272051556295549)
,p_query_column_id=>16
,p_column_alias=>'END_DATE'
,p_column_display_sequence=>160
,p_column_heading=>'End Date'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428287584042424209)
,p_query_column_id=>26
,p_column_alias=>'FAILURE_COUNT'
,p_column_display_sequence=>260
,p_column_heading=>'Failure Count'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428271109989295540)
,p_query_column_id=>7
,p_column_alias=>'JOB_ACTION'
,p_column_display_sequence=>70
,p_column_heading=>'Job Action'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428272125341295550)
,p_query_column_id=>17
,p_column_alias=>'JOB_CLASS'
,p_column_display_sequence=>170
,p_column_heading=>'Job Class'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428288065606424214)
,p_query_column_id=>31
,p_column_alias=>'JOB_CREATOR'
,p_column_display_sequence=>310
,p_column_heading=>'Job Creator'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428270642546295535)
,p_query_column_id=>2
,p_column_alias=>'JOB_NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Job Name'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428286759711424201)
,p_query_column_id=>18
,p_column_alias=>'JOB_PRIORITY'
,p_column_display_sequence=>180
,p_column_heading=>'Job Priority'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428270709180295536)
,p_query_column_id=>3
,p_column_alias=>'JOB_SUBNAME'
,p_column_display_sequence=>30
,p_column_heading=>'Job Subname'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428271077765295539)
,p_query_column_id=>6
,p_column_alias=>'JOB_TYPE'
,p_column_display_sequence=>60
,p_column_heading=>'Job Type'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428287841870424212)
,p_query_column_id=>29
,p_column_alias=>'LAST_RUN_SECS'
,p_column_display_sequence=>290
,p_column_heading=>'Last Run Secs'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428287714088424211)
,p_query_column_id=>28
,p_column_alias=>'LAST_START_DATE'
,p_column_display_sequence=>280
,p_column_heading=>'Last Start Date'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428287327857424207)
,p_query_column_id=>24
,p_column_alias=>'LOGGING_LEVEL'
,p_column_display_sequence=>240
,p_column_heading=>'Logging Level'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428287195543424205)
,p_query_column_id=>22
,p_column_alias=>'MAX_FAILURES'
,p_column_display_sequence=>220
,p_column_heading=>'Max Failures'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428287040976424204)
,p_query_column_id=>21
,p_column_alias=>'MAX_RUNS'
,p_column_display_sequence=>210
,p_column_heading=>'Max Runs'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428287270538424206)
,p_query_column_id=>23
,p_column_alias=>'MAX_RUN_DURATION'
,p_column_display_sequence=>230
,p_column_heading=>'Max Run Duration'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428287976115424213)
,p_query_column_id=>30
,p_column_alias=>'NEXT_RUN_DATE'
,p_column_display_sequence=>300
,p_column_heading=>'Next Run Date'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428271292357295541)
,p_query_column_id=>8
,p_column_alias=>'NUMBER_OF_ARGUMENTS'
,p_column_display_sequence=>80
,p_column_heading=>'Number Of Arguments'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428270566759295534)
,p_query_column_id=>1
,p_column_alias=>'OWNER'
,p_column_display_sequence=>10
,p_column_heading=>'Owner'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428271484226295543)
,p_query_column_id=>10
,p_column_alias=>'PROGRAM_NAME'
,p_column_display_sequence=>100
,p_column_heading=>'Program Name'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428271330161295542)
,p_query_column_id=>9
,p_column_alias=>'PROGRAM_OWNER'
,p_column_display_sequence=>90
,p_column_heading=>'Program Owner'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428271801648295547)
,p_query_column_id=>14
,p_column_alias=>'REPEAT_INTERVAL'
,p_column_display_sequence=>140
,p_column_heading=>'Repeat Interval'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428286816806424202)
,p_query_column_id=>19
,p_column_alias=>'RESTARTABLE'
,p_column_display_sequence=>190
,p_column_heading=>'Restartable'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428287607860424210)
,p_query_column_id=>27
,p_column_alias=>'RETRY_COUNT'
,p_column_display_sequence=>270
,p_column_heading=>'Retry Count'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428287497816424208)
,p_query_column_id=>25
,p_column_alias=>'RUN_COUNT'
,p_column_display_sequence=>250
,p_column_heading=>'Run Count'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428271604552295545)
,p_query_column_id=>12
,p_column_alias=>'SCHEDULE_NAME'
,p_column_display_sequence=>120
,p_column_heading=>'Schedule Name'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428271512129295544)
,p_query_column_id=>11
,p_column_alias=>'SCHEDULE_OWNER'
,p_column_display_sequence=>110
,p_column_heading=>'Schedule Owner'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428271781553295546)
,p_query_column_id=>13
,p_column_alias=>'SCHEDULE_TYPE'
,p_column_display_sequence=>130
,p_column_heading=>'Schedule Type'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428271975680295548)
,p_query_column_id=>15
,p_column_alias=>'START_DATE'
,p_column_display_sequence=>150
,p_column_heading=>'Start Date'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428270836203295537)
,p_query_column_id=>4
,p_column_alias=>'STATE'
,p_column_display_sequence=>40
,p_column_heading=>'State'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(428270409564295533)
,p_name=>'P1200_JOB_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(422988717472905200)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(428270313410295532)
,p_name=>'P1200_OWNER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(422988717472905200)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
end;
/
prompt --application/pages/page_01300
begin
wwv_flow_imp_page.create_page(
 p_id=>1300
,p_name=>'Job-Executions'
,p_alias=>'JOB-EXECUTIONS'
,p_step_title=>'Job-Executions'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(423004037104911410)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(381906105739018350)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(423004699062911412)
,p_plug_name=>'Job-Executions'
,p_static_id=>'job-executions'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_JOB_EXECUTIONS_VW'
,p_query_where=>wwv_flow_string.join(wwv_flow_t_varchar2(
'log_date >= systimestamp - numtodsinterval(nvl(:P1030_DAYS, 7), ''day'')',
'  and (:P1030_STATUS   is null or status   = :P1030_STATUS)',
'  and (:P1030_JOB_NAME is null or job_name = :P1030_JOB_NAME)'))
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Job-Executions'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(423004790235911412)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>423004790235911412
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423007548196911415)
,p_db_column_name=>'ACTUAL_START_DATE'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Actual Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423009526985911415)
,p_db_column_name=>'ADDITIONAL_INFO'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Additional Info'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423008717448911415)
,p_db_column_name=>'CPU_SECS'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Cpu Secs'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423010393559911417)
,p_db_column_name=>'CURRENT_STATE'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Current State'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423007157028911414)
,p_db_column_name=>'ERROR_CODE'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Error Code'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423010752708911417)
,p_db_column_name=>'JOB_CLASS'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Job Class'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423009991360911417)
,p_db_column_name=>'JOB_DROPPED_YN'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Job Dropped Yn'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423005939915911414)
,p_db_column_name=>'JOB_NAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Job Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423006328060911414)
,p_db_column_name=>'JOB_SUBNAME'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Job Subname'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423005137436911414)
,p_db_column_name=>'LOG_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Log Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423005527538911414)
,p_db_column_name=>'OWNER'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423007962371911415)
,p_db_column_name=>'REQ_START_DATE'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Req Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423008314837911415)
,p_db_column_name=>'RUN_SECS'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Run Secs'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423009126412911415)
,p_db_column_name=>'SESSION_ID'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Session Id'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(423006798643911414)
,p_db_column_name=>'STATUS'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(423011192131913410)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'4230112'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LOG_ID:OWNER:JOB_NAME:JOB_SUBNAME:STATUS:ERROR_CODE:ACTUAL_START_DATE:REQ_START_DATE:RUN_SECS:CPU_SECS:SESSION_ID:ADDITIONAL_INFO:JOB_DROPPED_YN:CURRENT_STATE:JOB_CLASS'
);
end;
/
prompt --application/pages/page_01400
begin
wwv_flow_imp_page.create_page(
 p_id=>1400
,p_name=>'Running now '
,p_alias=>'RUNNING-NOW'
,p_step_title=>'Running now '
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(422974168485887415)
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(428263454437277907)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(381906105739018350)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(428288326166424217)
,p_name=>'Running now '
,p_static_id=>'running-now'
,p_template=>4073835273271169698
,p_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_JOBS_RUNNING_VW'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No jobs are currently running.'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428288852871424222)
,p_query_column_id=>5
,p_column_alias=>'CPU_SECS'
,p_column_display_sequence=>50
,p_column_heading=>'Cpu Secs'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428288786559424221)
,p_query_column_id=>4
,p_column_alias=>'ELAPSED_SECS'
,p_column_display_sequence=>40
,p_column_heading=>'Elapsed Secs'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428289778863424231)
,p_query_column_id=>14
,p_column_alias=>'JOB_ACTION_HEAD'
,p_column_display_sequence=>140
,p_column_heading=>'Job Action Head'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428289386651424227)
,p_query_column_id=>10
,p_column_alias=>'JOB_CLASS'
,p_column_display_sequence=>100
,p_column_heading=>'Job Class'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428288532183424219)
,p_query_column_id=>2
,p_column_alias=>'JOB_NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Job Name'
,p_column_link=>'f?p=&APP_ID.:1200:&SESSION.::&DEBUG.::P1200_OWNER,P1200_JOB_NAME:#OWNER#,#JOB_NAME#'
,p_column_linktext=>'#JOB_NAME#'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428288647759424220)
,p_query_column_id=>3
,p_column_alias=>'JOB_SUBNAME'
,p_column_display_sequence=>30
,p_column_heading=>'Job Subname'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428289254683424226)
,p_query_column_id=>9
,p_column_alias=>'JOB_TYPE'
,p_column_display_sequence=>90
,p_column_heading=>'Job Type'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428289500414424229)
,p_query_column_id=>12
,p_column_alias=>'MAX_RUN_DURATION'
,p_column_display_sequence=>120
,p_column_heading=>'Max Run Duration'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428289678736424230)
,p_query_column_id=>13
,p_column_alias=>'OVER_MAX_DURATION_YN'
,p_column_display_sequence=>130
,p_column_heading=>'Over Max Duration Yn'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428288445368424218)
,p_query_column_id=>1
,p_column_alias=>'OWNER'
,p_column_display_sequence=>10
,p_column_heading=>'Owner'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428289150694424225)
,p_query_column_id=>8
,p_column_alias=>'RESOURCE_CONSUMER_GROUP'
,p_column_display_sequence=>80
,p_column_heading=>'Resource Consumer Group'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428288904252424223)
,p_query_column_id=>6
,p_column_alias=>'SESSION_ID'
,p_column_display_sequence=>60
,p_column_heading=>'Session Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428289031983424224)
,p_query_column_id=>7
,p_column_alias=>'SLAVE_PROCESS_ID'
,p_column_display_sequence=>70
,p_column_heading=>'Slave Process Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428289402671424228)
,p_query_column_id=>11
,p_column_alias=>'STATE'
,p_column_display_sequence=>110
,p_column_heading=>'State'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
end;
/
prompt --application/pages/page_01500
begin
wwv_flow_imp_page.create_page(
 p_id=>1500
,p_name=>'Timeline'
,p_alias=>'TIMELINE'
,p_step_title=>'Timeline'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(422974168485887415)
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(428265091658282521)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(381906105739018350)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
end;
/
prompt --application/pages/page_01600
begin
wwv_flow_imp_page.create_page(
 p_id=>1600
,p_name=>'APEX Automations'
,p_alias=>'APEX-AUTOMATIONS'
,p_step_title=>'APEX Automations'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(422974168485887415)
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(428289904590424233)
,p_name=>'Automations'
,p_static_id=>'automations'
,p_template=>4073835273271169698
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_APEX_AUTOMATIONS_VW'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428290035832424234)
,p_query_column_id=>1
,p_column_alias=>'APPLICATION_ID'
,p_column_display_sequence=>10
,p_column_heading=>'Application Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428290103981424235)
,p_query_column_id=>2
,p_column_alias=>'APPLICATION_NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Application Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428290220347424236)
,p_query_column_id=>3
,p_column_alias=>'AUTOMATION_NAME'
,p_column_display_sequence=>30
,p_column_heading=>'Automation Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428291514273424249)
,p_query_column_id=>16
,p_column_alias=>'BUILD_OPTION'
,p_column_display_sequence=>160
,p_column_heading=>'Build Option'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428291689688424250)
,p_query_column_id=>17
,p_column_alias=>'COMPONENT_COMMENT'
,p_column_display_sequence=>170
,p_column_heading=>'Component Comment'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428291451711424248)
,p_query_column_id=>15
,p_column_alias=>'ERROR_HANDLING_TYPE'
,p_column_display_sequence=>150
,p_column_heading=>'Error Handling Type'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428290724685424241)
,p_query_column_id=>8
,p_column_alias=>'LAST_RUN_ON'
,p_column_display_sequence=>80
,p_column_heading=>'Last Run On'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428320694860523301)
,p_query_column_id=>18
,p_column_alias=>'LAST_UPDATED_ON'
,p_column_display_sequence=>180
,p_column_heading=>'Last Updated On'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428291312730424247)
,p_query_column_id=>14
,p_column_alias=>'MAX_ROWS_TO_PROCESS'
,p_column_display_sequence=>140
,p_column_heading=>'Max Rows To Process'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428290824117424242)
,p_query_column_id=>9
,p_column_alias=>'NEXT_RUN_ON'
,p_column_display_sequence=>90
,p_column_heading=>'Next Run On'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428290576803424239)
,p_query_column_id=>6
,p_column_alias=>'POLLING_INTERVAL'
,p_column_display_sequence=>60
,p_column_heading=>'Polling Interval'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428290677592424240)
,p_query_column_id=>7
,p_column_alias=>'POLLING_STATUS'
,p_column_display_sequence=>70
,p_column_heading=>'Polling Status'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428291099137424244)
,p_query_column_id=>11
,p_column_alias=>'QUERY_TYPE'
,p_column_display_sequence=>110
,p_column_heading=>'Query Type'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428290949340424243)
,p_query_column_id=>10
,p_column_alias=>'RESULT_TYPE'
,p_column_display_sequence=>100
,p_column_heading=>'Result Type'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428290370606424237)
,p_query_column_id=>4
,p_column_alias=>'STATIC_ID'
,p_column_display_sequence=>40
,p_column_heading=>'Static Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428291291349424246)
,p_query_column_id=>13
,p_column_alias=>'TABLE_NAME'
,p_column_display_sequence=>130
,p_column_heading=>'Table Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428291149043424245)
,p_query_column_id=>12
,p_column_alias=>'TABLE_OWNER'
,p_column_display_sequence=>120
,p_column_heading=>'Table Owner'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428290429634424238)
,p_query_column_id=>5
,p_column_alias=>'TRIGGER_TYPE'
,p_column_display_sequence=>50
,p_column_heading=>'Trigger Type'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(428266663039285620)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(381906105739018350)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(428320785947523302)
,p_name=>unistr('Executions \00B7 7 days')
,p_static_id=>'executions-7-days'
,p_template=>4073835273271169698
,p_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_APEX_AUTOMATION_EXECUTIONS_VW'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428320983955523304)
,p_query_column_id=>2
,p_column_alias=>'APPLICATION_ID'
,p_column_display_sequence=>20
,p_column_heading=>'Application Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428321017873523305)
,p_query_column_id=>3
,p_column_alias=>'AUTOMATION_NAME'
,p_column_display_sequence=>30
,p_column_heading=>'Automation Name'
,p_column_link=>'f?p=&APP_ID.:1600:&SESSION.::&DEBUG.:1600:P1600_LOG_ID:#LOG_ID#'
,p_column_linktext=>'#AUTOMATION_NAME#'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428321407951523309)
,p_query_column_id=>7
,p_column_alias=>'DURATION_SECS'
,p_column_display_sequence=>70
,p_column_heading=>'Duration Secs'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428321616453523311)
,p_query_column_id=>9
,p_column_alias=>'ERROR_ROW_COUNT'
,p_column_display_sequence=>90
,p_column_heading=>'Error Row Count'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428321296942523307)
,p_query_column_id=>5
,p_column_alias=>'IS_JOB'
,p_column_display_sequence=>50
,p_column_heading=>'Is Job'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428320839193523303)
,p_query_column_id=>1
,p_column_alias=>'LOG_ID'
,p_column_display_sequence=>10
,p_column_heading=>'Log Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428321371910523308)
,p_query_column_id=>6
,p_column_alias=>'STARTED_AT'
,p_column_display_sequence=>60
,p_column_heading=>'Started At'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428321135751523306)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>40
,p_column_heading=>'Status'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428321521406523310)
,p_query_column_id=>8
,p_column_alias=>'SUCCESSFUL_ROW_COUNT'
,p_column_display_sequence=>80
,p_column_heading=>'Successful Row Count'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(428321756780523312)
,p_name=>'Messages'
,p_static_id=>'messages'
,p_template=>4073835273271169698
,p_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'ERSH_APEX_AUTOMATION_MESSAGES_VW'
,p_query_where=>'(:P1600_LOG_ID is null or automation_log_id = :P1600_LOG_ID)'
,p_include_rowid_column=>false
,p_display_when_condition=>'P1600_LOG_ID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P1600_LOG_ID'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428322104543523316)
,p_query_column_id=>4
,p_column_alias=>'ACTION_NAME'
,p_column_display_sequence=>40
,p_column_heading=>'Action Name'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428321864250523313)
,p_query_column_id=>1
,p_column_alias=>'AUTOMATION_LOG_ID'
,p_column_display_sequence=>10
,p_column_heading=>'Automation Log Id'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428322303494523318)
,p_query_column_id=>6
,p_column_alias=>'MESSAGE'
,p_column_display_sequence=>60
,p_column_heading=>'Message'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428321943253523314)
,p_query_column_id=>2
,p_column_alias=>'MESSAGE_AT'
,p_column_display_sequence=>20
,p_column_heading=>'Message At'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428322072148523315)
,p_query_column_id=>3
,p_column_alias=>'MESSAGE_TYPE'
,p_column_display_sequence=>30
,p_column_heading=>'Message Type'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(428322231018523317)
,p_query_column_id=>5
,p_column_alias=>'PK_VALUE'
,p_column_display_sequence=>50
,p_column_heading=>'Pk Value'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(428322449998523319)
,p_name=>'P1600_LOG_ID'
,p_item_sequence=>10
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
end;
/
prompt --application/pages/page_09999
begin
wwv_flow_imp_page.create_page(
 p_id=>9999
,p_name=>'Login Page'
,p_alias=>'LOGIN'
,p_step_title=>'Error Shield - Log In'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2102634289808461002
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382098467923018521)
,p_plug_name=>'Error Shield'
,p_static_id=>'error-shield'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675634334296186762
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382101174545018529)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(382098467923018521)
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
 p_id=>wwv_flow_imp.id(382099150674018525)
,p_name=>'P9999_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(382098467923018521)
,p_prompt=>'Password'
,p_placeholder=>'Password'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>2042262243893469891
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382100253374018528)
,p_name=>'P9999_REMEMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(382098467923018521)
,p_prompt=>'Remember username'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOGIN_REMEMBER_USERNAME'
,p_label_alignment=>'RIGHT'
,p_display_when=>'apex_authentication.persistent_cookies_enabled'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>2042262243893469891
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'If you select this checkbox, the application will save your username in a persistent browser cookie named "LOGIN_USERNAME_COOKIE".',
'When you go to the login page the next time,',
'the username field will be automatically populated with this value.',
'</p>',
'<p>',
'If you deselect this checkbox and your username is already saved in the cookie,',
'the application will overwrite it with an empty value.',
'You can also use your browser''s developer tools to completely remove the cookie.',
'</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '1')).to_clob
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>':'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382098888680018523)
,p_name=>'P9999_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(382098467923018521)
,p_prompt=>'Username'
,p_placeholder=>'Username'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>2042262243893469891
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382102723869018531)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_static_id=>'clear-page-s-cache'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'type', 'CLEAR_CACHE_CURRENT_PAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>382102723869018531
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382102370663018531)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_static_id=>'get-username-cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P9999_USERNAME := apex_authentication.get_login_username_cookie;',
':P9999_REMEMBER := case when :P9999_USERNAME is not null then ''Y'' end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>382102370663018531
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382101549119018531)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_static_id=>'login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P9999_USERNAME,',
'    p_password => :P9999_PASSWORD );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>382101549119018531
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382101905375018531)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_static_id=>'set-username-cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P9999_USERNAME),',
'    p_consent  => :P9999_REMEMBER = ''Y'' );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>382101905375018531
);
end;
/
prompt --application/pages/page_10000
begin
wwv_flow_imp_page.create_page(
 p_id=>10000
,p_name=>'Administration'
,p_alias=>'ADMIN'
,p_step_title=>'Administration'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(382097521246018512)
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(382097282347018512)
,p_protection_level=>'C'
,p_deep_linking=>'N'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The administration page allows application owners (Administrators) to configure the application and maintain common data used across the application.',
'By selecting one of the available settings, administrators can potentially change how the application is displayed and/or features available to the end users.</p>',
'<p>Access to this page should be limited to Administrators only.</p>'))
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382115982740018567)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(381906105739018350)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382117263793018567)
,p_plug_name=>'Column 1'
,p_static_id=>'column'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3372714138756020509
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382117690527018567)
,p_plug_name=>'User Interface'
,p_static_id=>'user-interface'
,p_parent_plug_id=>wwv_flow_imp.id(382117263793018567)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>50
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_list_id=>wwv_flow_imp.id(382116524098018567)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2069471208528591807
,p_required_patch=>wwv_flow_imp.id(382096531916018510)
);
end;
/
prompt --application/pages/page_10010
begin
wwv_flow_imp_page.create_page(
 p_id=>10010
,p_name=>'Application Appearance'
,p_alias=>'APPLICATION-APPEARANCE'
,p_page_mode=>'MODAL'
,p_step_title=>'Application Appearance'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(382097521246018512)
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(382097282347018512)
,p_required_patch=>wwv_flow_imp.id(382096531916018510)
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Select the default color scheme used to display the application.</p>',
'<p>If <strong>Allow End Users to choose Theme Style</strong> is checked, then each end user can select from the available theme styles by clicking the <em>Customize</em> link in the bottom left corner of the Home page.</p>'))
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382104546553018548)
,p_plug_name=>'Buttons'
,p_static_id=>'buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382104686548018548)
,p_plug_name=>'Configure Appearance'
,p_static_id=>'configure-appearance'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'BELOW'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382105691302018550)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(382104546553018548)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA_ACTION'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Cancel'
,p_button_position=>'PREVIOUS'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_component_da_action(
 p_id=>wwv_flow_imp.id(382106450197018551)
,p_button_id=>wwv_flow_imp.id(382105691302018550)
,p_action_sequence=>10
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_static_id=>'native-dialog-cancel'
,p_stop_execution_on_error=>true
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(382107083249018551)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(382104546553018548)
,p_button_name=>'SAVE'
,p_static_id=>'save'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(19853983854103325)
,p_branch_name=>'Branch to Admin Page'
,p_branch_action=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:RP&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382107701727018553)
,p_name=>'P10010_DESKTOP_THEME_STYLE_ID'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(382104686548018548)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Desktop Theme Style'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.theme_style_id',
'from apex_application_theme_styles s,',
'    apex_application_themes t',
'where s.application_id = t.application_id',
'    and s.theme_number = t.theme_number',
'    and s.application_id = :app_id',
'    and t.ui_type_name   = ''DESKTOP''',
'    and s.is_current = ''Yes'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'DESKTOP THEME STYLES'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select null',
'  from apex_application_theme_styles s,',
'       apex_application_themes t',
' where s.application_id = t.application_id',
'   and s.theme_number   = t.theme_number',
'   and s.application_id = :app_id',
'   and t.ui_type_name   = ''DESKTOP'''))
,p_display_when_type=>'EXISTS'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_restricted_characters=>'WEB_SAFE'
,p_inline_help_text=>'The default Theme Style applies to all users.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382108443176018559)
,p_name=>'P10010_END_USER_STYLE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(382104686548018548)
,p_use_cache_before_default=>'NO'
,p_prompt=>'End User Theme Preference'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ui.theme_style_by_user_pref',
'  from apex_application_themes t, apex_appl_user_interfaces ui',
' where ui.application_id = t.application_id',
'   and ui.theme_number   = t.theme_number',
'   and t.application_id  = :app_id ',
'   and t.ui_type_name    = ''DESKTOP''',
'   and t.is_current      = ''Yes'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'USER_THEME_PREFERENCE'
,p_grid_label_column_span=>0
,p_field_template=>2042262243893469891
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_inline_help_text=>'If checked, end users may choose their own Theme Style using the Customize link.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '1')).to_clob
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>':'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382110027863018560)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save End User Style Preference'
,p_static_id=>'save-end-user-style-preference'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_enabled boolean := case when :P10010_END_USER_STYLE = ''Yes'' then true else false end;',
'begin',
'    for l_theme in ( select ui.theme_number',
'                       from apex_application_themes t,',
'                            apex_appl_user_interfaces ui',
'                      where ui.application_id = t.application_id',
'                        and ui.theme_number   = t.theme_number',
'                        and t.application_id  = :APP_ID',
'                        and t.ui_type_name    = ''DESKTOP''',
'                        and t.is_current      = ''Yes'' )',
'    loop',
'        if l_enabled then',
'            apex_theme.enable_user_style (',
'                p_application_id => :APP_ID,',
'                p_theme_number   => l_theme.theme_number );',
'        else',
'            apex_theme.disable_user_style (',
'                p_application_id => :APP_ID,',
'                p_theme_number   => l_theme.theme_number );',
'            apex_theme.clear_all_users_style(:APP_ID);',
'        end if;',
'    end loop;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Application Appearance Settings Saved.'
,p_internal_uid=>382110027863018560
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(382109608216018560)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Theme Style'
,p_static_id=>'save-theme-style'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P10010_DESKTOP_THEME_STYLE_ID is not null then',
'    for l_theme in (select theme_number',
'                      from apex_application_themes',
'                     where application_id = :app_id',
'                       and ui_type_name   = ''DESKTOP''',
'                       and is_current     = ''Yes'')',
'    loop',
'        apex_util.set_current_theme_style (',
'            p_theme_number   => l_theme.theme_number,',
'            p_theme_style_id => :P10010_DESKTOP_THEME_STYLE_ID',
'            );',
'    end loop;',
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Application Appearance Settings Saved.'
,p_internal_uid=>382109608216018560
);
end;
/
prompt --application/pages/page_10020
begin
wwv_flow_imp_page.create_page(
 p_id=>10020
,p_name=>'About'
,p_alias=>'HELP'
,p_step_title=>'About'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(382097521246018512)
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_required_patch=>wwv_flow_imp.id(382096455746018510)
,p_protection_level=>'C'
,p_help_text=>'All application help text can be accessed from this page. The links in the "Documentation" region give a much more in-depth explanation of the application''s features and functionality.'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382110846157018560)
,p_plug_name=>'About Page'
,p_static_id=>'about-page'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--padded:t-ContentBlock--h1:t-ContentBlock--lightBG'
,p_plug_template=>2323592004483952560
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>'Text about this application can be placed here.'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
end;
/
prompt --application/pages/page_10021
begin
wwv_flow_imp_page.create_page(
 p_id=>10021
,p_name=>'Help'
,p_alias=>'PAGE_HELP'
,p_page_mode=>'MODAL'
,p_step_title=>'Help'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#'
,p_required_patch=>wwv_flow_imp.id(382096455746018510)
,p_dialog_chained=>'N'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(382111555014018562)
,p_plug_name=>'Search Dialog'
,p_static_id=>'search-dialog'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in ',
'(',
'    select page_title, help_text ',
'      from apex_application_pages',
'     where page_id = :P10021_PAGE_ID ',
'       and application_id = :APP_ID',
')',
'loop',
'    if c1.help_text is null then',
'        sys.htp.p(''No help is available for this page.'');',
'    else',
'        if substr(c1.help_text, 1, 3) != ''<p>'' then',
'            sys.htp.p(''<p>'');',
'        end if;',
'',
'        sys.htp.p(apex_application.do_substitutions(c1.help_text));',
'',
'        if substr(trim(c1.help_text), -4) != ''</p>'' then',
'            sys.htp.p(''</p>'');',
'        end if;',
'    end if;',
'end loop;'))
,p_plug_source_type=>'NATIVE_PLSQL'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(382111951747018562)
,p_name=>'P10021_PAGE_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(382111555014018562)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
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
