import 'package:flutter/material.dart';

import 'medley_models.dart';

/// ===============================================================
/// Medley Widgets
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
///
/// Reusable widgets used only by the Medley feature.
///
/// Contains no repository/database code.
/// ===============================================================

class MedleyTile extends StatelessWidget {
  const MedleyTile({
    super.key,
    required this.medley,
    this.onTap,
  });

  final Medley medley;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.library_music),
      title: Text(medley.name),
      subtitle: Text(
        '${medley.children.length} item(s)',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class MedleyNodeTile extends StatelessWidget {
  const MedleyNodeTile({
    super.key,
    required this.node,
    this.onTap,
    this.onLongPress,
  });

  final MedleyNode node;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        node.isFolder
            ? Icons.folder
            : Icons.music_note,
      ),
      title: Text(
        node.isFolder
            ? node.name ?? ''
            : node.hymn?.title ?? '',
      ),
      subtitle: node.isFolder
          ? null
          : Text(
              'Page ${node.hymn?.pageNo ?? ''}',
            ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

class EmptyMedleyView extends StatelessWidget {
  const EmptyMedleyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No Medleys yet',
      ),
    );
  }
}

class LoadingMedleyView extends StatelessWidget {
  const LoadingMedleyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}