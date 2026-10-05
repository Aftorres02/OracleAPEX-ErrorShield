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
--   Date and Time:   08:01 Sunday October 4, 2026
--   Exported By:     WKSP_DEVAI1
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                      3
--       Items:                    4
--       Processes:               20
--       Regions:                  8
--       Buttons:                 20
--       Dynamic Actions:          4
--     Shared Components:
--       Logic:
--       Navigation:
--         Lists:                  1
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
,p_files_version=>2461318080026
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
prompt --application/shared_components/navigation/listentry
begin
null;
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
,p_files_version=>2461318080027
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
,p_name=>'Error Lab'
,p_alias=>'HOME'
,p_step_title=>'Error Lab'
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
'   * Refresh the Recent Incidents report so a new incident shows up at once',
'   */',
'  var refreshIncidents = function() {',
'    apex.region(CONFIG.INCIDENTS_REGION).refresh();',
'  };',
'',
'  /**',
'   * Call an AJAX callback that lets its exception escape. APEX routes it',
'   * through the app''s Error Handling Function (ErrorShield) on its own and',
'   * answers with the translated message as an error response.',
'   * @param {string} scenario - elab_errors_api.force_error scenario code',
'   */',
'  var fireUnhandled = function(scenario) {',
'    apex.server.process(',
'      CONFIG.AJAX_UNHANDLED,',
'      { x01: scenario },',
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
'   * @param {string} scenario - elab_errors_api.force_error scenario code',
'   */',
'  var fireHandled = function(scenario) {',
'    apex.server.process(',
'      CONFIG.AJAX_HANDLED,',
'      { x01: scenario },',
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
 p_id=>wwv_flow_imp.id(23878719142209945)
,p_plug_name=>'AJAX Errors'
,p_static_id=>'ajaxSR'
,p_region_name=>'ajaxSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>40
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Pick a scenario and raise it from an AJAX request instead of a page submit. The first two',
'let the exception escape, so APEX hands it to ErrorShield by itself. The third catches it and',
'answers <code>success: false</code>; the Error Handling Function never sees that one, so the',
'callback records the incident itself. The outcome follows the scenario: friendly and business',
'errors still record nothing.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(23878823215209945)
,p_plug_name=>'Rendering and Business Errors'
,p_static_id=>'apexSR'
,p_region_name=>'apexSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>A region that fails while APEX renders the page (its query targets a table that no longer',
'exists), and an intentional business rule raised through',
'<code>ersh_error_handler_api.raise_custom_error</code>.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(23879615353209947)
,p_plug_name=>'Broken Region'
,p_static_id=>'brokenDC'
,p_region_name=>'brokenDC'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>55
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
 p_id=>wwv_flow_imp.id(23878654887209945)
