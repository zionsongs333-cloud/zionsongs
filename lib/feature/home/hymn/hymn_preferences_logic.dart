import 'dart:async'; 
import 'dart:convert'; 
import 'package:flutter/services.dart'; 
import 'hymn_models.dart';

class HymnPreferencesLogic { 
  static Timer? _debounce; 
  static List<String>? _styles; 
  static List<String> _bpms = []; 
  static List<String> _beats = []; 
  
  static Future<void> _debouncedSave(UserHymnPref pref) async { 
    _debounce?.cancel(); 
    _debounce = Timer(const Duration(milliseconds: 400), () async { 
      pref.modifiedOn = now(); 
      await pref.isar!.writeTxn(() => pref.isar!.userHymnPrefs.put(pref)); 
    }); 
  } 
  
  static Future<void> saveStyle(UserHymnPref pref, String v) async { 
    pref.style = v; 
    _debouncedSave(pref); 
  } 
  
  static Future<void> saveTempo(UserHymnPref pref, String v) async { 
    int? bpm = int.tryParse(v); 
    if(bpm!=null && bpm >= 20 && bpm <= 400) { 
      pref.tempo = bpm; 
      _debouncedSave(pref); 
    } 
  } 
  
  static Future<void> saveBeat(UserHymnPref pref, String v) async { 
    pref.beat = v; 
    _debouncedSave(pref); 
  } 
  
  static Future<List<String>> getStyles() async { 
    if(_styles!= null) return _styles!; 
    try { 
      String json = await rootBundle.loadString('assets/psr_styles.json'); 
      _styles = List<String>.from(jsonDecode(json)); 
    } catch(e) { 
      _styles = ['Ballad','Pop','Rock','Worship','PB Ballad']; 
    } 
    return _styles!; 
  } 
  
  static List<String> getBpms() { 
    if(_bpms.isEmpty) _bpms = ['60','70','80','90','100','110','120','130','140','150','88']; 
    return _bpms; 
  } 
  
  static List<String> getBeats() { 
    if(_beats.isEmpty) _beats = ['2/4','3/4','4/4','6/8','12/8','9/8','7/8']; 
    return _beats; 
  } 
}