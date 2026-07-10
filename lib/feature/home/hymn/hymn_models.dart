import 'package:isar/isar.dart';

part 'hymn_models.g.dart';

int now() => DateTime.now().millisecondsSinceEpoch;

// ===============================================================
// Constants
// ===============================================================

const String NOTE_TYPE_FAVORITES = 'note_favorites';
const String NOTE_TYPE_VIEWLIST = 'note_viewlist';
const String NOTE_TYPE_MEDLEY = 'note_medley';

const String ROLE_VIEWER = 'viewer';
const String ROLE_ADMIN = 'admin';
const String ROLE_SUPER = 'superadmin';

// ===============================================================
// Local Hymn Cache
// ===============================================================

@collection
class LocalHymn {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String hymnId;

  late String title;

  late String originalLyrics;

  // Additional fields synced from Firestore
  String? key;
  String? dedicated;
  String? year;
  String? beat;
  String? style;
  int? tempo;
  String? searchText;
  String? hindiLyrics;
  String? malayalamLyrics;
  String? englishLyrics;

  int createdOn = now();

  int modifiedOn = now();

  int version = 1;
}

// ===============================================================
// User Hymn Preferences
// ===============================================================

@collection
class UserHymnPref {
  Id id = Isar.autoIncrement;

  @Index(
    unique: true,
    composite: [
      CompositeIndex('userId'),
    ],
  )
  late String hymnId;

  late String userId;

  String? manualKey;

  int transposeOffset = 0;

  int tempo = 80;

  String beat = '4/4';

  String style = 'Ballad';

  bool preferFlats = false;

  int createdOn = now();

  int modifiedOn = now();

  @ignore
  Isar? get isar => Isar.getInstance();
}

// ===============================================================
// Note Folder
// ===============================================================

@collection
class NoteFolder {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String folderId;

  late String name;

  String? parentId;

  late String type;

  late String userId;

  int depth = 0;

  int createdOn = now();

  int modifiedOn = now();

  int? lastSyncedOn;

  @enumerated
  SyncStatus syncStatus = SyncStatus.synced;

  int version = 1;
}

// ===============================================================
// User Notes
// ===============================================================

@collection
class UserNote {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String noteId;

  @Index(
    composite: [
      CompositeIndex('folderId'),
      CompositeIndex('userId'),
    ],
  )
  late String hymnId;

  late String folderId;

  late String title;

  late String content;

  late String userId;

  String noteType = 'private';

  String approvalStatus = 'approved';

  String? approverId;

  int createdOn = now();

  int modifiedOn = now();

  int? lastSyncedOn;

  @enumerated
  SyncStatus syncStatus = SyncStatus.local;

  int version = 1;
}

// ===============================================================
// Edit Proposal
// ===============================================================

@collection
class EditProposal {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String proposalId;

  late String hymnId;

  late String userId;

  late String originalLyrics;

  late String proposedLyrics;

  int createdOn = now();

  @enumerated
  SyncStatus syncStatus = SyncStatus.local;
}

// ===============================================================
// Sync Status
// ===============================================================

enum SyncStatus {
  local,
  pending,
  synced,
  error,
}