import 'package:flutter/material.dart';

/// ===============================================================
/// View List Dialogs
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
/// UI only.
/// No Firestore.
/// No Isar.
/// ===============================================================
class ViewListDialogs {
  const ViewListDialogs._();

  /// -------------------------------------------------------------
  /// Create View List
  /// -------------------------------------------------------------
  static Future<String?> createViewList(
    BuildContext context,
  ) {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Create View List'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'View List name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();

              if (name.isEmpty) return;

              Navigator.pop(context, name);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  /// -------------------------------------------------------------
  /// Rename
  /// -------------------------------------------------------------
  static Future<String?> renameViewList(
    BuildContext context,
    String currentName,
  ) {
    final controller = TextEditingController(
      text: currentName,
    );

    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Rename View List'),
        content: TextField(
          controller: controller,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();

              if (value.isEmpty) return;

              Navigator.pop(context, value);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  /// -------------------------------------------------------------
  /// Create Folder
  /// -------------------------------------------------------------
  static Future<String?> createFolder(
    BuildContext context,
  ) {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Create Folder'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Folder name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();

              if (value.isEmpty) return;

              Navigator.pop(context, value);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  /// -------------------------------------------------------------
  /// Viewer Approval Required
  /// -------------------------------------------------------------
  static Future<void> approvalRequired(
    BuildContext context,
  ) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Approval Required'),
        content: const Text(
          'Your request will be sent to your EVG Zone Admin or any Super Admin for approval.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}