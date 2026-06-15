import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesProvider extends ChangeNotifier {
  late Box _favoritesBox;
  Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => _favoriteIds;

  FavoritesProvider() {
    _initFavorites();
  }

  Future<void> _initFavorites() async {
    _favoritesBox = await Hive.openBox('favorites');
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoriteIds = Set<String>.from(_favoritesBox.get('favoriteIds', defaultValue: []));
    notifyListeners();
  }

  Future<void> toggleFavorite(String hymnId) async {
    if (_favoriteIds.contains(hymnId)) {
      _favoriteIds.remove(hymnId);
    } else {
      _favoriteIds.add(hymnId);
    }
    await _favoritesBox.put('favoriteIds', _favoriteIds.toList());
    notifyListeners();
  }

  bool isFavorite(String hymnId) {
    return _favoriteIds.contains(hymnId);
  }

  Future<void> clearFavorites() async {
    _favoriteIds.clear();
    await _favoritesBox.clear();
    notifyListeners();
  }
}
