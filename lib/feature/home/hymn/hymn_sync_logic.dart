import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:isar/isar.dart';

import 'hymn_models.dart';

class SyncLogic {
  static final _firestore = FirebaseFirestore.instance;

  static const int _batchDelayMs = 200;

  static Future<void> attemptSync(
    Isar isar,
    String userId,
  ) async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity.contains(ConnectivityResult.none)) {
      return;
    }

    await _syncUserNotes(isar, userId);

    await Future.delayed(
      const Duration(milliseconds: _batchDelayMs),
    );

    await _syncEditProposals(isar, userId);
  }

  static Future<void> _syncUserNotes(
    Isar isar,
    String userId,
  ) async {
    final pending = await isar.userNotes
        .filter()
        .syncStatusEqualTo(SyncStatus.pending)
        .findAll();

    for (final item in pending) {
      await _syncItem(
        isar,
        item,
        userId,
        'notes',
      );
    }
  }

  static Future<void> _syncEditProposals(
    Isar isar,
    String userId,
  ) async {
    final pending = await isar.editProposals
        .filter()
        .syncStatusEqualTo(SyncStatus.pending)
        .findAll();

    for (final item in pending) {
      await _syncItem(
        isar,
        item,
        userId,
        'edit_proposals',
      );
    }
  }

  static Future<void> _syncItem(
    Isar isar,
    dynamic item,
    String userId,
    String path,
  ) async {
    try {
      final docId = _getDocId(item);

      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection(path)
          .doc(docId);

      final data = _getPartialUpdate(item);

      final snapshot = await docRef.get();

      if (snapshot.exists) {
        await docRef.update(data);
      } else {
        await docRef.set(data);
      }

      item.syncStatus = SyncStatus.synced;
      item.lastSyncedOn = now();

      await isar.writeTxn(() async {
        if (item is UserNote) {
          await isar.userNotes.put(item);
        } else if (item is EditProposal) {
          await isar.editProposals.put(item);
        }
      });
    } catch (e) {
      log('Sync error $path: $e');

      item.syncStatus = SyncStatus.error;

      await isar.writeTxn(() async {
        if (item is UserNote) {
          await isar.userNotes.put(item);
        } else if (item is EditProposal) {
          await isar.editProposals.put(item);
        }
      });
    }

    await Future.delayed(
      const Duration(milliseconds: _batchDelayMs),
    );
  }

  static String _getDocId(dynamic item) {
    if (item is UserNote) {
      return item.noteId;
    }

    if (item is EditProposal) {
      return item.proposalId;
    }

    return '';
  }

  static Map<String, dynamic> _getPartialUpdate(dynamic item) {
    if (item is UserNote) {
      return {
        'content': item.content,
        'modifiedOn': item.modifiedOn,
        'syncStatus': 'synced',
      };
    }

    if (item is EditProposal) {
      return {
        'proposedLyrics': item.proposedLyrics,
        'createdOn': item.createdOn,
        'syncStatus': 'pending_approval',
      };
    }

    return <String, dynamic>{};
  }
}