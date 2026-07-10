import '../home_models.dart';

/// ===============================================================
/// View List Models
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
/// ---------------------------------------------------------------
/// UI/domain models only.
///
/// No Firestore.
/// No Isar annotations.
///
/// The repository is responsible for converting database records
/// into these models.
/// ===============================================================

enum ViewListApprovalStatus {
  none,
  pending,
  approved,
  rejected,
}

enum ViewListNodeType {
  folder,
  hymn,
}

/// ===============================================================
/// ViewList
/// ---------------------------------------------------------------
/// Root View List.
/// ===============================================================
class ViewList {
  const ViewList({
    required this.id,
    required this.name,
    required this.zoneId,
    required this.createdBy,
    required this.createdOn,
    this.parentId,
    this.children = const [],
  });

  final String id;
  final String name;

  /// EVG Zone
  final String zoneId;

  final String createdBy;
  final DateTime createdOn;

  /// null = root folder
  final String? parentId;

  final List<ViewListNode> children;
}

/// ===============================================================
/// ViewListNode
/// ---------------------------------------------------------------
/// Folder OR Hymn.
/// ===============================================================
class ViewListNode {
  const ViewListNode.folder({
    required this.id,
    required this.name,
    this.parentId,
    this.children = const [],
  })  : type = ViewListNodeType.folder,
        hymn = null;

  const ViewListNode.hymn({
    required this.id,
    required this.hymn,
    this.parentId,
  })  : type = ViewListNodeType.hymn,
        name = '',
        children = const [];

  final String id;

  final ViewListNodeType type;

  final String name;

  final String? parentId;

  final HomeHymn? hymn;

  final List<ViewListNode> children;
}

/// ===============================================================
/// PendingViewListRequest
/// ---------------------------------------------------------------
/// Used when a Viewer requests a View List change.
/// ===============================================================
class PendingViewListRequest {
  const PendingViewListRequest({
    required this.id,
    required this.userId,
    required this.zoneId,
    required this.nodeId,
    required this.status,
    required this.createdOn,
  });

  final String id;

  final String userId;

  final String zoneId;

  final String nodeId;

  final ViewListApprovalStatus status;

  final DateTime createdOn;
}