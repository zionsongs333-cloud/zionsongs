/// ===============================================================
/// HomeFilter
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
///
/// Pure data model.
///
/// No UI.
/// No Isar.
/// No Firestore.
/// No Repository.
///
/// Stores the currently selected filters.
///
/// Supports MULTI-SELECTION.
/// ===============================================================

class HomeFilter {
  const HomeFilter({
    this.keys = const <String>{},
    this.dedicated = const <String>{},
    this.years = const <int>{},
    this.beats = const <String>{},
  });

  /// ===========================================================
  /// KEY
  ///
  /// Values:
  /// • Maj
  /// • Min
  /// • Blank
  /// ===========================================================

  final Set<String> keys;

  /// ===========================================================
  /// DEDICATED
  ///
  /// APPA
  /// AMMA
  /// AYYA
  /// ANNA
  /// MIX
  /// OTHERS
  /// ===========================================================

  final Set<String> dedicated;

  /// ===========================================================
  /// YEAR
  /// ===========================================================

  final Set<int> years;

  /// ===========================================================
  /// BEAT
  /// ===========================================================

  final Set<String> beats;

  // ===========================================================
  // HELPERS
  // ===========================================================

  bool get isEmpty {
    return keys.isEmpty &&
        dedicated.isEmpty &&
        years.isEmpty &&
        beats.isEmpty;
  }

  bool get hasFilters => !isEmpty;

  HomeFilter clear() {
    return const HomeFilter();
  }

  HomeFilter copyWith({
    Set<String>? keys,
    Set<String>? dedicated,
    Set<int>? years,
    Set<String>? beats,
  }) {
    return HomeFilter(
      keys: keys ?? this.keys,
      dedicated: dedicated ?? this.dedicated,
      years: years ?? this.years,
      beats: beats ?? this.beats,
    );
  }

  @override
  String toString() {
    return '''
HomeFilter(
  keys: $keys,
  dedicated: $dedicated,
  years: $years,
  beats: $beats,
)
''';
  }
}