,p_plug_name=>'Table and Column Errors'
,p_static_id=>'dataSR'
,p_region_name=>'dataSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>DML against <code>elab_customers</code> and <code>elab_orders</code>. The two green',
'constraints are registered in <code>ersh_constraint_lookup</code>; the foreign key is deliberately',
'not, so it takes the masked, recorded path.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(23878936215209946)
,p_name=>'Recent Incidents'
,p_static_id=>'incidentsCR'
,p_region_name=>'incidentsCR'
,p_template=>4073835273271169698
,p_display_sequence=>60
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.first_reference_display                                as reference_no',
'     , i.component_name                                         as component_name',
'     , i.ora_sqlcode                                            as ora_sqlcode',
'     , i.error_summary                                          as error_summary',
'     , i.occurrence_count                                       as occurrence_count',
'     , to_char(i.created_on, ''DD-MON HH24:MI:SS'')               as first_seen',
'  from ersh_shield_incidents_vw i',
' where i.application_id = :APP_ID',
' order by i.created_on desc',
' fetch first 10 rows only'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No incidents recorded from this app yet. Click a red button.'
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
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(23879540105209947)
,p_query_column_id=>1
,p_column_alias=>'REFERENCE_NO'
,p_column_display_sequence=>10
,p_column_heading=>'Reference'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(23878490145209944)
,p_plug_name=>'How This Lab Works'
,p_static_id=>'introSR'
,p_region_name=>'introSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Every button below fails <strong>on purpose</strong> with one specific Oracle error. This app''s',
'Error Handling Function is <code>ersh_error_handler_api.apex_error_handling</code>, reached through',
'synonyms from this consumer schema, so each error lands in ErrorShield exactly as it would from a',
'real application.</p>',
'<p><span class="u-danger-text"><strong>Red outline</strong></span>: an unexpected technical error.',
'ErrorShield logs it, records an incident and, when the environment is listed in',
'<code>MASK_IN_ENVIRONMENTS</code>, shows a masked message with a reference number instead of the',
'raw ORA text.<br>',
'<span class="u-success-text"><strong>Green outline</strong></span>: a known error (registered',
'constraint or business rule). The friendly message is shown as written and no incident is',
'recorded.</p>',
'<p>Review every incident in the ErrorShield admin app (10400, Incidents page), or in the',
'<strong>Recent Incidents</strong> report at the bottom of this page.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(23878513550209945)
,p_plug_name=>'PL/SQL Runtime Errors'
,p_static_id=>'runtimeSR'
,p_region_name=>'runtimeSR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Bugs inside <code>elab_errors_api</code>: math, conversions and select-into lookups that fail',
'at runtime.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23881356970209949)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(23878719142209945)
,p_button_name=>'AJAX_DA'
,p_static_id=>'AJAX_DA'
,p_button_static_id=>'AJAX_DA'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Dynamic Action, Execute Server-side Code'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23881471988209949)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(23878719142209945)
,p_button_name=>'AJAX_HANDLED'
,p_static_id=>'AJAX_HANDLED'
,p_button_static_id=>'AJAX_HANDLED'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'AJAX callback, handled JSON response'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23881226309209949)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(23878719142209945)
,p_button_name=>'AJAX_UNHANDLED'
,p_static_id=>'AJAX_UNHANDLED'
,p_button_static_id=>'AJAX_UNHANDLED'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'AJAX callback, unhandled (apex.server.process)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23881114462209949)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(23878823215209945)
,p_button_name=>'BUSINESS_ERROR'
,p_static_id=>'BUSINESS_ERROR'
,p_button_static_id=>'BUSINESS_ERROR'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Order over credit limit (raise_custom_error)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23881001872209949)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(23878654887209945)
,p_button_name=>'CHECK_VIOLATION'
,p_static_id=>'CHECK_VIOLATION'
,p_button_static_id=>'CHECK_VIOLATION'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Quantity zero (ORA-02290)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23880829587209948)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(23878654887209945)
,p_button_name=>'CHILD_FOUND'
,p_static_id=>'CHILD_FOUND'
,p_button_static_id=>'CHILD_FOUND'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Delete a customer with orders (ORA-02292)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23879854129209947)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(23878513550209945)
,p_button_name=>'DIVIDE_BY_ZERO'
,p_static_id=>'DIVIDE_BY_ZERO'
,p_button_static_id=>'DIVIDE_BY_ZERO'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Division by zero (ORA-01476)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23881588658209949)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(23878823215209945)
,p_button_name=>'FORCE_INTERNAL'
,p_static_id=>'FORCE_INTERNAL'
,p_button_static_id=>'FORCE_INTERNAL'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Region fails while rendering (ORA-00942)'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.:FORCE_INTERNAL:&DEBUG.'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23880137114209948)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(23878513550209945)
,p_button_name=>'INVALID_DATE'
,p_static_id=>'INVALID_DATE'
,p_button_static_id=>'INVALID_DATE'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Invalid date, 31-Feb (ORA-01839)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23880059884209948)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(23878513550209945)
,p_button_name=>'INVALID_NUMBER'
,p_static_id=>'INVALID_NUMBER'
,p_button_static_id=>'INVALID_NUMBER'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Text converted to number (ORA-01722)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23880665545209948)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(23878654887209945)
,p_button_name=>'NOT_NULL'
,p_static_id=>'NOT_NULL'
,p_button_static_id=>'NOT_NULL'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Required column left empty (ORA-01400)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23880217820209948)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(23878513550209945)
,p_button_name=>'NO_DATA_FOUND'
,p_static_id=>'NO_DATA_FOUND'
,p_button_static_id=>'NO_DATA_FOUND'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'No data found (ORA-01403)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23880555366209948)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(23878654887209945)
,p_button_name=>'NUMERIC_OVERFLOW'
,p_static_id=>'NUMERIC_OVERFLOW'
,p_button_static_id=>'NUMERIC_OVERFLOW'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Number too large for column (ORA-01438)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23880734215209948)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(23878654887209945)
,p_button_name=>'PARENT_NOT_FOUND'
,p_static_id=>'PARENT_NOT_FOUND'
,p_button_static_id=>'PARENT_NOT_FOUND'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Order for a missing customer (ORA-02291)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
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
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Refresh'
,p_button_position=>'EDIT'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23880371522209948)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(23878513550209945)
,p_button_name=>'TOO_MANY_ROWS'
,p_static_id=>'TOO_MANY_ROWS'
,p_button_static_id=>'TOO_MANY_ROWS'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Too many rows (ORA-01422)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23880990374209949)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(23878654887209945)
,p_button_name=>'UNIQUE_VIOLATION'
,p_static_id=>'UNIQUE_VIOLATION'
,p_button_static_id=>'UNIQUE_VIOLATION'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Duplicate customer code (ORA-00001)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23879916337209947)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(23878513550209945)
,p_button_name=>'VALUE_ERROR'
,p_static_id=>'VALUE_ERROR'
,p_button_static_id=>'VALUE_ERROR'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Value too long for a variable (ORA-06502)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23880487536209948)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(23878654887209945)
,p_button_name=>'VALUE_TOO_LARGE'
,p_static_id=>'VALUE_TOO_LARGE'
,p_button_static_id=>'VALUE_TOO_LARGE'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Text too long for column (ORA-12899)'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(23879757686209947)
,p_name=>'P1_AJAX_SCENARIO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(23878719142209945)
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
 p_id=>wwv_flow_imp.id(23881754454209949)
