import 'package:flutter/material.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

const String PINNED_HYMN_KEY = 'pinned_hymn_id';

class GlobalPinService extends ValueNotifier<String?> { 
  static final GlobalPinService _instance = GlobalPinService._internal(); 
  factory GlobalPinService() => _instance; 
  GlobalPinService._internal() : super(null); 
  
  Future<void> init() async { 
    final prefs = await SharedPreferences.getInstance(); 
    value = prefs.getString(PINNED_HYMN_KEY); 
  } 
  
  Future<void> togglePin(String? hymnId) async { 
    final prefs = await SharedPreferences.getInstance(); 
    if (value == hymnId) { 
      value = null; 
      await prefs.remove(PINNED_HYMN_KEY); 
    } else { 
      value = hymnId; 
      await prefs.setString(PINNED_HYMN_KEY, hymnId!); 
    } 
  }
}

final globalPin = GlobalPinService();

class PinButton extends StatelessWidget { 
  final String hymnId; 
  const PinButton({super.key, required this.hymnId}); 
  
  @override 
  Widget build(BuildContext context) { 
    return ValueListenableBuilder(
      valueListenable: globalPin, 
      builder: (context, pinned, _) => IconButton(
        icon: Icon(
          pinned == hymnId? Icons.push_pin : Icons.push_pin_outlined, 
          color: pinned == hymnId? Colors.amber : null
        ), 
        tooltip: pinned == hymnId? "Unpin" : "Pin", 
        onPressed: () => globalPin.togglePin(hymnId)
      )
    ); 
  } 
}