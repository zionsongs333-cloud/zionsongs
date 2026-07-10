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
  Size _size = const Size(280, 220);
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved to Favorites')),
    );
    widget.onSaved();
    widget.onClosed();
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
            // keep on-screen
            final mq = MediaQuery.of(context).size;
            _position = Offset(
              _position.dx.clamp(0.0, mq.width - _size.width),
              _position.dy.clamp(0.0, mq.height - 60),
            );
          });
          _updatePrefs();
        },
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: _size.width,
            height: _expanded ? _size.height : 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    // compact: no large header, only body
                    if (_expanded) Expanded(child: _buildBody(context)),
                    if (!_expanded)
                      SizedBox(
                        height: 56,
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.sticky_note_2),
                            onPressed: () {
                              setState(() => _expanded = true);
                              _updatePrefs();
                            },
                          ),
                        ),
                      ),
                  ],
                ),
                // resize handle
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onPanUpdate: (d) {
                      setState(() {
                        final mq = MediaQuery.of(context).size;
                        final newW = (_size.width + d.delta.dx).clamp(200.0, mq.width - 20);
                        final newH = (_size.height + d.delta.dy).clamp(120.0, mq.height - 20);
                        _size = Size(newW, newH);
                      });
                      _updatePrefs();
                    },
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(Icons.drag_handle, size: 18, color: Colors.black45),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _saving ? null : _onDiscard,
                  child: const Text('Discard'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saving ? null : _onSavePressed,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSavePressed() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final choice = await showDialog<String?>(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Save As'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, NOTE_TYPE_FAVORITES),
            child: const Text('Favorites'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, NOTE_TYPE_VIEWLIST),
            child: const Text('View List'),
          ),
          if (AuthService.isAdmin)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, NOTE_TYPE_MEDLEY),
              child: const Text('Medley'),
            ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (choice == null) return;

    setState(() => _saving = true);
    try {
      if (choice == NOTE_TYPE_FAVORITES) {
        await _saveNote(noteType: NOTE_TYPE_FAVORITES, folderId: 'root');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved to Favorites')));
        widget.onSaved();
        widget.onClosed();
      } else if (choice == NOTE_TYPE_VIEWLIST || choice == NOTE_TYPE_MEDLEY) {
        // Open folder explorer and pass current content so it can save directly
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => FolderExplorer(
            isar: widget.isar,
            hymnId: widget.hymnId,
            hymnTitle: widget.hymnTitle,
            type: choice,
            initialContent: _controller.text,
            onChanged: widget.onSaved,
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved')));
        widget.onSaved();
        widget.onClosed();
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _onDiscard() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      widget.onClosed();
      return;
    }
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Discard Note?'),
        content: const Text('You have unsaved text. Discard?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Discard')),
        ],
      ),
    );
    if (confirm == true) widget.onClosed();
  }
}
