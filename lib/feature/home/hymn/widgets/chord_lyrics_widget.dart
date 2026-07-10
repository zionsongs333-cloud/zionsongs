import 'package:flutter/material.dart';
import 'chord_parser_service.dart';

class ChordLyricsWidget extends StatelessWidget {
  final String lyrics;
  final bool showChords;

  const ChordLyricsWidget({
    super.key,
    required this.lyrics,
    required this.showChords,
  });

  @override
  Widget build(BuildContext context) {
    if (!showChords) {
      return SelectableText(
        ChordParserService.stripChordMarkers(lyrics),
        style: const TextStyle(fontFamily: 'monospace', height: 1.4),
      );
    }

    final lines = ChordParserService.parseLyrics(lyrics);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: lines.map((segments) {
        if (segments.length == 1 && segments.first.chord.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: SelectableText(
              segments.first.lyric,
              style: const TextStyle(fontFamily: 'monospace', height: 1.4),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: segments.map((segment) {
              return IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (segment.chord.isNotEmpty)
                      Text(
                        segment.chord,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    Text(
                      segment.lyric,
                      style: const TextStyle(fontFamily: 'monospace', height: 1.4),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
