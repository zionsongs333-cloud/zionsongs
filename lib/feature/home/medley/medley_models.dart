import '../home_models.dart';

/// ===============================================================
/// Medley Models
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
///
/// Pure UI/domain models.
///
/// These are NOT Isar models.
/// These are NOT Firestore models.
///
/// Medleys are GLOBAL.
///
/// ===============================================================

enum MedleyApprovalStatus {
  pending,
  approved,
  rejected,
}

enum MedleyNodeType {
  folder,
  hymn,
}

class Medley {
  const Medley({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdOn,
    this.parentId,
    this.children = const [],
    this.approvalStatus = MedleyApprovalStatus.approved,
  });

  final String id;

  final String name;

  final String createdBy;

  final DateTime createdOn;

  final String? parentId;

  final List<MedleyNode> children;
  
  final MedleyApprovalStatus approvalStatus;

  Medley copyWith({
    String? id,
    String? name,
    String? createdBy,
    DateTime? createdOn,
    String? parentId,
    List<MedleyNode>? children,
    MedleyApprovalStatus? approvalStatus,
  }) {
    return Medley(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      parentId: parentId ?? this.parentId,
      children: children ?? this.children,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }
}

class MedleyNode {
  const MedleyNode._({
    required this.id,
    required this.type,
    this.name,
    this.hymn,
    this.parentId,
    this.children = const [],
  });

  factory MedleyNode.folder({
    required String id,
    required String name,
    String? parentId,
    List<MedleyNode> children = const [],
  }) {
    return MedleyNode._(
      id: id,
      type: MedleyNodeType.folder,
      name: name,
      parentId: parentId,
      children: children,
    );
  }

  factory MedleyNode.hymn({
    required String id,
    required HomeHymn hymn,
    String? parentId,
  }) {
    return MedleyNode._(
      id: id,
      type: MedleyNodeType.hymn,
      hymn: hymn,
      parentId: parentId,
    );
  }

  final String id;

  final MedleyNodeType type;

  final String? name;

  final HomeHymn? hymn;

  final String? parentId;

  final List<MedleyNode> children;

  bool get isFolder => type == MedleyNodeType.folder;

  bool get isHymn => type == MedleyNodeType.hymn;

  MedleyNode copyWith({
    String? id,
    MedleyNodeType? type,
    String? name,
    HomeHymn? hymn,
    String? parentId,
    List<MedleyNode>? children,
  }) {
    return MedleyNode._(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      hymn: hymn ?? this.hymn,
      parentId: parentId ?? this.parentId,
      children: children ?? this.children,
    );
  }
}

class PendingMedleyRequest {
  const PendingMedleyRequest({
    required this.id,
    required this.userId,
    required this.medleyId,
    required this.nodeId,
    required this.status,
    required this.createdOn,
  });

  final String id;

  final String userId;

  final String medleyId;

  final String nodeId;

  final MedleyApprovalStatus status;

  final DateTime createdOn;
}