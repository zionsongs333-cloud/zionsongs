import 'package:flutter/foundation.dart';

/// ===============================================================
/// HomeSelectionMode
/// ---------------------------------------------------------------
///
/// none      -> No hymn selected
/// single    -> One hymn selected
/// multiple  -> More than one hymn selected
///
/// HomeAppBar uses this to decide which buttons to display.
/// ===============================================================
enum HomeSelectionMode {
  none,
  single,
  multiple,
}

/// ===============================================================
/// HomeSelectionController
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
///
/// Pure UI state.
///
/// Does NOT know about:
/// • Isar
/// • Firestore
/// • Repository
/// • SyncQueue
///
/// It only remembers which hymns are selected.
///
/// HomePage owns one instance.
/// HomeAppBar listens to it.
/// HomeHymnList updates it.
///
/// ===============================================================
class HomeSelectionController extends ChangeNotifier {

  final Set<String> _selectedHymnIds = {};

  /// Read-only selection
  Set<String> get selectedHymnIds =>
      Set.unmodifiable(_selectedHymnIds);

  int get selectedCount => _selectedHymnIds.length;

  bool get hasSelection => _selectedHymnIds.isNotEmpty;

  HomeSelectionMode get mode {
    switch (_selectedHymnIds.length) {
      case 0:
        return HomeSelectionMode.none;

      case 1:
        return HomeSelectionMode.single;

      default:
        return HomeSelectionMode.multiple;
    }
  }

  bool isSelected(String hymnId) {
    return _selectedHymnIds.contains(hymnId);
  }

  /// ===========================================================
  /// Long Press
  /// ===========================================================
  void select(String hymnId) {

    _selectedHymnIds.add(hymnId);

    notifyListeners();
  }

  /// ===========================================================
  /// Tap while selection mode active
  /// ===========================================================
  void toggle(String hymnId) {

    if (_selectedHymnIds.contains(hymnId)) {
      _selectedHymnIds.remove(hymnId);
    } else {
      _selectedHymnIds.add(hymnId);
    }

    notifyListeners();
  }

  /// ===========================================================
  /// Select all visible hymns
  /// ===========================================================
  void selectAll(Iterable<String> hymnIds) {

    _selectedHymnIds
      ..clear()
      ..addAll(hymnIds);

    notifyListeners();
  }

  /// ===========================================================
  /// Clear selection
  /// ===========================================================
  void clear() {

    if (_selectedHymnIds.isEmpty) return;

    _selectedHymnIds.clear();

    notifyListeners();
  }
}