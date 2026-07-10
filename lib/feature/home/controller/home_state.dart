import 'package:flutter/foundation.dart';

import '../home_models.dart';

/// ===============================================================
/// HomeState
/// ---------------------------------------------------------------
///
/// Pure UI state for the Home screen.
///
/// OFFLINE FIRST
/// ---------------------------------------------------------------
/// This class never talks to:
/// • Isar
/// • Firestore
/// • Repository
/// • SyncQueue
///
/// It simply remembers the current state of the Home page.
/// ===============================================================

class HomeState extends ChangeNotifier {
  // ============================================================
  // CURRENT TAB
  // ============================================================

  HomeTab _currentTab = HomeTab.allHymns;

  HomeTab get currentTab => _currentTab;

  void setCurrentTab(HomeTab tab) {
    if (_currentTab == tab) return;

    _currentTab = tab;
    notifyListeners();
  }

  // ============================================================
  // SEARCH
  // ============================================================

  String _searchText = '';

  String get searchText => _searchText;

  void setSearchText(String value) {
    if (_searchText == value) return;

    _searchText = value;
    notifyListeners();
  }

  void clearSearch() {
    if (_searchText.isEmpty) return;

    _searchText = '';
    notifyListeners();
  }

  // ============================================================
  // FILTERS
  // ============================================================

  String? _selectedKey;
  String? _selectedDedicated;
  int? _selectedYear;
  String? _selectedBeat;

  String? get selectedKey => _selectedKey;
  String? get selectedDedicated => _selectedDedicated;
  int? get selectedYear => _selectedYear;
  String? get selectedBeat => _selectedBeat;

  void setKey(String? value) {
    _selectedKey = value;
    notifyListeners();
  }

  void setDedicated(String? value) {
    _selectedDedicated = value;
    notifyListeners();
  }

  void setYear(int? value) {
    _selectedYear = value;
    notifyListeners();
  }

  void setBeat(String? value) {
    _selectedBeat = value;
    notifyListeners();
  }

  void clearFilters() {
    _selectedKey = null;
    _selectedDedicated = null;
    _selectedYear = null;
    _selectedBeat = null;

    notifyListeners();
  }

  // ============================================================
  // A-Z INDEX
  // ============================================================

  String? _selectedLetter;

  String? get selectedLetter => _selectedLetter;

  void selectLetter(String? letter) {
    _selectedLetter = letter;
    notifyListeners();
  }

  // ============================================================
  // LOADING
  // ============================================================

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    if (_loading == value) return;

    _loading = value;
    notifyListeners();
  }

  // ============================================================
  // ERROR
  // ============================================================

  String? _error;

  String? get error => _error;

  void setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
