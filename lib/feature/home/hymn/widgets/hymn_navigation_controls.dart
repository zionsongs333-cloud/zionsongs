import 'package:flutter/material.dart';
import '../hymn_models.dart';

class HymnNavigationControls extends StatelessWidget {
  final LocalHymn? previous;
  final LocalHymn? next;
  final LocalHymn current;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const HymnNavigationControls({
    super.key,
    this.previous,
    this.next,
    required this.current,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 120),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.92 * 255).round()),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              tooltip: 'Previous hymn',
              onPressed: previous == null ? null : onPrevious,
            ),
            Text(current.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              tooltip: 'Next hymn',
              onPressed: next == null ? null : onNext,
            ),
          ],
        ),
      ),
    );
  }
}
