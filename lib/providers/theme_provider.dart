import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Color _primaryColor = const Color(0xFF6D28D9); // default purple
  late SharedPreferences _prefs;

  static const Color darkZoneColor = Color(0xFF312E81);
  static const Color lightGradientStart = Color(0xFFF5F5F5);
  static const Color lightGradientEnd = Color(0xFFE0E7FF);

  ThemeProvider() {
    _initTheme();
  }

  ThemeMode get themeMode => _themeMode;
  Color get primaryColor => _primaryColor;

  Future<void> _initTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final isDark = _prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    
    // Load saved primary color
    final savedColor = _prefs.getInt('primaryColor');
    _primaryColor = savedColor != null ? Color(savedColor) : _primaryColor;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await _prefs.setBool('isDarkMode', isDark);
    notifyListeners();
  }

  // NEW: Change theme color + save it
  Future<void> changePrimaryColor(Color newColor) async {
    _primaryColor = newColor;
    await _prefs.setInt('primaryColor', newColor.value);
    notifyListeners();
  }

  // Zones: header/footer/sidepanel/index header
  Color getZoneBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
       ? Colors.black
        : darkZoneColor;
  }
  Color getZoneText(BuildContext context) => Colors.white;
  Color getZoneTextUnselected(BuildContext context) => Colors.white60;

  // Hymn list only: gradient light mode, dark fonts
  Color getListStart(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
       ? const Color(0xFF1A1A1A)
        : lightGradientStart;
  }
  Color getListEnd(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
       ? const Color(0xFF2A2A2A)
        : lightGradientEnd;
  }
  Color getListText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
       ? Colors.white
        : Colors.black87;
  }

  // UPDATED: Dynamic card decoration - uses theme color
  BoxDecoration getCardDecoration(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    // Lighter shade for center, darker for edges
    final lightCenter = Color.lerp(baseColor, Colors.white, isDark ? 0.4 : 0.6)!;
    final darkEdge = Color.lerp(baseColor, Colors.black, 0.2)!;

    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: isDark ? Colors.white12 : baseColor.withOpacity(0.3), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark? 0.7 : 0.25),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 1.2, // pushes dark to corners/edges
        colors: [lightCenter, baseColor, darkEdge],
        stops: const [0.0, 0.6, 1.0], // FIXED: was [0.0, 116, 0.2]
      ),
    );
  }

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor, // CHANGED: use dynamic color
        brightness: Brightness.light,
        surface: lightGradientStart,
      ),
      scaffoldBackgroundColor: lightGradientStart,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkZoneColor,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardColor: Colors.white,
      hintColor: Colors.black54,
      iconTheme: const IconThemeData(color: Colors.grey),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor, // CHANGED: use dynamic color
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardColor: const Color(0xFF181818),
      hintColor: Colors.white54,
      iconTheme: const IconThemeData(color: Colors.white70),
    );
  }
}