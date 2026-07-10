import '../home_models.dart';
import 'medley_models.dart';

/// ===============================================================
/// Medley Repository
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
///
/// Single source of truth for Medleys.
///
/// Today
/// • In-memory
///
/// Future
/// • Isar
/// • Sync Queue
/// • Firestore
///
/// UI must ONLY talk to this repository.
/// ===============================================================

class MedleyRepository {
  MedleyRepository();

  final List<Medley> _medleys = [];

  /// --------------------------------------------------------------
  /// Root Medleys
  /// --------------------------------------------------------------

  Future<List<Medley>> getMedleys() async {
    return List.unmodifiable(_medleys);
  }

  /// --------------------------------------------------------------
  /// Get one Medley
  /// --------------------------------------------------------------

  Future<Medley?> getMedley(String id) async {
    try {
      return _medleys.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  /// --------------------------------------------------------------
  /// Create Medley
  /// --------------------------------------------------------------

  Future<Medley> createMedley({
    required String id,
    required String name,
    required String createdBy,
  }) async {
    final medley = Medley(
      id: id,
      name: name,
      createdBy: createdBy,
      createdOn: DateTime.now(),
    );

    _medleys.add(medley);

    return medley;
  }

  /// --------------------------------------------------------------
  /// Rename
  /// --------------------------------------------------------------

  Future<void> renameMedley(
    String id,
    String newName,
  ) async {
    final index = _medleys.indexWhere((e) => e.id == id);

    if (index == -1) return;

    _medleys[index] = _medleys[index].copyWith(
      name: newName,
    );
  }

  /// --------------------------------------------------------------
  /// Folder
  /// --------------------------------------------------------------

  Future<MedleyNode> createFolder({
    required String id,
    required String name,
    String? parentId,
  }) async {
    return MedleyNode.folder(
      id: id,
      name: name,
      parentId: parentId,
    );
  }

  /// --------------------------------------------------------------
  /// Hymn
  /// --------------------------------------------------------------

  Future<MedleyNode> createHymnNode(
    HomeHymn hymn,
  ) async {
    return MedleyNode.hymn(
      id: hymn.hymnId,
      hymn: hymn,
    );
  }

  /// --------------------------------------------------------------
  /// Copy
  /// --------------------------------------------------------------

  Future<MedleyNode> copyNode(
    MedleyNode node,
  ) async {
    if (node.isFolder) {
      return MedleyNode.folder(
        id: node.id,
        name: node.name ?? '',
        parentId: node.parentId,
        children: List.from(node.children),
      );
    }

    return MedleyNode.hymn(
      id: node.id,
      hymn: node.hymn!,
      parentId: node.parentId,
    );
  }

  /// --------------------------------------------------------------
  /// Move
  /// --------------------------------------------------------------

  Future<MedleyNode> moveNode({
    required MedleyNode node,
    String? newParentId,
  }) async {
    return node.copyWith(
      parentId: newParentId,
    );
  }

  /// --------------------------------------------------------------
  /// Copy from View List
  /// --------------------------------------------------------------

  Future<MedleyNode> importFromViewList(
    HomeHymn hymn,
  ) async {
    return createHymnNode(hymn);
  }

  /// --------------------------------------------------------------
  /// Delete disabled by design.
  /// --------------------------------------------------------------

  Future<void> deleteNode(String id) async {}

  /// --------------------------------------------------------------
  /// Approval Request
  /// --------------------------------------------------------------

  Future<PendingMedleyRequest> requestApproval({
    required String requestId,
    required String userId,
    required String medleyId,
    required String nodeId,
  }) async {
    return PendingMedleyRequest(
      id: requestId,
      userId: userId,
      medleyId: medleyId,
      nodeId: nodeId,
      status: MedleyApprovalStatus.pending,
      createdOn: DateTime.now(),
    );
  }
}