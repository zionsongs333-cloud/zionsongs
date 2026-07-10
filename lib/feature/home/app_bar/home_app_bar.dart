import 'package:flutter/material.dart';

import '../hymn/app_initializer.dart';
import 'home_app_bar_logic.dart';
import 'home_app_bar_popup_menu.dart';
import 'home_selection_controller.dart';
import '../search/home_search_controller.dart';
import '../search/home_search_repository.dart';
import '../hymn/hymn_detail_page.dart';

/// Note: Converted to StatefulWidget to support in-appbar search mode with
/// live suggestions and focus handling.

/// ===============================================================
/// HomeAppBar
/// ---------------------------------------------------------------
/// Global AppBar used throughout Zion Songs.
/// ===============================================================
class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.logic,
    required this.selectionController,
    required this.canShowPresentation,
  });

  final HomeAppBarLogic logic;
  final HomeSelectionController selectionController;
  final bool canShowPresentation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool _searchActive = false;
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;
  late final HomeSearchController _searchControllerBackend;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    _searchControllerBackend = HomeSearchController(
      repository: HomeSearchRepository(isar: AppInitializer.isar),
    );
    _searchControllerBackend.addListener(_onSearchResults);
  }

  void _onSearchResults() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _searchControllerBackend.removeListener(_onSearchResults);
    _searchControllerBackend.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _searchActive = true;
    });

    // focus after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _closeSearch() {
    setState(() {
      _searchActive = false;
      _searchController.text = '';
      _searchControllerBackend.clear();
    });
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.selectionController,
      builder: (context, _) {
        return AppBar(
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: _searchActive ? _buildSearchField() : _buildTitle(),
          actions: _searchActive ? _buildSearchActions() : _buildActionButtons(context),
          bottom: _searchActive
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(200),
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: 200,
                    child: _buildSearchResults(context),
                  ),
                )
              : null,
        );
      },
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    final results = _searchControllerBackend.results;

    if (results.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: results.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final r = results[index];
        return ListTile(
          title: Text(r.title),
          subtitle: r.snippet != null ? Text(r.snippet!) : null,
          onTap: () {
            // Open hymn detail
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => HymnDetailPage(hymnId: r.srNo)));
            _closeSearch();
          },
        );
      },
    );
  }

  Widget _buildTitle() {
    switch (widget.selectionController.mode) {
      case HomeSelectionMode.none:
        return const Text('All Hymns');

      case HomeSelectionMode.single:
      case HomeSelectionMode.multiple:
        return Text(
          '${widget.selectionController.selectedCount} Selected',
        );
    }
  }

  List<Widget> _buildActionButtons(BuildContext context) {
    switch (widget.selectionController.mode) {
      case HomeSelectionMode.none:
        return _normalButtons(context);

      case HomeSelectionMode.single:
        return _singleSelectionButtons(context);

      case HomeSelectionMode.multiple:
        return _multipleSelectionButtons(context);
    }
  }

  // ==========================================================
  // NORMAL MODE
  // ==========================================================

  List<Widget> _normalButtons(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Search',
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),

      IconButton(
        tooltip: 'Theme',
        icon: const Icon(Icons.palette_outlined),
        onPressed: widget.logic.onTheme,
      ),

      IconButton(
        tooltip: 'Invert Theme',
        icon: const Icon(Icons.invert_colors),
        onPressed: widget.logic.onInvertTheme,
      ),

      if (widget.canShowPresentation)
        IconButton(
          tooltip: 'Presentation',
          icon: const Icon(Icons.slideshow),
          onPressed: widget.logic.onPresentation,
        ),

      IconButton(
        tooltip: 'Notifications',
        icon: const Icon(Icons.notifications_none),
        onPressed: widget.logic.onNotifications,
      ),

      IconButton(
        tooltip: 'Settings',
        icon: const Icon(Icons.settings_outlined),
        onPressed: widget.logic.onSettings,
      ),

      HomeAppBarPopupMenu(
        logic: widget.logic,
      ),
    ];
  }

  // ==========================================================
  // SINGLE SELECTION
  // ==========================================================

  List<Widget> _singleSelectionButtons(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Edit',
        icon: const Icon(Icons.edit),
        onPressed: widget.logic.onEdit,
      ),

      IconButton(
        tooltip: 'Theme',
        icon: const Icon(Icons.palette_outlined),
        onPressed: widget.logic.onTheme,
      ),

      IconButton(
        tooltip: 'Invert Theme',
        icon: const Icon(Icons.invert_colors),
        onPressed: widget.logic.onInvertTheme,
      ),

      if (widget.canShowPresentation)
        IconButton(
          tooltip: 'Presentation',
          icon: const Icon(Icons.slideshow),
          onPressed: widget.logic.onPresentation,
        ),

      IconButton(
        tooltip: 'Notifications',
        icon: const Icon(Icons.notifications_none),
        onPressed: widget.logic.onNotifications,
      ),

      IconButton(
        tooltip: 'Settings',
        icon: const Icon(Icons.settings_outlined),
        onPressed: widget.logic.onSettings,
      ),

      HomeAppBarPopupMenu(
        logic: widget.logic,
      ),

      IconButton(
        tooltip: 'Cancel Selection',
        icon: const Icon(Icons.close),
        onPressed: widget.logic.onCancelSelection,
      ),
    ];
  }

  // ==========================================================
  // MULTIPLE SELECTION
  // ==========================================================

  List<Widget> _multipleSelectionButtons(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Favorites',
        icon: const Icon(Icons.star_border),
        onPressed: widget.logic.onAddToFavorites,
      ),

      IconButton(
        tooltip: 'View List',
        icon: const Icon(Icons.folder_outlined),
        onPressed: widget.logic.onAddToViewList,
      ),

      IconButton(
        tooltip: 'Medley',
        icon: const Icon(Icons.queue_music),
        onPressed: widget.logic.onAddToMedley,
      ),

      IconButton(
        tooltip: 'Export PDF',
        icon: const Icon(Icons.picture_as_pdf_outlined),
        onPressed: widget.logic.onExportPdf,
      ),

      IconButton(
        tooltip: 'Notifications',
        icon: const Icon(Icons.notifications_none),
        onPressed: widget.logic.onNotifications,
      ),

      IconButton(
        tooltip: 'Settings',
        icon: const Icon(Icons.settings_outlined),
        onPressed: widget.logic.onSettings,
      ),

      HomeAppBarPopupMenu(
        logic: widget.logic,
      ),

      IconButton(
        tooltip: 'Cancel Selection',
        icon: const Icon(Icons.close),
        onPressed: widget.logic.onCancelSelection,
      ),
    ];
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      focusNode: _focusNode,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search hymns',
        border: InputBorder.none,
      ),
      onChanged: (t) {
        _searchControllerBackend.onQueryChanged(t);
      },
    );
  }

  List<Widget> _buildSearchActions() {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: _closeSearch,
      ),
    ];
  }
}