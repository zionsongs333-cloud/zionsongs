import 'package:flutter/material.dart'; 
import 'hymn_models.dart'; 
import 'hymn_transpose_logic.dart';

class HymnTransposeButton extends StatelessWidget { 
  final UserHymnPref pref; 
  final VoidCallback onChanged; 
  const HymnTransposeButton({super.key, required this.pref, required this.onChanged}); 
  
  @override 
  Widget build(BuildContext context) { 
    final displayedKey = HymnTransposeLogic.transpose(
      pref.manualKey?? 'C', 
      pref.transposeOffset, 
      pref.preferFlats
    ); 
    
    return Row(
      mainAxisSize: MainAxisSize.min, 
      children: [
        IconButton(
          icon: const Icon(Icons.remove), 
          onPressed: () async { 
            pref.transposeOffset--; 
            await HymnTransposeLogic.savePref(pref); 
            onChanged(); 
          }
        ), 
        DropdownButton<String>(
          value: displayedKey, 
          items: HymnTransposeLogic.getScale(pref.preferFlats)
            .map((k)=>DropdownMenuItem(value: k, child: Text(k)))
            .toList(), 
          onChanged: (v) async { 
            String newManual = HymnTransposeLogic.reverseTranspose(
              v!, 
              pref.transposeOffset, 
              pref.preferFlats
            ); 
            pref.manualKey = newManual; 
            await HymnTransposeLogic.savePref(pref); 
            onChanged(); 
          }
        ), 
        IconButton(
          icon: const Icon(Icons.add), 
          onPressed: () async { 
            pref.transposeOffset++; 
            await HymnTransposeLogic.savePref(pref); 
            onChanged(); 
          }
        )
      ]
    ); 
  } 
}