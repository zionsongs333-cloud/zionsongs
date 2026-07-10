import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'app_initializer.dart';
import 'hymn_info_bar.dart';
import 'hymn_models.dart';

class HymnDetailPage extends StatefulWidget {
  final String hymnId;

  const HymnDetailPage({
    super.key,
    required this.hymnId,
  });

  @override
  State<HymnDetailPage> createState() => _HymnDetailPageState();
}

class _HymnDetailPageState extends State<HymnDetailPage> {
  LocalHymn? _hymn;

  @override
  void initState() {
    super.initState();
    _loadHymn();
  }

  Future<void> _loadHymn() async {
    final results = await AppInitializer.isar.localHymns
        .filter()
        .hymnIdEqualTo(widget.hymnId)
        .findAll();
    final hymn = results.isEmpty ? null : results.first;

    if (mounted) {
      setState(() {
        _hymn = hymn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hymn == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_hymn!.title),
      ),
      body: HymnInfoBar(
        hymnId: _hymn!.hymnId,
        lyrics: _hymn!.originalLyrics,
        title: _hymn!.title,
        isar: AppInitializer.isar,
      ),
    );
  }
}