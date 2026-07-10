// feature/home/search/home_search_models.dart

class HomeSearchQuery {
  final String text;

  const HomeSearchQuery({
    required this.text,
  });

  HomeSearchQuery copyWith({
    String? text,
  }) {
    return HomeSearchQuery(
      text: text ?? this.text,
    );
  }
}

class HomeSearchResult {
  final String srNo;
  final String title;
  final String? pageNo;
  final bool favorite;

  final String? snippet;
  final double score;

  const HomeSearchResult({
    required this.srNo,
    required this.title,
    this.pageNo,
    this.favorite = false,
    this.snippet,
    this.score = 0,
  });
}

class HomeSearchFilters {
  final bool onlyFavorites;

  const HomeSearchFilters({
    this.onlyFavorites = false,
  });

  HomeSearchFilters copyWith({
    bool? onlyFavorites,
  }) {
    return HomeSearchFilters(
      onlyFavorites: onlyFavorites ?? this.onlyFavorites,
    );
  }
}