import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'en';
  late SharedPreferences _prefs;

  LanguageProvider() {
    _initLanguage();
  }

  String get currentLanguage => _currentLanguage;

  Future<void> _initLanguage() async {
    _prefs = await SharedPreferences.getInstance();
    _currentLanguage = _prefs.getString('language') ?? 'en';
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    _currentLanguage = language;
    await _prefs.setString('language', language);
    notifyListeners();
  }
}
