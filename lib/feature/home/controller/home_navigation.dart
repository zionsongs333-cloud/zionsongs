import 'package:flutter/material.dart';

/// ===============================================================
/// HomeNavigation
/// ---------------------------------------------------------------
///
/// Central navigation helper for the Home feature.
///
/// OFFLINE FIRST
/// ---------------------------------------------------------------
///
/// This class NEVER:
/// • Reads Firestore
/// • Reads Isar
/// • Performs Sync
/// • Contains business logic
///
/// It only performs screen navigation.
///
/// Keeping navigation here prevents widgets from calling
/// Navigator directly everywhere.
///
/// ===============================================================
class HomeNavigation {
  HomeNavigation({
    required this.context,
  });

  final BuildContext context;

  // ============================================================
  // HOME
  // ============================================================

  void goHome() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  // ============================================================
  // HYMN
  // ============================================================

  void openHymn(String hymnId) {
    // TODO
    // Navigate to Hymn Page.
    // Default tab = Together.
    //
    // Example:
    // Navigator.push(...)
  }

  // ============================================================
  // SEARCH
  // ============================================================

  void openSearch() {
    // TODO
  }

  // ============================================================
  // SETTINGS
  // ============================================================

  void openSettings() {
    // TODO
  }

  // ============================================================
  // NOTIFICATIONS
  // ============================================================

  void openNotifications() {
    // TODO
  }

  // ============================================================
  // PRESENTATION MODE
  // ============================================================

  void openPresentation() {
    // TODO
  }

  // ============================================================
  // VIEW LISTS
  // ============================================================

  void openViewLists() {
    // TODO
  }

  // ============================================================
  // MEDLEYS
  // ============================================================

  void openMedleys() {
    // TODO
  }

  // ============================================================
  // NOTES
  // ============================================================

  void openNotes() {
    // TODO
  }

  // ============================================================
  // FAVORITES
  // ============================================================

  void openFavorites() {
    // TODO
  }

  // ============================================================
  // IMPORT / EXPORT
  // ============================================================

  void openImportExcel() {
    // TODO
  }

  void openExportExcel() {
    // TODO
  }

  void openExportPdf() {
    // TODO
  }

  // ============================================================
  // HELP
  // ============================================================

  void openHelp() {
    // TODO
  }

  void openFeedback() {
    // TODO
  }

  void openAbout() {
    // TODO
  }
}