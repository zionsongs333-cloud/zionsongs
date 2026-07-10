import 'package:flutter/material.dart';

import 'hymn_detail_screen.dart';

class HymnDetailPage extends StatelessWidget {
  final String hymnId;

  const HymnDetailPage({
    super.key,
    required this.hymnId,
  });

  @override
  Widget build(BuildContext context) {
    return HymnDetailScreen(hymnId: hymnId);
  }
}
