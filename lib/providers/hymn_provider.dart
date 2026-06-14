import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/hymn_model.dart';

class HymnProvider extends ChangeNotifier {
  String sortBy = 'title';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<HymnModel> _hymns = [];
  List<HymnModel> _filteredHymns = [];
  bool _isLoading = false;
  String? _error;

  String _searchQuery = '';
  Set<int?> _selectedYears = {};
  Set<String?> _selectedDedicated = {};
  Set<String?> _selectedKeys = {};
  Set<String?> _selectedStyles = {};
  Set<int?> _selectedTempos = {};
  String _sortBy = 'title';
  bool _isAscending = true;

  List<HymnModel> get hymns => _hymns;
  List<HymnModel> get filteredHymns => _filteredHymns;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchHymnsFromFirebase() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore.collection('hymns').get();
      _hymns = snapshot.docs.map((doc) {
        return HymnModel.fromMap(doc.data()..['id'] = doc.id);
      }).toList();
      
      final hymnBox = await Hive.openBox<HymnModel>('hymns');
      await hymnBox.clear();
      for (var hymn in _hymns) {
        await hymnBox.put(hymn.id, hymn);
      }
      
      _error = null;
      _applyFilters();
    } catch (e) {
      _error = e.toString();
      await _loadFromHiveCache();
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadFromHiveCache() async {
    try {
      final hymnBox = await Hive.openBox<HymnModel>('hymns');
      _hymns = hymnBox.values.toList();
      _applyFilters();
    } catch (e) {
      _error = 'No cached data available';
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void toggleDedicatedFilter(String dedicated) {
    if (_selectedDedicated.contains(dedicated)) {
      _selectedDedicated.remove(dedicated);
    } else {
      _selectedDedicated.add(dedicated);
    }
    _applyFilters();
    notifyListeners();
  }

  void toggleYearFilter(int year) {
    if (_selectedYears.contains(year)) {
      _selectedYears.remove(year);
    } else {
      _selectedYears.add(year);
    }
    _applyFilters();
    notifyListeners();
  }

  void toggleKeyFilter(String key) {
    if (_selectedKeys.contains(key)) {
      _selectedKeys.remove(key);
    } else {
      _selectedKeys.add(key);
    }
    _applyFilters();
    notifyListeners();
  }

  void toggleStyleFilter(String style) {
    if (_selectedStyles.contains(style)) {
      _selectedStyles.remove(style);
    } else {
      _selectedStyles.add(style);
    }
    _applyFilters();
    notifyListeners();
  }

  void toggleTempoFilter(int tempo) {
    if (_selectedTempos.contains(tempo)) {
      _selectedTempos.remove(tempo);
    } else {
      _selectedTempos.add(tempo);
    }
    _applyFilters();
    notifyListeners();
  }

  void setSortBy(String sortBy, {bool ascending = true}) {
    _sortBy = sortBy;
    _isAscending = ascending;
    _applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedYears.clear();
    _selectedDedicated.clear();
    _selectedKeys.clear();
    _selectedStyles.clear();
    _selectedTempos.clear();
    _sortBy = 'title';
    _isAscending = true;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredHymns = _hymns.where((hymn) {
      if (_searchQuery.isNotEmpty) {
        final matchesTitle = hymn.title.toLowerCase().contains(_searchQuery);
        final matchesLyrics = hymn.lyrics.toLowerCase().contains(_searchQuery);
        if (!matchesTitle && !matchesLyrics) return false;
      }

      if (_selectedYears.isNotEmpty && !_selectedYears.contains(hymn.year)) {
        return false;
      }

      if (_selectedDedicated.isNotEmpty &&
          !_selectedDedicated.contains(hymn.dedicated)) {
        return false;
      }

      if (_selectedKeys.isNotEmpty && !_selectedKeys.contains(hymn.key)) {
        return false;
      }

      if (_selectedStyles.isNotEmpty && !_selectedStyles.contains(hymn.style)) {
        return false;
      }

      if (_selectedTempos.isNotEmpty && !_selectedTempos.contains(hymn.tempo)) {
        return false;
      }

      return true;
    }).toList();

    _applySort();
  }

  void _applySort() {
    switch (_sortBy) {
      case 'title':
        _filteredHymns.sort((a, b) => _isAscending
            ? a.title.compareTo(b.title)
            : b.title.compareTo(a.title));
        break;
      case 'year':
        _filteredHymns.sort((a, b) {
          final aYear = a.year ?? 0;
          final bYear = b.year ?? 0;
          return _isAscending ? aYear.compareTo(bYear) : bYear.compareTo(aYear);
        });
        break;
      case 'page':
        _filteredHymns.sort((a, b) {
          final aPage = a.page ?? 0;
          final bPage = b.page ?? 0;
          return _isAscending ? aPage.compareTo(bPage) : bPage.compareTo(aPage);
        });
        break;
      case 'tempo':
        _filteredHymns.sort((a, b) {
          final aTempo = a.tempo ?? 0;
          final bTempo = b.tempo ?? 0;
          return _isAscending ? aTempo.compareTo(bTempo) : bTempo.compareTo(aTempo);
        });
        break;
      case 'dedicated':
        _filteredHymns.sort((a, b) => _isAscending
            ? (a.dedicated ?? '').compareTo(b.dedicated ?? '')
            : (b.dedicated ?? '').compareTo(a.dedicated ?? ''));
        break;
    }
  }

  List<String> getAlphabetLetters() {
    final letters = <String>{};
    for (var hymn in _filteredHymns) {
      if (hymn.title.isNotEmpty) {
        letters.add(hymn.title[0].toUpperCase());
      }
    }
    return letters.toList()..sort();
  }

  HymnModel? getHymnById(String id) {
    try {
      return _hymns.firstWhere((hymn) => hymn.id == id);
    } catch (e) {
      return null;
    }
  }

  List<HymnModel> getHymnsByIds(List<String> ids) {
    return _hymns.where((hymn) => ids.contains(hymn.id)).toList();
  }
}
