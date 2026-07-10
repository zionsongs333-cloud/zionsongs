import 'package:flutter/material.dart';

import '../hymn/app_initializer.dart';
import '../search/home_search_dialog.dart';
import 'home_repository.dart';
import 'home_selection_controller.dart';
import 'selection_picker_dialog.dart';

/// ===============================================================
/// HomeAppBarLogic (FINAL)
/// ===============================================================
class HomeAppBarLogic {
  HomeAppBarLogic({
    required this.context,
    required this.repository,
    required this.selectionController,
  });

  final BuildContext context;
  final HomeRepository repository;
  final HomeSelectionController selectionController;

  List<String> get _selectedIds => selectionController.selectedHymnIds.toList();

  // ============================================================
  // NAVIGATION HELPER
  // ============================================================

  void _go(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  void _placeholder(String title) {
    _go(_TempScreen(title: title));
  }

  // ============================================================
  // NORMAL MODE
  // ============================================================

  void onSearch() {
    showDialog<void>(
      context: context,
      builder: (_) => HomeSearchDialog(isar: AppInitializer.isar),
    );
  }

  void onTheme() {
    repository.changeTheme();
  }

  void onInvertTheme() {
    repository.invertTheme();
  }

  void onPresentation() {
    repository.presentationMode();
  }

  void onNotifications() {
    repository.openNotifications();
  }

  void onSettings() {
    repository.openSettings();
  }

  // ============================================================
  // SINGLE SELECTION
  // ============================================================

  void onEdit() {
    _placeholder("Hymn Editor");
  }

  // ============================================================
  // MULTIPLE SELECTION
  // ============================================================

  void onAddToFavorites() {
    repository.addToFavorites(_selectedIds);
    selectionController.clear();
  }

  Future<void> onAddToViewList() async {
    final viewLists = await repository.getAllViewLists();
    final items = viewLists.map((list) => SelectionItem(id: list.id, name: list.name)).toList();

    if (!context.mounted) return; 

    final selectedListId = await showDialog<String>(
      context: context, 
      builder: (context) => SelectionPickerDialog(title: 'Add to View List', items: items),
    );

    if (selectedListId != null && context.mounted) {
      await repository.addToViewList(hymnIds: _selectedIds, viewListId: selectedListId);
      selectionController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to View List!')));
    }
  }

  /// Wired to fetch Medleys and show the SelectionPickerDialog
  Future<void> onAddToMedley() async {
    final medleys = await repository.getAllMedleys();
    final items = medleys.map((medley) => SelectionItem(id: medley.id, name: medley.name)).toList();

    if (!context.mounted) return;

    final selectedMedleyId = await showDialog<String>(
      context: context,
      builder: (context) => SelectionPickerDialog(title: 'Add to Medley', items: items),
    );

    if (selectedMedleyId != null && context.mounted) {
      await repository.addToMedley(hymnIds: _selectedIds, medleyId: selectedMedleyId);
      selectionController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to Medley!')));
    }
  }

  Future<void> onExportPdf() async {
    try {
      await repository.exportPdf(_selectedIds);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF export not yet implemented.'),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error exporting PDF.'),
        ),
      );
    }
  }

  // ... (Keep existing methods: onCancelSelection, onImportExcel, etc.)
  
  // ============================================================
  // CANCEL SELECTION
  // ============================================================

  void onCancelSelection() {
    selectionController.clear();
  }

  // ============================================================
  // POPUP MENU
  // ============================================================

  void onImportExcel() { repository.importExcel(); }
  void onExportExcel() { repository.exportExcel(); }
  void onStatistics() { repository.openStatistics(); }
  void onHelp() { repository.openHelp(); }
  void onFeedback() { repository.sendFeedback(); }
  void onAbout() { repository.openAbout(); }
}

/// ===============================================================
/// TEMP SCREEN (PLACEHOLDER ONLY)
/// ===============================================================
class _TempScreen extends StatelessWidget {
  const _TempScreen({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "$title screen coming soon",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}