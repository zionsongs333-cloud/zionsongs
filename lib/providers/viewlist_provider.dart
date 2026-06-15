import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ViewListProvider extends ChangeNotifier {
  late Box _viewListBox;
  Map<String, List<String>> _viewLists = {};

  Map<String, List<String>> get viewLists => _viewLists;

  ViewListProvider() {
    _initViewLists();
  }

  Future<void> _initViewLists() async {
    _viewListBox = await Hive.openBox('viewlists');
    _loadViewLists();
  }

  void _loadViewLists() {
    final data = _viewListBox.get('viewlists', defaultValue: {});
    _viewLists = Map<String, List<String>>.from(
      (data as Map).map((key, value) => MapEntry(key, List<String>.from(value)))
    );
    notifyListeners();
  }

  Future<void> createViewList(String name, List<String> hymnIds) async {
    _viewLists[name] = hymnIds;
    await _viewListBox.put('viewlists', _viewLists);
    notifyListeners();
  }

  Future<void> addToViewList(String listName, String hymnId) async {
    if (_viewLists.containsKey(listName)) {
      if (!_viewLists[listName]!.contains(hymnId)) {
        _viewLists[listName]!.add(hymnId);
        await _viewListBox.put('viewlists', _viewLists);
        notifyListeners();
      }
    }
  }

  Future<void> removeFromViewList(String listName, String hymnId) async {
    if (_viewLists.containsKey(listName)) {
      _viewLists[listName]!.remove(hymnId);
      await _viewListBox.put('viewlists', _viewLists);
      notifyListeners();
    }
  }

  Future<void> deleteViewList(String name) async {
    _viewLists.remove(name);
    await _viewListBox.put('viewlists', _viewLists);
    notifyListeners();
  }

  List<String> getViewListNames() {
    return _viewLists.keys.toList();
  }
}
