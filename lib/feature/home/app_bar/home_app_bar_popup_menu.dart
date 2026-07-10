import 'package:flutter/material.dart';

import 'home_app_bar_logic.dart';

/// ===============================================================
/// HomeAppBarPopupMenu
/// ---------------------------------------------------------------
/// UI ONLY
/// ===============================================================
class HomeAppBarPopupMenu extends StatelessWidget {
  const HomeAppBarPopupMenu({
    super.key,
    required this.logic,
  });

  final HomeAppBarLogic logic;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuItem>(
      tooltip: 'More',
      icon: const Icon(Icons.more_vert),

      onSelected: (item) {
        switch (item) {
          case _MenuItem.importExcel:
            logic.onImportExcel();
            break;

          case _MenuItem.exportExcel:
            logic.onExportExcel();
            break;

          case _MenuItem.statistics:
            logic.onStatistics();
            break;

          case _MenuItem.help:
            logic.onHelp();
            break;

          case _MenuItem.feedback:
            logic.onFeedback();
            break;

          case _MenuItem.about:
            logic.onAbout();
            break;
        }
      },

      itemBuilder: (context) => const [
        PopupMenuItem(
          value: _MenuItem.importExcel,
          child: ListTile(
            leading: Icon(Icons.file_upload_outlined),
            title: Text('Import Excel'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        PopupMenuItem(
          value: _MenuItem.exportExcel,
          child: ListTile(
            leading: Icon(Icons.file_download_outlined),
            title: Text('Export Excel'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: _MenuItem.statistics,
          child: ListTile(
            leading: Icon(Icons.bar_chart_outlined),
            title: Text('Statistics'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: _MenuItem.help,
          child: ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        PopupMenuItem(
          value: _MenuItem.feedback,
          child: ListTile(
            leading: Icon(Icons.feedback_outlined),
            title: Text('Feedback'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        PopupMenuItem(
          value: _MenuItem.about,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}

enum _MenuItem {
  importExcel,
  exportExcel,
  statistics,
  help,
  feedback,
  about,
}