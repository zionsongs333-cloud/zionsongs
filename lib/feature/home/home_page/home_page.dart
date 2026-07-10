import 'package:flutter/material.dart';

import '../app_bar/home_app_bar.dart';
import '../app_bar/home_app_bar_logic.dart';
import '../app_bar/home_repository_impl.dart';
import '../app_bar/home_selection_controller.dart';
import '../controller/home_filter.dart';
import '../home_models.dart' as models;
import '../hymn/hymn_detail_page.dart';
import '../medley/medley_page.dart';
import '../viewlist/viewlist_page.dart';
import 'home_alphabet_bar.dart';
import 'home_filter_bar.dart';
import 'home_hymn_list.dart';
import 'home_tab_bar.dart';
import '../app_bar/selection_picker_dialog.dart';

/// ===============================================================
/// HomePage
/// ---------------------------------------------------------------
/// Landing page of Zion Songs.
/// ===============================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double _itemHeight = 60.0;

  late final HomeSelectionController _selectionController;
  late final HomeAppBarLogic _appBarLogic;
  late final HomeRepositoryImpl _repository;
  late final Future<List<models.HomeHymn>> _hymnFuture;
  late final ScrollController _scrollController;

  models.HomeTab _currentTab = models.HomeTab.allHymns;
  HomeFilter _filter = const HomeFilter();

  @override
  void initState() {
    super.initState();

    _selectionController = HomeSelectionController();
    _repository = HomeRepositoryImpl();
    _scrollController = ScrollController();

    _appBarLogic = HomeAppBarLogic(
      context: context,
      repository: _repository,
      selectionController: _selectionController,
    );

    _hymnFuture = _loadHymns();
  }

  @override
  void dispose() {
    _selectionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<models.HomeHymn>> _loadHymns() {
    return _repository.search(
      keyword: '',
      keys: _filter.keys,
      dedicated: _filter.dedicated,
      years: _filter.years,
      beats: _filter.beats,
      styles: _filter.styles,
      tempos: _filter.tempos,
      tab: _currentTab,
    );
  }

  void _refreshHymns() {
    setState(() {
      _hymnFuture = _loadHymns();
      _selectionController.clear();
    });
  }

  void _showSelectionDialog({
    required String title,
    required List<SelectionItem> items,
    required void Function(String?) onSelected,
  }) async {
    final selectedId = await showDialog<String>(
      context: context,
      builder: (context) => SelectionPickerDialog(title: title, items: items),
    );

    if (selectedId == null) return;

    onSelected(selectedId);
    _refreshHymns();
  }

  void _onKeyTap() {
    _showDynamicMultiSelect(
      title: 'Select Key',
      valuesFuture: _repository.getAvailableKeys(),
      selectedValues: _filter.keys,
      onSelected: (selected) {
        setState(() {
          _filter = _filter.copyWith(keys: selected);
          _hymnFuture = _loadHymns();
        });
      },
    );
  }

  void _onDedicatedTap() {
    _showDynamicMultiSelect(
      title: 'Select Dedicated',
      valuesFuture: _repository.getAvailableDedicated(),
      selectedValues: _filter.dedicated,
      onSelected: (selected) {
        setState(() {
          _filter = _filter.copyWith(dedicated: selected);
          _hymnFuture = _loadHymns();
        });
      },
    );
  }

  void _onYearTap() {
    _showDynamicMultiSelectInt(
      title: 'Select Year',
      valuesFuture: _repository.getAvailableYears(),
      selectedValues: _filter.years,
      onSelected: (selected) {
        setState(() {
          _filter = _filter.copyWith(years: selected);
          _hymnFuture = _loadHymns();
        });
      },
    );
  }

  void _onBeatTap() {
    _showDynamicMultiSelect(
      title: 'Select Beat',
      valuesFuture: _repository.getAvailableBeats(),
      selectedValues: _filter.beats,
      onSelected: (selected) {
        setState(() {
          _filter = _filter.copyWith(beats: selected);
          _hymnFuture = _loadHymns();
        });
      },
    );
  }

  void _onStyleTap() {
    _showDynamicMultiSelect(
      title: 'Select Style',
      valuesFuture: _repository.getAvailableStyles(),
      selectedValues: _filter.styles,
      onSelected: (selected) {
        setState(() {
          _filter = _filter.copyWith(styles: selected);
          _hymnFuture = _loadHymns();
        });
      },
    );
  }

  void _onTempoTap() {
    _showDynamicMultiSelectInt(
      title: 'Select Tempo',
      valuesFuture: _repository.getAvailableTempos(),
      selectedValues: _filter.tempos,
      onSelected: (selected) {
        setState(() {
          _filter = _filter.copyWith(tempos: selected);
          _hymnFuture = _loadHymns();
        });
      },
    );
  }

  Future<void> _showDynamicMultiSelect({
    required String title,
    required Future<List<String>> valuesFuture,
    required Set<String> selectedValues,
    required void Function(Set<String>) onSelected,
  }) async {
    final values = await valuesFuture;
    final selected = Set<String>.from(selectedValues);

    final result = await showDialog<Set<String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: values.length,
              itemBuilder: (context, index) {
                final v = values[index];
                final checked = selected.contains(v);
                return CheckboxListTile(
                  value: checked,
                  title: Text(v),
                  onChanged: (c) {
                    setState(() {
                      if (c == true) selected.add(v); else selected.remove(v);
                    });
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, selected),
              child: const Text('Done'),
            )
          ],
        );
      },
    );

    if (result != null) onSelected(result);
  }

  Future<void> _showDynamicMultiSelectInt({
    required String title,
    required Future<List<int>> valuesFuture,
    required Set<int> selectedValues,
    required void Function(Set<int>) onSelected,
  }) async {
    final values = await valuesFuture;
    final selected = Set<int>.from(selectedValues);

    final result = await showDialog<Set<int>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: values.length,
              itemBuilder: (context, index) {
                final v = values[index];
                final checked = selected.contains(v);
                return CheckboxListTile(
                  value: checked,
                  title: Text(v.toString()),
                  onChanged: (c) {
                    setState(() {
                      if (c == true) selected.add(v); else selected.remove(v);
                    });
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, selected),
              child: const Text('Done'),
            )
          ],
        );
      },
    );

    if (result != null) onSelected(result);
  }

  void _onResetFilters() {
    setState(() {
      _filter = const HomeFilter();
      _hymnFuture = _loadHymns();
      _selectionController.clear();
    });
  }

  void _onTabChanged(models.HomeTab tab) {
    // Diagnostic
    // ignore: avoid_print
    print('Tab changed: $tab');

    setState(() {
      _currentTab = tab;
      _filter = const HomeFilter();
      _hymnFuture = _loadHymns();
      _selectionController.clear();
    });
  }

  void _onLetterSelected(String letter) async {
    final hymns = await _hymnFuture;
    final index = hymns.indexWhere((hymn) {
      final title = hymn.title.trim();
      if (title.isEmpty) return false;
      final first = title[0].toUpperCase();
      if (letter == '#') {
        return !RegExp(r'[A-Z]').hasMatch(first);
      }
      return first == letter;
    });

    if (index == -1) return;

    if (_scrollController.hasClients) {
      final offset = index * _itemHeight;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildHomeContent() {
    if (_currentTab == models.HomeTab.viewLists) {
      return const ViewListPage();
    }

    if (_currentTab == models.HomeTab.medleys) {
      return const MedleyPage();
    }

    return FutureBuilder<List<models.HomeHymn>>(
      future: _hymnFuture,
      builder: (context, snapshot) {
        final hymns = snapshot.data ?? [];

        // Diagnostic
        // ignore: avoid_print
        print('HomeHymnList received ${hymns.length} hymns');

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load hymns'));
        }

        return Row(
          children: [
            Expanded(
              child: HomeHymnList(
                hymns: hymns,
                selectionController: _selectionController,
                scrollController: _scrollController,
                onOpen: (hymnId) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HymnDetailPage(hymnId: hymnId),
                    ),
                  );
                },
              ),
            ),
            HomeAlphabetBar(
              onLetterSelected: _onLetterSelected,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        logic: _appBarLogic,
        selectionController: _selectionController,
        canShowPresentation: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            HomeTabBar(
              currentTab: _currentTab,
              onChanged: _onTabChanged,
            ),
            if (_currentTab == models.HomeTab.allHymns ||
                _currentTab == models.HomeTab.favorites)
              HomeFilterBar(
                keyLabel: 'Key',
                dedicatedLabel: 'Dedicated',
                yearLabel: 'Year',
                beatLabel: 'Beat',
                styleLabel: 'Style',
                tempoLabel: 'Tempo',
                keySelected: _filter.keys.length,
                dedicatedSelected: _filter.dedicated.length,
                yearSelected: _filter.years.length,
                beatSelected: _filter.beats.length,
                styleSelected: _filter.styles.length,
                tempoSelected: _filter.tempos.length,
                onKeyTap: _onKeyTap,
                onDedicatedTap: _onDedicatedTap,
                onYearTap: _onYearTap,
                onBeatTap: _onBeatTap,
                onStyleTap: _onStyleTap,
                onTempoTap: _onTempoTap,
                onReset: _onResetFilters,
              ),
            Expanded(child: _buildHomeContent()),
          ],
        ),
      ),
    );
  }
}
