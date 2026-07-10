import 'package:flutter/material.dart';

import 'medley_controller.dart';
import 'medley_dialogs.dart';
import 'medley_repository.dart';
import 'medley_widgets.dart';
import '../hymn/hymn_detail_page.dart';

/// ===============================================================
/// Medley Page
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
///
/// Navigation only.
/// Repository -> Controller -> UI.
///
/// Future:
/// • Isar
/// • Sync Queue
/// • Firestore
/// ===============================================================

class MedleyPage extends StatefulWidget {
  const MedleyPage({super.key});

  @override
  State<MedleyPage> createState() => _MedleyPageState();
}

class _MedleyPageState extends State<MedleyPage> {
  late final MedleyController _controller;

  @override
  void initState() {
    super.initState();

    _controller = MedleyController(
      repository: MedleyRepository(),
    );

    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createMedley() async {
    final name = await MedleyDialogs.createMedley(context);

    if (name == null) return;

    await _controller.createMedley(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      createdBy: 'currentUser',
    );
  }

  Future<void> _openNodeList(BuildContext context, String title, List<dynamic> nodes) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: ListView.builder(
            itemCount: nodes.length,
            itemBuilder: (ctx, i) {
              final node = nodes[i];
              return MedleyNodeTile(
                node: node,
                onTap: () {
                  if (node.isFolder) {
                    _openNodeList(ctx, node.name ?? 'Folder', node.children);
                  } else if (node.isHymn && node.hymn != null) {
                    Navigator.push(
                      ctx,
                      MaterialPageRoute(
                        builder: (_) => HymnDetailPage(hymnId: node.hymn!.hymnId),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Medleys'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _createMedley,
            child: const Icon(Icons.add),
          ),
          body: _controller.isLoading
              ? const LoadingMedleyView()
              : _controller.medleys.isEmpty
                  ? const EmptyMedleyView()
                  : ListView.builder(
                      itemCount: _controller.medleys.length,
                      itemBuilder: (context, index) {
                        final medley = _controller.medleys[index];

                        return MedleyTile(
                          medley: medley,
                          onTap: () async {
                            final details = await _controller.getMedley(medley.id);
                            if (details == null) return;
                            await _openNodeList(context, details.name, details.children);
                          },
                        );
                      },
                    ),
        );
      },
    );
  }
}