
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'home_search_models.dart';
import 'home_search_repository.dart';

class HomeSearchController extends ChangeNotifier {
  final HomeSearchRepository repository;

  HomeSearchController({required this.repository});

  HomeSearchQuery _query = const HomeSearchQuery(text: '');
  HomeSearchFilters _filters = const HomeSearchFilters();

  List<HomeSearchResult> _results = [];
  bool _loading = false;

  Timer? _debounce;

  List<HomeSearchResult> get results => _results;
  bool get loading => _loading;
  HomeSearchQuery get query => _query;

  void onQueryChanged(String text) {
    _query = _query.copyWith(text: text);

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), _search);

    notifyListeners();
  }

  Future<void> _search() async {
    final text = _query.text.trim();

    if (text.isEmpty) {
      _results = [];
      notifyListeners();
      return;
    }

    _loading = true;
    notifyListeners();

    _results = await repository.searchHymns(
      _query,
      filters: _filters,
    );

    _loading = false;
    notifyListeners();
  }

  void toggleFavorites() {
    _filters = _filters.copyWith(
      onlyFavorites: !_filters.onlyFavorites,
    );

    if (_query.text.isNotEmpty) {
      _search();
    }

    notifyListeners();
  }

  void clear() {
    _debounce?.cancel();
    _query = const HomeSearchQuery(text: '');
    _results = [];
    _loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}