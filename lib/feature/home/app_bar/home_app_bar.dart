import 'package:flutter/material.dart';

import 'home_app_bar_logic.dart';
import 'home_app_bar_popup_menu.dart';
import 'home_selection_controller.dart';

/// ===============================================================
/// HomeAppBar
/// ---------------------------------------------------------------
/// Global AppBar used throughout Zion Songs.
/// ===============================================================
class HomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
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
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: selectionController,
      builder: (context, _) {
        return AppBar(
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,

          title: _buildTitle(),

          actions: [
            ..._buildActionButtons(context),
          ],
        );
      },
    );
  }

  Widget _buildTitle() {
    switch (selectionController.mode) {
      case HomeSelectionMode.none:
        return const Text('All Hymns');

      case HomeSelectionMode.single:
      case HomeSelectionMode.multiple:
        return Text(
          '${selectionController.selectedCount} Selected',
        );
    }
  }

  List<Widget> _buildActionButtons(BuildContext context) {
    switch (selectionController.mode) {
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
        onPressed: logic.onSearch,
      ),

      IconButton(
        tooltip: 'Theme',
        icon: const Icon(Icons.palette_outlined),
        onPressed: logic.onTheme,
      ),

      IconButton(
        tooltip: 'Invert Theme',
        icon: const Icon(Icons.invert_colors),
        onPressed: logic.onInvertTheme,
      ),

      if (canShowPresentation)
        IconButton(
          tooltip: 'Presentation',
          icon: const Icon(Icons.slideshow),
          onPressed: logic.onPresentation,
        ),

      IconButton(
        tooltip: 'Notifications',
        icon: const Icon(Icons.notifications_none),
        onPressed: logic.onNotifications,
      ),

      IconButton(
        tooltip: 'Settings',
        icon: const Icon(Icons.settings_outlined),
        onPressed: logic.onSettings,
      ),

      HomeAppBarPopupMenu(
        logic: logic,
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
        onPressed: logic.onEdit,
      ),

      IconButton(
        tooltip: 'Theme',
        icon: const Icon(Icons.palette_outlined),
        onPressed: logic.onTheme,
      ),

      IconButton(
        tooltip: 'Invert Theme',
        icon: const Icon(Icons.invert_colors),
        onPressed: logic.onInvertTheme,
      ),

      if (canShowPresentation)
        IconButton(
          tooltip: 'Presentation',
          icon: const Icon(Icons.slideshow),
          onPressed: logic.onPresentation,
        ),

      IconButton(
        tooltip: 'Notifications',
        icon: const Icon(Icons.notifications_none),
        onPressed: logic.onNotifications,
      ),

      IconButton(
        tooltip: 'Settings',
        icon: const Icon(Icons.settings_outlined),
        onPressed: logic.onSettings,
      ),

      HomeAppBarPopupMenu(
        logic: logic,
      ),

      IconButton(
        tooltip: 'Cancel Selection',
        icon: const Icon(Icons.close),
        onPressed: logic.onCancelSelection,
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
        onPressed: logic.onAddToFavorites,
      ),

      IconButton(
        tooltip: 'View List',
        icon: const Icon(Icons.folder_outlined),
        onPressed: logic.onAddToViewList,
      ),

      IconButton(
        tooltip: 'Medley',
        icon: const Icon(Icons.queue_music),
        onPressed: logic.onAddToMedley,
      ),

      IconButton(
        tooltip: 'Export PDF',
        icon: const Icon(Icons.picture_as_pdf_outlined),
        onPressed: logic.onExportPdf,
      ),

      IconButton(
        tooltip: 'Notifications',
        icon: const Icon(Icons.notifications_none),
        onPressed: logic.onNotifications,
      ),

      IconButton(
        tooltip: 'Settings',
        icon: const Icon(Icons.settings_outlined),
        onPressed: logic.onSettings,
      ),

      HomeAppBarPopupMenu(
        logic: logic,
      ),

      IconButton(
        tooltip: 'Cancel Selection',
        icon: const Icon(Icons.close),
        onPressed: logic.onCancelSelection,
      ),
    ];
  }
}