
import 'package:isar/isar.dart';
import '../hymn/hymn_models.dart';
import '../search/home_search_models.dart';

class HomeSearchRepository {
  final Isar isar;

  HomeSearchRepository(this.isar);

  Future<List<HomeSearchResult>> searchHymns(
    HomeSearchQuery query, {
    HomeSearchFilters? filters,
    int limit = 50,
  }) async {
    final text = query.text.trim().toLowerCase();
    if (text.isEmpty) return [];

    final hymns = await isar.localHymns.where().findAll();

    final List<HomeSearchResult> results = [];

    for (final h in hymns) {
      if (filters?.onlyFavorites == true) {
        continue;
      }

      final title = h.title.toLowerCase();
      final searchText = h.originalLyrics.toLowerCase();

      double score = 0;
      String? snippet;

      if (searchText.contains(text)) {
        score = 100;
        snippet = _snippet(h.originalLyrics, text);
      } else if (title.contains(text)) {
        score = 50;
        snippet = _snippet(h.title, text);
      }

      if (score == 0) continue;

      results.add(HomeSearchResult(
        srNo: h.hymnId,
        title: h.title,
        pageNo: null,
        favorite: false,
        snippet: snippet,
        score: score,
      ));
    }

    results.sort((a, b) => b.score.compareTo(a.score));

    return results.take(limit).toList();
  }

  String _snippet(String text, String query) {
    if (text.isEmpty) return '';

    final normalized = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
    final lower = normalized.toLowerCase();
    final index = lower.indexOf(query.toLowerCase());

    if (index == -1) {
      return normalized.length > 140
          ? '${normalized.substring(0, 140).trimRight()}...'
          : normalized;
    }

    final lineStart = normalized.lastIndexOf('\n', index) + 1;
    final lineEnd = normalized.indexOf('\n', index + query.length);
    final line = normalized
        .substring(
          lineStart,
          lineEnd == -1 ? normalized.length : lineEnd,
        )
        .trim();

    if (line.isNotEmpty) {
      return line.length > 140 ? '${line.substring(0, 140).trimRight()}...' : line;
    }

    const offset = 60;

    final start = (index - offset).clamp(0, normalized.length);
    final end = (index + query.length + offset).clamp(0, normalized.length);

    return normalized.substring(start, end).trim();
  }
}