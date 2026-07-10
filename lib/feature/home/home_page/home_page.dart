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
    _showSelectionDialog(
      title: 'Select Key',
      items: const [
        SelectionItem(id: 'Maj', name: 'Maj'),
        SelectionItem(id: 'Min', name: 'Min'),
        SelectionItem(id: 'Blank', name: 'Blank'),
      ],
      onSelected: (selected) {
        if (selected == null) return;
        _filter = _filter.copyWith(keys: {selected});
      },
    );
  }

  void _onDedicatedTap() {
    _showSelectionDialog(
      title: 'Select Dedicated',
      items: const [
        SelectionItem(id: 'Appa', name: 'Appa'),
        SelectionItem(id: 'Amma', name: 'Amma'),
        SelectionItem(id: 'Ayya', name: 'Ayya'),
        SelectionItem(id: 'Anna', name: 'Anna'),
        SelectionItem(id: 'Mix', name: 'Mix'),
        SelectionItem(id: 'Others', name: 'Others'),
      ],
      onSelected: (selected) {
        if (selected == null) return;
        _filter = _filter.copyWith(dedicated: {selected});
      },
    );
  }

  void _onYearTap() {
    _showSelectionDialog(
      title: 'Select Year',
      items: const [
        SelectionItem(id: '2023', name: '2023'),
        SelectionItem(id: '2022', name: '2022'),
        SelectionItem(id: '2021', name: '2021'),
        SelectionItem(id: '2020', name: '2020'),
      ],
      onSelected: (selected) {
        if (selected == null) return;
        final year = int.tryParse(selected);
        if (year == null) return;
        _filter = _filter.copyWith(years: {year});
      },
    );
  }

  void _onBeatTap() {
    _showSelectionDialog(
      title: 'Select Beat',
      items: const [
        SelectionItem(id: '4/4', name: '4/4'),
        SelectionItem(id: '3/4', name: '3/4'),
        SelectionItem(id: '6/8', name: '6/8'),
      ],
      onSelected: (selected) {
        if (selected == null) return;
        _filter = _filter.copyWith(beats: {selected});
      },
    );
  }

  void _onResetFilters() {
    setState(() {
      _filter = const HomeFilter();
      _hymnFuture = _loadHymns();
      _selectionController.clear();
    });
  }

  void _onTabChanged(models.HomeTab tab) {
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
                keySelected: _filter.keys.length,
                dedicatedSelected: _filter.dedicated.length,
                yearSelected: _filter.years.length,
                beatSelected: _filter.beats.length,
                onKeyTap: _onKeyTap,
                onDedicatedTap: _onDedicatedTap,
                onYearTap: _onYearTap,
                onBeatTap: _onBeatTap,
                onReset: _onResetFilters,
              ),
            Expanded(child: _buildHomeContent()),
          ],
        ),
      ),
    );
  }
}
