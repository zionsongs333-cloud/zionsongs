import 'package:flutter/material.dart';

import '../home_models.dart';
import 'viewlist_models.dart';

/// ===============================================================
/// View List Tile
/// ===============================================================
class ViewListTile extends StatelessWidget {
  const ViewListTile({
    super.key,
    required this.viewList,
    this.onTap,
    this.onRename,
  });

  final ViewList viewList;
  final VoidCallback? onTap;
  final VoidCallback? onRename;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.folder_outlined),
      title: Text(viewList.name),
      subtitle: Text(viewList.zoneId),
      trailing: IconButton(
        icon: const Icon(Icons.drive_file_rename_outline),
        onPressed: onRename,
      ),
      onTap: onTap,
    );
  }
}

/// ===============================================================
/// Folder Tile
/// ===============================================================
class ViewListFolderTile extends StatelessWidget {
  const ViewListFolderTile({
    super.key,
    required this.folder,
    this.onTap,
  });

  final ViewListNode folder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.folder),
      title: Text(folder.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

/// ===============================================================
/// Hymn Tile
/// ===============================================================
class ViewListHymnTile extends StatelessWidget {
  const ViewListHymnTile({
    super.key,
    required this.hymn,
    this.onTap,
  });

  final HomeHymn hymn;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.music_note),
      title: Text(hymn.title),
      subtitle: Text(
        'No. ${hymn.serialNo}   •   Page ${hymn.pageNo}',
      ),
      trailing: hymn.favorite
          ? const Icon(Icons.star, color: Colors.amber)
          : null,
      onTap: onTap,
    );
  }
}

/// ===============================================================
/// Breadcrumb
/// ===============================================================
class ViewListBreadcrumb extends StatelessWidget {
  const ViewListBreadcrumb({
    super.key,
    required this.path,
    this.onTap,
  });

  final List<String> path;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(path.length, (index) {
          return InkWell(
            onTap: () => onTap?.call(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Text(
                    path[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (index != path.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}