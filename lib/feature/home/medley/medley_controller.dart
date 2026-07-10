import 'package:flutter/foundation.dart';

import 'medley_models.dart';
import 'medley_repository.dart';

/// ===============================================================
/// Medley Controller
/// ---------------------------------------------------------------
///
/// OFFLINE FIRST
///
/// UI <-> Controller <-> Repository
///
/// Widgets must never access the repository directly.
///
/// Future:
/// • Isar
/// • Sync Queue
/// • Firestore
///
/// No UI code belongs here.
/// ===============================================================

class MedleyController extends ChangeNotifier {
  MedleyController({
    required MedleyRepository repository,
  }) : _repository = repository;

  final MedleyRepository _repository;

  final List<Medley> _medleys = [];

  bool _loading = false;

  bool get isLoading => _loading;

  List<Medley> get medleys => List.unmodifiable(_medleys);

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    _medleys
      ..clear()
      ..addAll(await _repository.getMedleys());

    _loading = false;
    notifyListeners();
  }

  Future<void> createMedley({
    required String id,
    required String name,
    required String createdBy,
  }) async {
    await _repository.createMedley(
      id: id,
      name: name,
      createdBy: createdBy,
    );

    await load();
  }

  Future<void> renameMedley({
    required String id,
    required String newName,
  }) async {
    await _repository.renameMedley(
      id,
      newName,
    );

    await load();
  }

  Future<void> requestApproval({
    required String requestId,
    required String userId,
    required String medleyId,
    required String nodeId,
  }) async {
    await _repository.requestApproval(
      requestId: requestId,
      userId: userId,
      medleyId: medleyId,
      nodeId: nodeId,
    );
  }

  Future<Medley?> getMedley(String id) {
    return _repository.getMedley(id);
  }

  Future<MedleyNode> createFolder({
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

  Future<MedleyNode> copyNode(
    MedleyNode node,
  ) {
    return _repository.copyNode(node);
  }

  Future<MedleyNode> moveNode({
    required MedleyNode node,
    String? newParentId,
  }) {
    return _repository.moveNode(
      node: node,
      newParentId: newParentId,
    );
  }

  Future<void> refresh() => load();
}