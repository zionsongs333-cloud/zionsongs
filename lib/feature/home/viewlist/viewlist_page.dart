import 'package:flutter/material.dart';

import '../home_models.dart';
import '../hymn/hymn_detail_page.dart';
import 'viewlist_controller.dart';
import 'viewlist_dialogs.dart';
import 'viewlist_models.dart';
import 'viewlist_repository.dart';
import 'viewlist_widgets.dart';

/// ===============================================================
/// ViewListPage
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
/// ---------------------------------------------------------------
///
/// Explorer-style View Lists.
///
/// ✔ Home Tab
/// ✔ Folder navigation
/// ✔ Opens Hymn Detail
/// ✔ Create View List
/// ✔ Rename View List
/// ✔ Create Folder
///
/// Future
/// ---------------------------------------------------------------
/// • Isar
/// • Sync Queue
/// • Firestore
/// ===============================================================
class ViewListPage extends StatefulWidget {
  const ViewListPage({
    super.key,
  });

  @override
  State<ViewListPage> createState() => _ViewListPageState();
}

class _ViewListPageState extends State<ViewListPage> {
  late final ViewListController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ViewListController(
      repository: ViewListRepository(),
    );

    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createViewList() async {
    final name = await ViewListDialogs.createViewList(context);

    if (name == null) return;

    await _controller.createViewList(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      zoneId: 'EVG Zone',
      createdBy: 'Current User',
    );
  }

  void _openHymn(HomeHymn hymn) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HymnDetailPage(
          hymnId: hymn.hymnId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        if (_controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: _createViewList,
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: _controller.viewLists.length,
            itemBuilder: (context, index) {
              final list = _controller.viewLists[index];

              return ExpansionTile(
                leading: const Icon(Icons.folder),
                title: Text(list.name),
                subtitle: Text(list.zoneId),
                children: [
                  ...list.children.map((node) {
                    if (node.type == ViewListNodeType.folder) {
                      return ViewListFolderTile(
                        folder: node,
                        onTap: () {},
                      );
                    }

                    return ViewListHymnTile(
                      hymn: node.hymn!,
                      onTap: () => _openHymn(node.hymn!),
                    );
                  }),
                ],
              );
            },
          ),
        );
      },
    );
  }
}