import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../hymn_models.dart';
import '../hymn_folder_explorer.dart';
import '../hymn_sync_logic.dart';
import '../hymn_auth_service.dart';
import 'notepad_preference_service.dart';

class FloatingNotepadWindow extends StatefulWidget {
  final Isar isar;
  final String hymnId;
  final String hymnTitle;
  final VoidCallback onClosed;
  final VoidCallback onSaved;

  const FloatingNotepadWindow({
    super.key,
    required this.isar,
    required this.hymnId,
    required this.hymnTitle,
    required this.onClosed,
    required this.onSaved,
  });

  @override
  State<FloatingNotepadWindow> createState() => _FloatingNotepadWindowState();
}

class _FloatingNotepadWindowState extends State<FloatingNotepadWindow> {
  Offset _position = const Offset(40, 120);
  Size _size = const Size(320, 360);
  bool _expanded = true;
  UserNote? _note;
  final TextEditingController _controller = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
    _loadNote();
  }

  Future<void> _loadPrefs() async {
    final rect = await NotepadPreferenceService.loadWindowRect();
    final expanded = await NotepadPreferenceService.loadExpanded();
    setState(() {
      _position = Offset(rect.left, rect.top);
      _size = Size(rect.width, rect.height);
      _expanded = expanded;
    });
  }

  Future<void> _loadNote() async {
    final note = await widget.isar.userNotes
        .filter()
        .hymnIdEqualTo(widget.hymnId)
        .userIdEqualTo(AuthService.userId)
        .findFirst();
    if (note != null) {
      _note = note;
      _controller.text = note.content;
    }
    setState(() {});
  }

  Future<void> _updatePrefs() async {
    await NotepadPreferenceService.saveWindowRect(
      Rect.fromLTWH(_position.dx, _position.dy, _size.width, _size.height),
    );
    await NotepadPreferenceService.saveExpanded(_expanded);
  }

  Future<void> _saveNote({required String noteType, String folderId = 'root'}) async {
    setState(() => _saving = true);
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() => _saving = false);
      return;
    }

    final note = _note ?? UserNote()
      ..noteId = _note?.noteId ?? '${widget.hymnId}_${AuthService.userId}'
      ..hymnId = widget.hymnId
      ..folderId = folderId
      ..title = widget.hymnTitle
      ..content = text
      ..userId = AuthService.userId
      ..noteType = noteType
      ..createdOn = _note?.createdOn ?? now()
      ..modifiedOn = now()
      ..syncStatus = SyncStatus.pending;

    await widget.isar.writeTxn(() => widget.isar.userNotes.put(note));
    await SyncLogic.attemptSync(widget.isar, AuthService.userId);
    _note = note;
    setState(() {
      _saving = false;
    });
    widget.onSaved();
  }

  Future<void> _saveAsFavorites() async {
    await _saveNote(noteType: NOTE_TYPE_FAVORITES, folderId: 'root');
  }

  Future<void> _saveAsDestination(String type) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => FolderExplorer(
        isar: widget.isar,
        hymnId: widget.hymnId,
        hymnTitle: widget.hymnTitle,
        type: type,
        onChanged: widget.onSaved,
      ),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _position += details.delta;
          });
          _updatePrefs();
        },
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: _size.width,
            height: _expanded ? _size.height : 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              children: [
                _buildHeader(context),
                if (_expanded) _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          const Icon(Icons.sticky_note_2, color: Colors.black87),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.hymnTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(_expanded ? Icons.expand_more : Icons.expand_less),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
              _updatePrefs();
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              widget.onClosed();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Type your note here...',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(height: 1.4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save to Favorites'),
                  onPressed: _saving ? null : _saveAsFavorites,
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.list),
                  label: const Text('Save to View List'),
                  onPressed: _saving ? null : () => _saveAsDestination(NOTE_TYPE_VIEWLIST),
                ),
                const SizedBox(width: 8),
                if (AuthService.isAdmin)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.queue_music),
                    label: const Text('Save to Medley'),
                    onPressed: _saving ? null : () => _saveAsDestination(NOTE_TYPE_MEDLEY),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
