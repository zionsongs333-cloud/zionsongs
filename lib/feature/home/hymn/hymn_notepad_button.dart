import 'package:flutter/material.dart'; 
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart'; 
import 'hymn_models.dart'; 
import 'hymn_folder_explorer.dart'; 
import 'hymn_auth_service.dart'; 
import 'hymn_sync_logic.dart';

const _uuid = Uuid();

class NotepadButton extends StatefulWidget { 
  final int badge; 
  final bool hasError; 
  final Isar isar; 
  final String hymnId; 
  final String hymnTitle; 
  final VoidCallback onChanged; 
  
  const NotepadButton({
    super.key, 
    required this.badge, 
    required this.hasError, 
    required this.isar, 
    required this.hymnId, 
    required this.hymnTitle, 
    required this.onChanged
  }); 
  
  @override 
  State<NotepadButton> createState() => _NotepadButtonState(); 
}

class _NotepadButtonState extends State<NotepadButton> { 
  Offset _position = const Offset(20, 200); 
  
  Future<void> _saveNote(String content) async { 
    final note = UserNote()
      ..noteId = _uuid.v4()
      ..hymnId = widget.hymnId
      ..folderId = 'root'
      ..title = "Note"
      ..content = content
      ..userId = AuthService.userId
      ..noteType = NOTE_TYPE_FAVORITES
      ..syncStatus = SyncStatus.pending
      ..createdOn = now()
      ..modifiedOn = now(); 
    
    await widget.isar.writeTxn(() => widget.isar.userNotes.put(note)); 
    SyncLogic.attemptSync(widget.isar, AuthService.userId); 
    widget.onChanged(); 
  } 
  
  void _showTypePicker(BuildContext context) { 
    showDialog(
      context: context, 
      builder: (_) => SimpleDialog(
        title: const Text("Open Notes From"), 
        children: [
          SimpleDialogOption(
            onPressed: ()=>_open(context, NOTE_TYPE_FAVORITES), 
            child: const Text("Favorites")
          ), 
          SimpleDialogOption(
            onPressed: ()=>_open(context, NOTE_TYPE_VIEWLIST), 
            child: const Text("View List")
          ), 
          SimpleDialogOption(
            onPressed: ()=>_open(context, NOTE_TYPE_MEDLEY), 
            child: const Text("Medley")
          )
        ]
      )
    ); 
  } 
  
  void _open(BuildContext context, String type) async { 
    Navigator.pop(context); 
    await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (_)=>FolderExplorer(
          isar: widget.isar, 
          hymnId: widget.hymnId, 
          hymnTitle: widget.hymnTitle, 
          type: type, 
          onChanged: widget.onChanged
        )
      )
    ); 
    widget.onChanged(); 
  } 
  
  void _showSheet(BuildContext context) { 
    List<Widget> options = [
      ListTile(
        title: const Text("Favorites"), 
        onTap: ()=>_open(context, NOTE_TYPE_FAVORITES)
      ), 
      ListTile(
        title: const Text("View List"), 
        onTap: ()=>_open(context, NOTE_TYPE_VIEWLIST)
      )
    ]; 
    
    if(AuthService.isAdmin) { 
      options.add(
        ListTile(
          title: const Text("Medley"), 
          onTap: ()=>_open(context, NOTE_TYPE_MEDLEY)
        )
      ); 
    } 
    
    showModalBottomSheet(
      context: context, 
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          const ListTile(title: Text("Save to...")),
          ...options
        ]
      )
    ); 
  } 
  
  @override 
  Widget build(BuildContext context) { 
    return Positioned(
      left: _position.dx, 
      top: _position.dy, 
      child: GestureDetector(
        onPanUpdate: (d) => setState(() => _position += d.delta), 
        child: Stack(children: [
          FloatingActionButton.small(
            backgroundColor: Colors.amber, 
            onPressed: () async { 
              final controller = TextEditingController(); 
              final result = await showDialog<String>(
                context: context, 
                builder: (_) => AlertDialog(
                  title: const Text("Add Note"), 
                  content: TextField(controller: controller, maxLines: 5), 
                  actions: [
                    TextButton(
                      onPressed: ()=>Navigator.pop(context), 
                      child: const Text("Cancel")
                    ), 
                    TextButton(
                      onPressed: ()=>Navigator.pop(context, controller.text), 
                      child: const Text("Save")
                    )
                  ]
                )
              ); 
              if(result!= null && result.isNotEmpty) _saveNote(result); 
            }, 
            child: const Icon(Icons.note, color: Colors.black)
          ), 
          if(widget.badge > 0) 
            Positioned(
              right: 8, 
              child: GestureDetector(
                onTap: ()=>_showTypePicker(context), 
                child: CircleAvatar(
                  radius: 8, 
                  backgroundColor: Colors.red, 
                  child: Text(
                    '${widget.badge}', 
                    style: const TextStyle(fontSize: 10, color: Colors.white)
                  )
                )
              )
            ), 
          if(widget.hasError) 
            Positioned(
              right: 0, 
              top: 0, 
              child: Icon(Icons.error, size: 12, color: Colors.red)
            )
        ])
      )
    ); 
  } 
}