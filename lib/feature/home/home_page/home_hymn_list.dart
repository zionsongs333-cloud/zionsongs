import 'package:flutter/material.dart';

import '../app_bar/home_selection_controller.dart';
import '../home_models.dart' as models;
import 'home_hymn_tile.dart';

/// ===============================================================
/// HomeHymnList
/// ---------------------------------------------------------------
///
/// Displays the hymn list.
///
/// RESPONSIBILITY
/// • Display hymns.
/// • Forward tap and long press to HomeSelectionController.
/// • No Firestore.
/// • No Isar.
/// • No Repository.
/// • No SyncQueue.
///
/// OFFLINE FIRST
/// ---------------------------------------------------------------
/// Eventually this widget will receive hymns from the Repository,
/// which itself reads from Isar first and syncs later.
/// This widget never knows where the data came from.
///
/// Columns
/// ---------------------------------------------------------------
/// ✓ Selection
/// ✓ Sr No
/// ✓ Title
/// ✓ Favorite
/// ✓ Page
/// ===============================================================
class HomeHymnList extends StatelessWidget {
  const HomeHymnList({
    super.key,
    required this.hymns,
    required this.selectionController,
    this.onOpen,
    this.scrollController,
  });

  final List<models.HomeHymn> hymns;
  final HomeSelectionController selectionController;
  final ValueChanged<String>? onOpen;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: hymns.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final hymn = hymns[index];

        return HomeHymnTile(
          hymnId: hymn.hymnId,
          serialNo: hymn.serialNo.toString(),
          title: hymn.title,
          pageNo: hymn.pageNo.toString(),
          isFavorite: hymn.favorite,
          selectionController: selectionController,
          onOpen: () => onOpen?.call(hymn.hymnId),
        );
      },
    );
  }
}
