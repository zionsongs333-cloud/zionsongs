import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';

import '../hymn/app_initializer.dart';
import '../hymn/hymn_auth_service.dart';
import '../hymn/hymn_models.dart';
import '../hymn/hymn_sync_logic.dart';
import '../home_models.dart' as home;
import '../viewlist/viewlist_models.dart';
import '../viewlist/viewlist_repository.dart';
import '../medley/medley_models.dart';
import '../medley/medley_repository.dart';
import 'home_repository.dart';
import 'pdf_export_service.dart';
import 'theme_service.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  final ViewListRepository _viewListRepository = ViewListRepository();
  final MedleyRepository _medleyRepository = MedleyRepository();
  final PdfExportService _pdfService = PdfExportService();

  Future<void> _syncLater() async {
    final userId = AuthService.userId;
    if (userId.isEmpty) return;

    try {
      await SyncLogic.attemptSync(AppInitializer.isar, userId);
    } catch (_) {}
  }

  Future<void> _bootstrapIfEmpty() async {
    final count = await AppInitializer.isar.localHymns.count();
    if (count > 0) return;

    try {
      // Diagnostic
      // ignore: avoid_print
      print('Reading collection hymns (bootstrap)');

      final snapshot = await _firestore.collection('hymns').get();

      // ignore: avoid_print
      print('Documents found: ${snapshot.docs.length}');

      final hymns = snapshot.docs.map((doc) {
        final data = doc.data();

        // ignore: avoid_print
        // print('Doc ${doc.id} data: $data');

        final lh = LocalHymn()
          ..hymnId = doc.id
          ..title = data['title']?.toString() ?? 'Untitled Hymn'
          ..originalLyrics = (data['lyrics'] ?? data['originalLyrics'])?.toString() ?? '';

        lh.key = (data['key'] ?? data['code'])?.toString();
        lh.dedicated = data['dedicated']?.toString();
        lh.year = data['year']?.toString();
        lh.beat = data['beat']?.toString();
        lh.style = data['style']?.toString();
        lh.searchText = (data['searchText'] ?? data['search_text'])?.toString();
        lh.hindiLyrics = data['Hindi']?.toString();
        lh.malayalamLyrics = data['Malayalam']?.toString();
        lh.englishLyrics = data['English']?.toString();

        final tempoVal = data['tempo'];
        if (tempoVal is int) lh.tempo = tempoVal;
        if (tempoVal is String) lh.tempo = int.tryParse(tempoVal);

        return lh;
      }).toList();

      // ignore: avoid_print
      print('Mapped hymns: ${hymns.length}');

      if (hymns.isNotEmpty) {
        await AppInitializer.isar.writeTxn(
          () => AppInitializer.isar.localHymns.putAll(hymns),
        );
      }
    } catch (e, s) {
      // Do not hide exceptions — surface them for debugging
      // ignore: avoid_print
      print('Error bootstrapping from Firestore: $e\n$s');
      rethrow;
    }
  }

  Future<home.HomeHymn> _convertToHomeHymn(
    LocalHymn hymn,
    int index, {
    bool favorite = false,
  }) async {
    // Try to get user's overrides
    String? key = hymn.key;
    String? beat = hymn.beat;
    String? style = hymn.style;
    int? tempo = hymn.tempo;
    String? dedicated = hymn.dedicated;
    String? year = hymn.year;

    try {
      final pref = await AppInitializer.isar.userHymnPrefs
          .filter()
          .hymnIdEqualTo(hymn.hymnId)
          .findFirst();

      if (pref != null) {
        key = pref.manualKey ?? key;
        beat = pref.beat.isNotEmpty ? pref.beat : beat;
        style = pref.style.isNotEmpty ? pref.style : style;
        tempo = pref.tempo != 0 ? pref.tempo : tempo;
      }
    } catch (_) {}

    return home.HomeHymn(
      hymnId: hymn.hymnId,
      serialNo: index + 1,
      pageNo: 0,
      title: hymn.title,
      favorite: favorite,
      key: key,
      dedicated: dedicated,
      year: year,
      beat: beat,
      style: style,
      tempo: tempo,
    );
  }

  Future<List<home.HomeHymn>> _loadLocalHymns() async {
    var localHymns =
        await AppInitializer.isar.localHymns.where().findAll();

    if (localHymns.isEmpty) {
      await _bootstrapIfEmpty();
      localHymns =
          await AppInitializer.isar.localHymns.where().findAll();
    }

    final list = <home.HomeHymn>[];
    for (final entry in localHymns.asMap().entries) {
      final h = await _convertToHomeHymn(entry.value, entry.key);
      list.add(h);
    }
    return list;
  }

  Future<List<home.HomeHymn>> _returnWithLog(List<home.HomeHymn> hymns) async {
    // ignore: avoid_print
    print('Returning hymns: ${hymns.length}');
    return hymns;
  }

  Future<List<home.HomeHymn>> _loadFavoriteHymns() async {
    final userId = AuthService.userId;
    if (userId.isEmpty) return [];

    final notes = await AppInitializer.isar.userNotes
        .filter()
        .userIdEqualTo(userId)
        .noteTypeEqualTo(NOTE_TYPE_FAVORITES)
        .findAll();

    final hymnIds = notes.map((note) => note.hymnId).toSet();
    if (hymnIds.isEmpty) return [];

    final favorites = await AppInitializer.isar.localHymns
        .filter()
        .anyOf(hymnIds, (q, value) => q.hymnIdEqualTo(value))
        .findAll();

    final list = <home.HomeHymn>[];
    for (final entry in favorites.asMap().entries) {
      final h = await _convertToHomeHymn(entry.value, entry.key, favorite: true);
      list.add(h);
    }
    return list;
  }

  bool _matchesFilter(
    home.HomeHymn hymn,
    Set<String> keys,
    Set<String> dedicated,
    Set<int> years,
    Set<String> beats,
  ) {
    if (keys.isNotEmpty) {
      if (hymn.key == null || !keys.contains(hymn.key)) {
        return false;
      }
    }

    if (dedicated.isNotEmpty) {
      if (hymn.dedicated == null || !dedicated.contains(hymn.dedicated)) {
        return false;
      }
    }

    if (years.isNotEmpty) {
      final year = hymn.year != null ? int.tryParse(hymn.year!) : null;
      if (year == null || !years.contains(year)) {
        return false;
      }
    }

    if (beats.isNotEmpty) {
      if (hymn.beat == null || !beats.contains(hymn.beat)) {
        return false;
      }
    }

    return true;
  }

  List<home.HomeHymn> _applySearch(
    List<home.HomeHymn> hymns,
    String searchText,
  ) {
    if (searchText.isEmpty) return hymns;

    final query = searchText.toLowerCase();
    return hymns.where((hymn) {
      return hymn.title.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Future<List<home.HomeHymn>> getAllHymns() {
    return _loadLocalHymns().then((h) => _returnWithLog(h));
  }

  @override
  Future<List<home.HomeHymn>> search({
    String keyword = '',
    Set<String> keys = const {},
    Set<String> dedicated = const {},
    Set<int> years = const {},
    Set<String> beats = const {},
    Set<String> styles = const {},
    Set<int> tempos = const {},
    home.HomeTab tab = home.HomeTab.allHymns,
  }) async {
    // If a keyword is provided, prefer querying Firestore's `searchText`.
    if (keyword.trim().isNotEmpty) {
      try {
        // Diagnostic
        // ignore: avoid_print
        print('Searching Firestore collection hymns for keyword: $keyword');

        final snapshot = await _firestore.collection('hymns').get();

        // ignore: avoid_print
        print('Documents found: ${snapshot.docs.length}');

        final docs = snapshot.docs.where((doc) {
          final data = doc.data();
          final st = (data['searchText'] ?? data['search_text'] ?? data['lyrics'] ?? '')
              .toString()
              .toLowerCase();
          return st.contains(keyword.toLowerCase());
        }).toList();

        // ignore: avoid_print
        print('Mapped hymns: ${docs.length}');

        final hymns = docs
            .asMap()
            .entries
            .map((entry) {
              final doc = entry.value;
              final data = doc.data();
              return home.HomeHymn(
                hymnId: doc.id,
                serialNo: entry.key + 1,
                pageNo: 0,
                title: data['title']?.toString() ?? 'Untitled Hymn',
                favorite: false,
                key: (data['key'] ?? data['code'])?.toString(),
                dedicated: data['dedicated']?.toString(),
                year: data['year']?.toString(),
                beat: data['beat']?.toString(),
                style: data['style']?.toString(),
                tempo: data['tempo'] is int ? data['tempo'] as int : int.tryParse((data['tempo'] ?? '').toString()),
              );
            })
            .toList();

        // ignore: avoid_print
        print('Returning hymns: ${hymns.length}');

        return hymns;
      } catch (e, s) {
        // ignore: avoid_print
        print('Error searching Firestore: $e\n$s');
        rethrow;
      }
    }

    final source = tab == home.HomeTab.favorites
        ? await _loadFavoriteHymns()
        : await _loadLocalHymns();

    final filtered = source
        .where((hymn) => _matchesFilter(hymn, keys, dedicated, years, beats))
        .where((hymn) {
          if (styles.isNotEmpty) {
            return hymn.style != null && styles.contains(hymn.style);
          }
          return true;
        })
        .where((hymn) {
          if (tempos.isNotEmpty) {
            return hymn.tempo != null && tempos.contains(hymn.tempo);
          }
          return true;
        })
        .toList();

    return _applySearch(filtered, keyword);
  }

  @override
  Future<List<ViewList>> getAllViewLists() async {
    return await _viewListRepository.getViewLists();
  }

  // ============================================================
  // FILTER DATA IMPLEMENTATIONS
  // ============================================================

  @override
  Future<List<String>> getAvailableKeys() async {
    final hymns = await AppInitializer.isar.localHymns.where().findAll();
    final set = <String>{};
    for (final h in hymns) {
      if (h.key != null && h.key!.trim().isNotEmpty) set.add(h.key!.trim());
    }
    return set.toList()..sort();
  }

  @override
  Future<List<String>> getAvailableDedicated() async {
    final hymns = await AppInitializer.isar.localHymns.where().findAll();
    final set = <String>{};
    for (final h in hymns) {
      if (h.dedicated != null && h.dedicated!.trim().isNotEmpty) set.add(h.dedicated!.trim());
    }
    return set.toList()..sort();
  }

  @override
  Future<List<int>> getAvailableYears() async {
    final hymns = await AppInitializer.isar.localHymns.where().findAll();
    final set = <int>{};
    for (final h in hymns) {
      if (h.year != null && h.year!.trim().isNotEmpty) {
        final y = int.tryParse(h.year!.trim());
        if (y != null) set.add(y);
      }
    }
    final list = set.toList()..sort();
    return list;
  }

  @override
  Future<List<String>> getAvailableBeats() async {
    final hymns = await AppInitializer.isar.localHymns.where().findAll();
    final set = <String>{};
    for (final h in hymns) {
      if (h.beat != null && h.beat!.trim().isNotEmpty) set.add(h.beat!.trim());
    }
    return set.toList()..sort();
  }

  @override
  Future<List<String>> getAvailableStyles() async {
    final hymns = await AppInitializer.isar.localHymns.where().findAll();
    final set = <String>{};
    for (final h in hymns) {
      if (h.style != null && h.style!.trim().isNotEmpty) set.add(h.style!.trim());
    }
    return set.toList()..sort();
  }

  @override
  Future<List<int>> getAvailableTempos() async {
    final hymns = await AppInitializer.isar.localHymns.where().findAll();
    final set = <int>{};
    for (final h in hymns) {
      if (h.tempo != null) set.add(h.tempo!);
    }
    final list = set.toList()..sort();
    return list;
  }

  @override
  Future<List<Medley>> getAllMedleys() async {
    return await _medleyRepository.getMedleys();
  }

  @override
  Future<void> addToFavorites(
    List<String> hymnIds,
  ) async {
    final userId = AuthService.userId;

    if (userId.isEmpty) return;

    final notes = hymnIds.map(
      (hymnId) {
        return UserNote()
          ..noteId = '$hymnId-favorite-$userId'
          ..hymnId = hymnId
          ..folderId = ''
          ..title = 'Favorite'
          ..content = 'favorite'
          ..userId = userId
          ..noteType = NOTE_TYPE_FAVORITES
          ..createdOn = now()
          ..modifiedOn = now()
          ..syncStatus = SyncStatus.pending;
      },
    ).toList();

    await AppInitializer.isar.writeTxn(
      () => AppInitializer.isar.userNotes.putAll(notes),
    );

    unawaited(_syncLater());
  }

  @override
  Future<void> removeFromFavorites(
    List<String> hymnIds,
  ) async {
    final userId = AuthService.userId;

    if (userId.isEmpty) return;

    final ids = <int>[];

    for (final hymnId in hymnIds) {
      final notes = await AppInitializer.isar.userNotes
          .filter()
          .hymnIdEqualTo(hymnId)
          .userIdEqualTo(userId)
          .noteTypeEqualTo(NOTE_TYPE_FAVORITES)
          .findAll();

      ids.addAll(notes.map((e) => e.id));
    }

    if (ids.isNotEmpty) {
      await AppInitializer.isar.writeTxn(
        () => AppInitializer.isar.userNotes.deleteAll(ids),
      );

      unawaited(_syncLater());
    }
  }

  @override
  Future<void> addToViewList({
    required List<String> hymnIds,
    required String viewListId,
  }) async {
    unawaited(_syncLater());
  }

  @override
  Future<void> addToMedley({
    required List<String> hymnIds,
    required String medleyId,
  }) async {
    unawaited(_syncLater());
  }

  @override
  Future<void> exportPdf(
    List<String> hymnIds,
  ) async {
    await _pdfService.exportHymns(
      hymnIds: hymnIds,
    );
  }

  @override
  Future<void> importExcel() async {}

  @override
  Future<void> exportExcel() async {}

  @override
  Future<void> changeTheme() async {
    ThemeService.changeTheme();
  }

  @override
  Future<void> invertTheme() async {
    ThemeService.invertTheme();
  }

  @override
  Future<void> presentationMode() async {}

  @override
  Future<void> openNotifications() async {}

  @override
  Future<void> openSettings() async {}

  @override
  Future<void> openStatistics() async {}

  @override
  Future<void> openHelp() async {}

  @override
  Future<void> sendFeedback() async {}

  @override
  Future<void> openAbout() async {}
}