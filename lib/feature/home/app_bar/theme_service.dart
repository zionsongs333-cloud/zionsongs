import 'package:flutter/material.dart';

class ThemeService {
  ThemeService._();

  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.light);

  static void changeTheme() {
    mode.value = mode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  static void invertTheme() {
    // Invert means toggle between light/dark as well
    changeTheme();
  }
}
