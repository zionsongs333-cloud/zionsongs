import '../home_models.dart';
import 'viewlist_models.dart';

/// ===============================================================
/// ViewList Repository
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
/// ---------------------------------------------------------------
///
/// This repository is the single source of truth for View Lists.
///
/// UI never talks directly to Isar or Firestore.
///
/// Today:
/// • In-memory implementation.
///
/// Future:
/// • Isar
/// • Sync Queue
/// • Firestore
/// ===============================================================
class ViewListRepository {
  ViewListRepository();

  final List<ViewList> _viewLists = [];

  /// -------------------------------------------------------------
  /// Root View Lists
  /// -------------------------------------------------------------
  Future<List<ViewList>> getViewLists() async {
    return List.unmodifiable(_viewLists);
  }

  /// -------------------------------------------------------------
  /// Get one View List
  /// -------------------------------------------------------------
  Future<ViewList?> getViewList(String id) async {
    try {
      return _viewLists.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  /// -------------------------------------------------------------
  /// Create View List
  /// -------------------------------------------------------------
  Future<ViewList> createViewList({
    required String id,
    required String name,
    required String zoneId,
    required String createdBy,
  }) async {
    final list = ViewList(
      id: id,
      name: name,
      zoneId: zoneId,
      createdBy: createdBy,
      createdOn: DateTime.now(),
    );

    _viewLists.add(list);

    return list;
  }

  /// -------------------------------------------------------------
  /// Rename
  /// -------------------------------------------------------------
  Future<void> renameViewList(
    String id,
    String newName,
  ) async {
    final index = _viewLists.indexWhere((e) => e.id == id);

    if (index == -1) return;

    final old = _viewLists[index];

    _viewLists[index] = ViewList(
      id: old.id,
      name: newName,
      zoneId: old.zoneId,
      createdBy: old.createdBy,
      createdOn: old.createdOn,
      parentId: old.parentId,
      children: old.children,
    );
  }

  /// -------------------------------------------------------------
  /// Add Folder
  /// -------------------------------------------------------------
  Future<ViewListNode> createFolder({
    required String id,
    required String name,
    String? parentId,
  }) async {
    return ViewListNode.folder(
      id: id,
      name: name,
      parentId: parentId,
    );
  }

  /// -------------------------------------------------------------
  /// Add Hymn
  /// -------------------------------------------------------------
  Future<ViewListNode> createHymnNode(
    HomeHymn hymn,
  ) async {
    return ViewListNode.hymn(
      id: hymn.hymnId,
      hymn: hymn,
    );
  }

  /// -------------------------------------------------------------
  /// Copy Hymn
  /// -------------------------------------------------------------
  Future<ViewListNode> copyNode(
    ViewListNode node,
  ) async {
    if (node.type == ViewListNodeType.folder) {
      return ViewListNode.folder(
        id: node.id,
        name: node.name,
        parentId: node.parentId,
        children: List.from(node.children),
      );
    }

    return ViewListNode.hymn(
      id: node.id,
      hymn: node.hymn!,
      parentId: node.parentId,
    );
  }

  /// -------------------------------------------------------------
  /// Delete is intentionally disabled.
  /// -------------------------------------------------------------
  Future<void> deleteNode(String id) async {
    // Disabled by project requirements.
  }

  /// -------------------------------------------------------------
  /// Approval Request
  /// -------------------------------------------------------------
  Future<PendingViewListRequest> requestApproval({
    required String requestId,
    required String userId,
    required String zoneId,
    required String nodeId,
  }) async {
    return PendingViewListRequest(
      id: requestId,
      userId: userId,
      zoneId: zoneId,
      nodeId: nodeId,
      status: ViewListApprovalStatus.pending,
      createdOn: DateTime.now(),
    );
  }
}