import '../home_models.dart';
import '../viewlist/viewlist_models.dart';
// Add this import to access the Medley model
import '../medley/medley_models.dart';

/// ===============================================================
/// HomeRepository
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
///
/// Home UI never talks directly to:
/// • Isar
/// • Firestore
/// • Sync Queue
///
/// Everything goes through this repository.
/// ===============================================================

abstract class HomeRepository {
  // ============================================================
  // HOME LIST
  // ============================================================

  Future<List<HomeHymn>> getAllHymns();

  Future<List<HomeHymn>> search({
    String keyword = '',
    Set<String> keys = const {},
    Set<String> dedicated = const {},
    Set<int> years = const {},
    Set<String> beats = const {},
    Set<String> styles = const {},
    Set<int> tempos = const {},
    HomeTab tab = HomeTab.allHymns,
  });

  // ============================================================
  // FAVORITES
  // ============================================================

  Future<void> addToFavorites(
    List<String> hymnIds,
  );

  Future<void> removeFromFavorites(
    List<String> hymnIds,
  );

  // ============================================================
  // VIEW LIST
  // ============================================================

  Future<void> addToViewList({
    required List<String> hymnIds,
    required String viewListId,
  });

  Future<List<ViewList>> getAllViewLists();

  // ============================================================
  // MEDLEY
  // ============================================================

  Future<void> addToMedley({
    required List<String> hymnIds,
    required String medleyId,
  });

  /// New method to fetch all medleys for selection dialogs
  Future<List<Medley>> getAllMedleys();

  // ============================================================
  // FILTER DATA
  // ============================================================

  Future<List<String>> getAvailableKeys();
  Future<List<String>> getAvailableDedicated();
  Future<List<int>> getAvailableYears();
  Future<List<String>> getAvailableBeats();
  Future<List<String>> getAvailableStyles();
  Future<List<int>> getAvailableTempos();

  // ============================================================
  // EXPORT
  // ============================================================

  Future<void> exportPdf(
    List<String> hymnIds,
  );

  // ============================================================
  // IMPORT / EXPORT
  // ============================================================

  Future<void> importExcel();

  Future<void> exportExcel();

  // ============================================================
  // SETTINGS
  // ============================================================

  Future<void> changeTheme();

  Future<void> invertTheme();

  Future<void> presentationMode();

  // ============================================================
  // NOTIFICATIONS
  // ============================================================

  Future<void> openNotifications();

  // ============================================================
  // SETTINGS
  // ============================================================

  Future<void> openSettings();

  // ============================================================
  // STATISTICS
  // ============================================================

  Future<void> openStatistics();

  // ============================================================
  // HELP
  // ============================================================

  Future<void> openHelp();

  Future<void> sendFeedback();

  Future<void> openAbout();
}