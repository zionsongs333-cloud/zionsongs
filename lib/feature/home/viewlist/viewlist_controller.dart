import 'package:flutter/foundation.dart';

import '../home_models.dart';
import 'viewlist_models.dart';
import 'viewlist_repository.dart';

/// ===============================================================
/// ViewListController
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
/// ---------------------------------------------------------------
///
/// UI controller for View Lists.
///
/// Responsibilities
/// • Load View Lists
/// • Create View Lists
/// • Rename View Lists
/// • Add Hymns
/// • Add Folders
/// • Notify listeners
///
/// Never talks to Firestore.
/// Never talks directly to Isar.
/// ===============================================================
class ViewListController extends ChangeNotifier {
  ViewListController({
    required ViewListRepository repository,
  }) : _repository = repository;

  final ViewListRepository _repository;

  final List<ViewList> _viewLists = [];

  bool _loading = false;

  bool get isLoading => _loading;

  List<ViewList> get viewLists => List.unmodifiable(_viewLists);

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    _viewLists
      ..clear()
      ..addAll(await _repository.getViewLists());

    _loading = false;
    notifyListeners();
  }

  Future<void> createViewList({
    required String id,
    required String name,
    required String zoneId,
    required String createdBy,
  }) async {
    final list = await _repository.createViewList(
      id: id,
      name: name,
      zoneId: zoneId,
      createdBy: createdBy,
    );

    _viewLists.add(list);
    notifyListeners();
  }

  Future<void> renameViewList(
    String id,
    String newName,
  ) async {
    await _repository.renameViewList(
      id,
      newName,
    );

    await load();
  }

  Future<ViewListNode> createFolder({
    required String id,
    required String name,
    String? parentId,
  }) {
    return _repository.createFolder(
      id: id,
      name: name,
      parentId: parentId,
    );
  }

  Future<ViewListNode> addHymn(
    HomeHymn hymn,
  ) {
    return _repository.createHymnNode(hymn);
  }

  Future<PendingViewListRequest> requestApproval({
    required String requestId,
    required String userId,
    required String zoneId,
    required String nodeId,
  }) {
    return _repository.requestApproval(
      requestId: requestId,
      userId: userId,
      zoneId: zoneId,
      nodeId: nodeId,
    );
  }
}