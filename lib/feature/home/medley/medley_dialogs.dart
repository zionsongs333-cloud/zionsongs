import 'package:flutter/material.dart';

/// ===============================================================
/// Medley Dialogs
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
///
/// Dialog helpers for the Medley feature.
/// No repository/database code belongs here.
/// ===============================================================

class MedleyDialogs {
  const MedleyDialogs._();

  /// --------------------------------------------------------------
  /// Create Medley
  /// --------------------------------------------------------------
  static Future<String?> createMedley(
    BuildContext context,
  ) async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Medley'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Medley Name',
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
        );
      },
    );

    controller.dispose();

    return result;
  }

  /// --------------------------------------------------------------
  /// Rename
  /// --------------------------------------------------------------
  static Future<String?> renameMedley(
    BuildContext context, {
    required String currentName,
  }) async {
    final controller = TextEditingController(text: currentName);

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename Medley'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'New Name',
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
              child: const Text('Rename'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    return result;
  }

  /// --------------------------------------------------------------
  /// Create Folder
  /// --------------------------------------------------------------
  static Future<String?> createFolder(
    BuildContext context,
  ) async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Folder'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Folder Name',
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
        );
      },
    );

    controller.dispose();

    return result;
  }

  /// --------------------------------------------------------------
  /// Delete Disabled
  /// --------------------------------------------------------------
  static Future<void> deleteDisabled(
    BuildContext context,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Disabled'),
          content: const Text(
            'Deleting Medleys or folders is disabled by project design.',
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// --------------------------------------------------------------
  /// Approval Required
  /// --------------------------------------------------------------
  static Future<void> approvalRequired(
    BuildContext context,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Approval Required'),
          content: const Text(
            'Your request will be sent to an Admin or Super Admin for approval.',
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}