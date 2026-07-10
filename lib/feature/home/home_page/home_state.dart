import 'package:flutter/foundation.dart';
import '../home_models.dart';
/// ===============================================================
/// HomeTab
/// ===============================================================


/// ===============================================================
/// HomeState
/// ---------------------------------------------------------------
/// Single source of truth for Home screen.
/// ===============================================================
class HomeState extends ChangeNotifier {
  HomeTab _currentTab = HomeTab.allHymns;

  HomeTab get currentTab => _currentTab;

  void setTab(HomeTab tab) {
    if (_currentTab == tab) return;
    _currentTab = tab;
    notifyListeners();
  }
}