import 'package:flutter/material.dart';

import 'medley_controller.dart';
import 'medley_dialogs.dart';
import 'medley_repository.dart';
import 'medley_widgets.dart';

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
                          onTap: () {
                            // Wiring to HymnDetailPage will be handled
                            // by the integration layer.
                          },
                        );
                      },
                    ),
        );
      },
    );
  }
}