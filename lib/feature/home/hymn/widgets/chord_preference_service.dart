import 'package:shared_preferences/shared_preferences.dart';

class ChordPreferenceService {
  static const _kChordEnabled = 'chord_enabled';

  static Future<bool> loadChordEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kChordEnabled) ?? false;
  }

  static Future<void> saveChordEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kChordEnabled, enabled);
  }
}
