import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  late SharedPreferences _prefs;

  // Custom Palette for your UI Zones
  static const Color darkZoneColor = Color(0xFF312E81); // Deep Indigo for headers/footers
  static const Color lightGradientStart = Color(0xFFF5F5F5);
  static const Color lightGradientEnd = Color(0xFFE0E7FF);

  ThemeProvider() {
    _initTheme();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> _initTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final isDark = _prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await _prefs.setBool('isDarkMode', isDark);
    notifyListeners();
  }

  // Use this getter in your UI widgets to get the correct background for headers/footers
  Color getHeaderFooterColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.black 
        : darkZoneColor;
  }

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6D28D9),
        brightness: Brightness.light,
        surface: lightGradientStart,
      ),
      scaffoldBackgroundColor: lightGradientStart,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkZoneColor,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF7C3AED),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
    );
  }
}