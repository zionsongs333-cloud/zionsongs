import 'package:isar/isar.dart';
import '../hymn/hymn_models.dart';
import '../search/home_search_models.dart';

/// Repository used by the search UI.
/// Search is offline-first and always queries local Isar data.
class HomeSearchRepository {
  final Isar isar;

  HomeSearchRepository({required this.isar});

  Future<List<HomeSearchResult>> searchHymns(
    HomeSearchQuery query, {
    HomeSearchFilters? filters,
    int limit = 50,
  }) async {
    final text = query.text.trim();
    if (text.isEmpty) return [];

    final normalizedQuery = _normalizeText(text);
    final hymns = await isar.localHymns.where().findAll();
    final results = <HomeSearchResult>[];

    for (final h in hymns) {
      if (filters?.onlyFavorites == true) {
        continue;
      }

      final score = _matchScore(h, normalizedQuery);
      if (score == 0) continue;

      results.add(HomeSearchResult(
        srNo: h.hymnId,
        title: h.title,
        pageNo: null,
        favorite: false,
        snippet: _snippet(h, normalizedQuery),
        score: score.toDouble(),
      ));
    }

    results.sort((a, b) => b.score.compareTo(a.score));
    return results.take(limit).toList();
  }

  int _matchScore(LocalHymn hymn, String normalizedQuery) {
    if (_contains(hymn.searchText, normalizedQuery)) return 100;
    if (_contains(hymn.hindiLyrics, normalizedQuery)) return 90;
    if (_contains(hymn.malayalamLyrics, normalizedQuery)) return 80;
    if (_contains(hymn.englishLyrics, normalizedQuery)) return 70;
    if (_contains(hymn.originalLyrics, normalizedQuery)) return 60;
    if (_contains(hymn.title, normalizedQuery)) return 40;
    return 0;
  }

  bool _contains(String? value, String normalizedQuery) {
    if (value == null || value.isEmpty) return false;
    return _normalizeText(value).contains(normalizedQuery);
  }

  String _normalizeText(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[\r\n]+'), '\n')
        .replaceAll(RegExp(r'[^\n\w\s]', unicode: true), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String _snippet(LocalHymn hymn, String normalizedQuery) {
    final fields = <String?>[
      hymn.searchText,
      hymn.hindiLyrics,
      hymn.malayalamLyrics,
      hymn.englishLyrics,
      hymn.originalLyrics,
      hymn.title,
    ];

    for (final raw in fields) {
      if (raw == null || raw.isEmpty) continue;
      final normalizedRaw = _normalizeText(raw);
      if (normalizedRaw.contains(normalizedQuery)) {
        return _buildSnippet(raw, normalizedQuery);
      }
    }

    return '';
  }

  String _buildSnippet(String rawText, String normalizedQuery) {
    const offset = 60;
    final canonicalText = rawText.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
    final lower = canonicalText.toLowerCase();
    final index = lower.indexOf(normalizedQuery);

    if (index != -1) {
      final start = (index - offset).clamp(0, canonicalText.length);
      final end = (index + normalizedQuery.length + offset).clamp(0, canonicalText.length);
      var snippet = canonicalText.substring(start, end).trim();
      if (start > 0) snippet = '...$snippet';
      if (end < canonicalText.length) snippet = '$snippet...';
      return snippet;
    }

    final lines = canonicalText.split('\n');
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].toLowerCase().contains(normalizedQuery)) {
        final previous = i > 0 ? lines[i - 1].trim() : null;
        final next = i < lines.length - 1 ? lines[i + 1].trim() : null;
        final buffer = StringBuffer();
        if (previous != null && previous.isNotEmpty) {
          buffer.writeln(previous);
        }
        buffer.writeln(lines[i].trim());
        if (next != null && next.isNotEmpty) {
          buffer.write(next);
        }
        return buffer.toString();
      }
    }

    return canonicalText.length > 140
        ? '${canonicalText.substring(0, 140).trimRight()}...'
        : canonicalText;
  }
}
