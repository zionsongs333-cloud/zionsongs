import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class NotepadPreferenceService {
  static const _kLeft = 'notepad_left';
  static const _kTop = 'notepad_top';
  static const _kWidth = 'notepad_width';
  static const _kHeight = 'notepad_height';
  static const _kExpanded = 'notepad_expanded';
  static const _kVisible = 'notepad_visible';

  static Future<Rect> loadWindowRect() async {
    final prefs = await SharedPreferences.getInstance();
    final left = prefs.getDouble(_kLeft) ?? 40.0;
    final top = prefs.getDouble(_kTop) ?? 120.0;
    final width = prefs.getDouble(_kWidth) ?? 320.0;
    final height = prefs.getDouble(_kHeight) ?? 360.0;
    return Rect.fromLTWH(left, top, width, height);
  }

  static Future<void> saveWindowRect(Rect rect) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_kLeft, rect.left);
    await prefs.setDouble(_kTop, rect.top);
    await prefs.setDouble(_kWidth, rect.width);
    await prefs.setDouble(_kHeight, rect.height);
  }

  static Future<bool> loadExpanded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kExpanded) ?? true;
  }

  static Future<void> saveExpanded(bool expanded) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kExpanded, expanded);
  }

  static Future<bool> loadVisible() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kVisible) ?? false;
  }

  static Future<void> saveVisible(bool visible) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kVisible, visible);
  }
}
