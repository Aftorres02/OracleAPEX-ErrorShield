/*
 * ==========================================================================
 * ERRORSHIELD AUTO REFRESH
 * ==========================================================================
 *
 * @description Refreshes report regions on a timer, so the job dashboards
 *              (pages 1000 and 1400) follow scheduler activity without a
 *              page reload. Pauses while the browser tab is hidden.
 * @author      Angel Flores (Consultant)
 * @created     October 2026
 * @issue       ERSH-052
 * @version     1.0
 */

// Initialize namespace
var ersh = ersh || {};


/**
 * ==========================================================================
 * @module autoRefresh
 * ==========================================================================
 */
ersh.autoRefresh = (function(ersh, $, undefined) {
  'use strict';

  var MODULE_NAME = 'AutoRefresh';

  // ---------------------------------------------------------------------------
  // Configuration
  // ---------------------------------------------------------------------------
  var CONFIG = {
      DEFAULT_SECONDS: 5
    , MIN_SECONDS: 2
      // Set on a region only while a timer refresh runs. app.css hides the
      // report's loading spinner under it, so the page doesn't flicker every
      // few seconds; a refresh the user starts (sort, paging) still shows it.
    , REFRESHING_CLASS: 'ersh-auto-refreshing'
  };

  // ---------------------------------------------------------------------------
  // Logger (self-contained, no external dependency)
  // ---------------------------------------------------------------------------
  var _PREFIX = '[' + MODULE_NAME + ']';
  var logger = {
      log:     function(msg, data) { console.log(_PREFIX, msg, data || ''); }
    , warning: function(msg, data) { console.warn(_PREFIX, msg, data || ''); }
    , error:   function(msg, data) { console.error(_PREFIX, msg, data || ''); }
  };


  // ---------------------------------------------------------------------------
  // Private variables
  // ---------------------------------------------------------------------------
  var _timerId = null;
  var _regionIds = [];
  // Static IDs whose previous refresh hasn't come back yet.
  var _pendingRegions = {};


  /* ================================================================ */
  /* REFRESH SECTION                                                   */
  /* ================================================================ */


  /**
   * Refresh one region, unless its previous refresh is still running.
   * @param {string} regionId - Static ID of the region
   */
  var _refreshRegion = function(regionId) {
    var region = apex.region(regionId);
    var region$;

    if (!region) {
      logger.warning('Region not found, skipped', {regionId: regionId});
      return;
    }

    if (_pendingRegions[regionId]) {
      return;
    }

    region$ = $(region.element);
    _pendingRegions[regionId] = true;
    region$.addClass(CONFIG.REFRESHING_CLASS);

    // A classic report's refresh() returns the Ajax request's promise.
    $.when(region.refresh()).always(function() {
      _pendingRegions[regionId] = false;
      region$.removeClass(CONFIG.REFRESHING_CLASS);
    });
  };


  /**
   * One timer tick: refresh every region, except while the tab is hidden.
   */
  var _tick = function() {
    if (document.hidden) {
      return;
    }

    _regionIds.forEach(_refreshRegion);
  };


  /* ================================================================ */
  /* LIFECYCLE SECTION                                                 */
  /* ================================================================ */


  /**
   * Start refreshing the given regions every few seconds. Calling it again
   * replaces the previous timer.
   * @param {Object} options - Settings
   * @param {string[]} options.regions - Static IDs of the regions to refresh
   * @param {number} [options.seconds=5] - Seconds between refreshes (min 2)
   * @returns {boolean} - True when the timer started
   */
  var start = function(options) {
    var seconds = Math.max(
        (options && options.seconds) || CONFIG.DEFAULT_SECONDS
      , CONFIG.MIN_SECONDS
    );

    stop();

    _regionIds = (options && options.regions) || [];
    if (_regionIds.length === 0) {
      logger.warning('No regions given, nothing to refresh');
      return false;
    }

    _timerId = window.setInterval(_tick, seconds * 1000);
    logger.log('Started', {regions: _regionIds, seconds: seconds});

    return true;
  };


  /**
   * Stop the timer started by start().
   */
  var stop = function() {
    if (_timerId !== null) {
      window.clearInterval(_timerId);
      _timerId = null;
      logger.log('Stopped');
    }
  };


  /* ================================================================ */
  /* Return public API                                                 */
  /* ================================================================ */
  return {
      // Lifecycle
      start: start
    , stop: stop
  };

})(ersh, apex.jQuery);
