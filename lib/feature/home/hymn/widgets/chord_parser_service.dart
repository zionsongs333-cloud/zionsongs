class ChordSegment {
  final String chord;
  final String lyric;

  const ChordSegment({required this.chord, required this.lyric});
}

class ChordParserService {
  static final _bracketedChordRegex = RegExp(r'(\[[^\]]+\])');

  static String stripChordMarkers(String text) {
    return text.replaceAll(RegExp(r'\[[^\]]+\]'), '');
  }

  static List<List<ChordSegment>> parseLyrics(String lyrics) {
    return lyrics.split('\n').map(parseLine).toList();
  }

  static List<ChordSegment> parseLine(String line) {
    final parts = line.split(_bracketedChordRegex).where((part) => part.isNotEmpty).toList();
    final segments = <ChordSegment>[];
    String? currentChord;

    for (final part in parts) {
      if (part.startsWith('[') && part.endsWith(']')) {
        currentChord = part.substring(1, part.length - 1);
        continue;
      }

      final lyric = part.replaceAll(RegExp(r'\s+'), ' ');
      if (lyric.isEmpty) {
        currentChord = null;
        continue;
      }

      segments.add(ChordSegment(
        chord: currentChord ?? '',
        lyric: lyric,
      ));
      currentChord = null;
    }

    if (segments.isEmpty) {
      return [ChordSegment(chord: '', lyric: line)];
    }

    return segments;
  }
}
