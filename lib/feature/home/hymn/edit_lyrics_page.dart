import 'package:flutter/material.dart'; 
import 'package:isar/isar.dart'; 
import 'package:uuid/uuid.dart'; 
import 'hymn_models.dart'; 
import 'hymn_sync_logic.dart'; 
import 'hymn_auth_service.dart'; 

const _uuid = Uuid(); 

class EditLyricsPage extends StatefulWidget { 
  final Isar isar; 
  final String hymnId; 
  final String originalLyrics; 
  
  const EditLyricsPage({
    super.key, 
    required this.isar, 
    required this.hymnId, 
    required this.originalLyrics
  }); 
  
  @override 
  State<EditLyricsPage> createState() => _EditLyricsPageState(); 
} 

class _EditLyricsPageState extends State<EditLyricsPage> { 
  late final TextEditingController _controller; 
  bool _isSaving = false; 
  
  @override 
  void initState() { 
    super.initState(); 
    _controller = TextEditingController(text: widget.originalLyrics); 
  } 
  
  @override 
  void dispose() { 
    _controller.dispose(); 
    super.dispose(); 
  } 
  
  Future<void> _submit() async { 
    if(_controller.text == widget.originalLyrics) { 
      Navigator.pop(context); 
      return; 
    } 
    
    setState(() => _isSaving = true); 
    
    final proposal = EditProposal()
      ..proposalId = _uuid.v4()
      ..hymnId = widget.hymnId
      ..userId = AuthService.userId
      ..originalLyrics = widget.originalLyrics
      ..proposedLyrics = _controller.text
      ..createdOn = now()
      ..syncStatus = SyncStatus.pending; 
    
    await widget.isar.writeTxn(() => widget.isar.editProposals.put(proposal)); 
    await SyncLogic.attemptSync(widget.isar, AuthService.userId); 
    
    if(mounted) { 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Change submitted for approval."))
      ); 
      Navigator.pop(context); 
    }
  } 
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(title: const Text("Propose Edit")), 
      body: Padding(
        padding: const EdgeInsets.all(16), 
        child: Column(children: [
          Expanded(
            child: TextFormField(
              controller: _controller, 
              maxLines: null, 
              expands: true, 
              decoration: const InputDecoration(border: OutlineInputBorder()), 
              style: const TextStyle(fontFamily: 'monospace')
            )
          ), 
          const SizedBox(height: 16), 
          ElevatedButton(
            onPressed: _isSaving ? null : _submit, 
            child: Text(_isSaving ? "Submitting..." : "Submit for Approval")
          )
        ])
      )
    ); 
  } 
}