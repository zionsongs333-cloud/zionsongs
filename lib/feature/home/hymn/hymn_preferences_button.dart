import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart'; 
import 'package:isar/isar.dart';
import 'hymn_models.dart'; 
import 'hymn_preferences_logic.dart';

class HymnPreferencesButton extends StatelessWidget { 
  final UserHymnPref pref; 
  final Isar isar; 
  final List<String> styles; 
  final VoidCallback onChanged; 
  const HymnPreferencesButton({
    super.key, 
    required this.pref, 
    required this.isar, 
    required this.styles, 
    required this.onChanged
  }); 
  
  @override 
  Widget build(BuildContext context) { 
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
      children: [
        SizedBox(
          width: 120, 
          child: Autocomplete<String>(
            initialValue: TextEditingValue(text: pref.style), 
            optionsBuilder: (v) => v.text.isEmpty? styles : styles.where(
              (s) => s.toLowerCase().contains(v.text.toLowerCase())
            ), 
            onSelected: (s) async { 
              await HymnPreferencesLogic.saveStyle(pref, s); 
              onChanged(); 
            }, 
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) => 
              TextFormField(
                controller: controller, 
                focusNode: focusNode, 
                decoration: const InputDecoration(labelText: "Style", isDense: true)
              )
          )
        ), 
        SizedBox(
          width: 80, 
          child: Autocomplete<String>(
            initialValue: TextEditingValue(text: pref.tempo.toString()), 
            optionsBuilder: (v) => v.text.isEmpty? HymnPreferencesLogic.getBpms() : 
              HymnPreferencesLogic.getBpms().where((b) => b.contains(v.text)), 
            onSelected: (s) async { 
              await HymnPreferencesLogic.saveTempo(pref, s); 
              onChanged(); 
            }, 
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) => 
              TextFormField(
                controller: controller, 
                focusNode: focusNode, 
                keyboardType: TextInputType.number, 
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                decoration: const InputDecoration(labelText: "BPM", isDense: true)
              )
          )
        ), 
        SizedBox(
          width: 80, 
          child: Autocomplete<String>(
            initialValue: TextEditingValue(text: pref.beat), 
            optionsBuilder: (v) => v.text.isEmpty? HymnPreferencesLogic.getBeats() : 
              HymnPreferencesLogic.getBeats().where((b) => b.contains(v.text)), 
            onSelected: (s) async { 
              await HymnPreferencesLogic.saveBeat(pref, s); 
              onChanged(); 
            }, 
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) => 
              TextFormField(
                controller: controller, 
                focusNode: focusNode, 
                decoration: const InputDecoration(labelText: "Beat", isDense: true)
              )
          )
        ), 
      ]
    ); 
  } 
}