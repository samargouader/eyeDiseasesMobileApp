import 'package:flutter/material.dart';

class ThemeController {
  ThemeController._();
  static final ThemeController instance = ThemeController._();

  final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.system);

  ThemeMode get themeMode => themeModeNotifier.value;

  void setThemeMode(ThemeMode mode) {
    if (themeModeNotifier.value != mode) {
      themeModeNotifier.value = mode;
    }
  }
}


