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
      final snapshot = await _firestore.collection('hymns').get();

      final hymns = snapshot.docs.map((doc) {
        final data = doc.data();

        return LocalHymn()
          ..hymnId = doc.id
          ..title = data['title']?.toString() ?? 'Untitled Hymn'
          ..originalLyrics = data['lyrics']?.toString() ?? '';
      }).toList();

      if (hymns.isNotEmpty) {
        await AppInitializer.isar.writeTxn(
          () => AppInitializer.isar.localHymns.putAll(hymns),
        );
      }
    } catch (_) {}
  }

  home.HomeHymn _convertToHomeHymn(
    LocalHymn hymn,
    int index, {
    bool favorite = false,
  }) {
    return home.HomeHymn(
      hymnId: hymn.hymnId,
      serialNo: index + 1,
      pageNo: 0,
      title: hymn.title,
      favorite: favorite,
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

    return localHymns
        .asMap()
        .entries
        .map(
          (entry) =>
              _convertToHomeHymn(entry.value, entry.key),
        )
        .toList();
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

    return favorites
        .asMap()
        .entries
        .map((entry) =>
            _convertToHomeHymn(entry.value, entry.key, favorite: true))
        .toList();
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
    return _loadLocalHymns();
  }

  @override
  Future<List<home.HomeHymn>> search({
    String keyword = '',
    Set<String> keys = const {},
    Set<String> dedicated = const {},
    Set<int> years = const {},
    Set<String> beats = const {},
    home.HomeTab tab = home.HomeTab.allHymns,
  }) async {
    final source = tab == home.HomeTab.favorites
        ? await _loadFavoriteHymns()
        : await _loadLocalHymns();

    final filtered = source
        .where((hymn) => _matchesFilter(hymn, keys, dedicated, years, beats))
        .toList();

    return _applySearch(filtered, keyword);
  }

  @override
  Future<List<ViewList>> getAllViewLists() async {
    return await _viewListRepository.getViewLists();
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
  Future<void> changeTheme() async {}

  @override
  Future<void> invertTheme() async {}

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