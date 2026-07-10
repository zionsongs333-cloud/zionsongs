import 'package:flutter/material.dart'; 
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart'; 
import 'hymn_models.dart'; 
import 'hymn_sync_logic.dart'; 
import 'hymn_auth_service.dart'; 

const _uuid = Uuid(); 

class FolderExplorer extends StatefulWidget { 
  final Isar isar; 
  final String hymnId; 
  final String hymnTitle; 
  final String type; 
  final VoidCallback onChanged; 
  
  const FolderExplorer({
    super.key, 
    required this.isar, 
    required this.hymnId, 
    required this.hymnTitle, 
    required this.type, 
    required this.onChanged
  }); 
  
  @override 
  State<FolderExplorer> createState() => _FolderExplorerState(); 
} 

class _FolderExplorerState extends State<FolderExplorer> { 
  List<String?> _nav = ['root']; 
  
  Future<List<NoteFolder>> _getFolders() => widget.isar.noteFolders
    .filter()
    .parentIdEqualTo(_nav.last)
    .typeEqualTo(widget.type)
    .userIdEqualTo(AuthService.userId)
    .findAll();
  
  Future<void> _saveNote(String folderId) async { 
    final controller = TextEditingController(); 
    final content = await showDialog<String>(
      context: context, 
      builder: (_) => AlertDialog(
        title: const Text("New Note"), 
        content: TextField(controller: controller), 
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
    
    if(content == null || content.isEmpty) return; 
    
    final note = UserNote()
      ..noteId = _uuid.v4()
      ..hymnId = widget.hymnId
      ..folderId = folderId
      ..title = "Note"
      ..content = content
      ..userId = AuthService.userId
      ..noteType = widget.type
      ..createdOn = now()
      ..modifiedOn = now()
      ..syncStatus = SyncStatus.pending; 
    
    await widget.isar.writeTxn(() => widget.isar.userNotes.put(note)); 
    SyncLogic.attemptSync(widget.isar, AuthService.userId); 
    widget.onChanged(); 
  } 
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")), 
      body: FutureBuilder<List<NoteFolder>>(
        future: _getFolders(), 
        builder: (context, snap) { 
          if(!snap.hasData) return const Center(child: CircularProgressIndicator()); 
          return ListView(children: [
            ...snap.data!.map((f)=>ListTile(
              title: Text(f.name), 
              leading: const Icon(Icons.folder), 
              onTap: ()=>setState(()=>_nav.add(f.folderId))
            )),
            ListTile(
              title: const Text("Save Note Here"), 
              leading: const Icon(Icons.save), 
              onTap: ()=>_saveNote(_nav.last??'root')
            )
          ]); 
        }
      )
    ); 
  } 
}