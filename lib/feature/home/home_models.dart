/// ===============================================================
/// Home Models
/// ---------------------------------------------------------------
///
/// Pure UI models used by the Home feature.
///
/// OFFLINE FIRST
///
/// These models are NOT Isar models.
/// These models are NOT Firestore models.
///
/// They are lightweight objects returned by HomeRepository.
///
/// ===============================================================

enum HomeTab {
  allHymns,
  favorites,
  viewLists,
  medleys,
}

class HomeHymn {
  const HomeHymn({
    required this.hymnId,
    required this.serialNo,
    required this.pageNo,
    required this.title,
    required this.favorite,
    this.key,
    this.dedicated,
    this.year,
    this.beat,
    this.style,
    this.tempo,
  });

  final String hymnId;

  final int serialNo;

  final int pageNo;

  final String title;

  final bool favorite;

  final String? key;

  final String? dedicated;

  final String? year;

  final String? beat;
  
  final String? style;

  final int? tempo;
}

class HomeViewList {
  const HomeViewList({
    required this.id,
    required this.name,
  });

  final String id;

  final String name;
}

class HomeMedley {
  const HomeMedley({
    required this.id,
    required this.name,
  });

  final String id;

  final String name;
}