,p_name=>'AJAX Dynamic Action Error'
,p_static_id=>'ajax-da-click'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(23881356970209949)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23881878393209950)
,p_event_id=>wwv_flow_imp.id(23881754454209949)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'force-error-server-side'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'items_to_submit', 'P1_AJAX_SCENARIO',
  'language', 'PLSQL',
  'plsql_code', wwv_flow_string.join(wwv_flow_t_varchar2(
    'elab_errors_api.force_error(',
    '    p_scenario                       => :P1_AJAX_SCENARIO',
    ');')),
  'show_processing', 'N')).to_clob
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(23881930361209950)
,p_name=>'AJAX Handled Error'
,p_static_id=>'ajax-handled-click'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(23881471988209949)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23882017488209950)
,p_event_id=>wwv_flow_imp.id(23881930361209950)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'fire-handled'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'js_code', 'elab.errorLab.fireHandled(apex.item(''P1_AJAX_SCENARIO'').getValue());')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(23882175107209950)
,p_name=>'AJAX Unhandled Error'
,p_static_id=>'ajax-unhandled-click'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(23881226309209949)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23882210473209950)
,p_event_id=>wwv_flow_imp.id(23882175107209950)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_static_id=>'fire-unhandled'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'js_code', 'elab.errorLab.fireUnhandled(apex.item(''P1_AJAX_SCENARIO'').getValue());')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(23882319819209951)
,p_name=>'Refresh Incidents'
,p_static_id=>'refresh-click'
,p_event_sequence=>40
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
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23883853412209953)
,p_process_sequence=>140
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Order over credit limit (raise_custom_error)'
,p_static_id=>'business-error'
,p_process_sql_clob=>'elab_errors_api.force_business_error;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''BUSINESS_ERROR'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>23883853412209953
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23883720037209952)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Quantity zero (ORA-02290)'
,p_static_id=>'check-violation'
,p_process_sql_clob=>'elab_errors_api.force_check_violation;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''CHECK_VIOLATION'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>23883720037209952
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23883579678209952)
,p_process_sequence=>110
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
,p_internal_uid=>23883579678209952
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23882500157209951)
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
,p_internal_uid=>23882500157209951
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23884037400209953)
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
,p_internal_uid=>23884037400209953
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23883964450209953)
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
,p_internal_uid=>23883964450209953
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23882860404209951)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Invalid date, 31-Feb (ORA-01839)'
,p_static_id=>'invalid-date'
,p_process_sql_clob=>'elab_errors_api.force_invalid_date;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''INVALID_DATE'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>23882860404209951
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23882780819209951)
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
,p_internal_uid=>23882780819209951
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23882941786209952)
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
,p_internal_uid=>23882941786209952
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23883355120209952)
,p_process_sequence=>90
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
,p_internal_uid=>23883355120209952
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23883237756209952)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Number too large for column (ORA-01438)'
,p_static_id=>'numeric-overflow'
,p_process_sql_clob=>'elab_errors_api.force_numeric_overflow;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''NUMERIC_OVERFLOW'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>23883237756209952
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23883412162209952)
,p_process_sequence=>100
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
,p_internal_uid=>23883412162209952
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23883012519209952)
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
,p_internal_uid=>23883012519209952
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23883623160209952)
,p_process_sequence=>120
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
,p_internal_uid=>23883623160209952
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23882636202209951)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Value too long for a variable (ORA-06502)'
,p_static_id=>'value-error'
,p_process_sql_clob=>'elab_errors_api.force_value_error;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''VALUE_ERROR'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>23882636202209951
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23883103596209952)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Text too long for column (ORA-12899)'
,p_static_id=>'value-too-large'
,p_process_sql_clob=>'elab_errors_api.force_value_too_large;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':REQUEST = ''VALUE_TOO_LARGE'''
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_internal_uid=>23883103596209952
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
