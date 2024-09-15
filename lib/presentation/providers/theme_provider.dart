// theme_provider.dart

import 'package:flutter/material.dart';

/// A provider class for managing the theme mode of the application.
class ThemeProvider with ChangeNotifier {
  // Private field to store the current theme mode. Defaults to light mode.
  ThemeMode _themeMode = ThemeMode.light;

  /// Getter to retrieve the current theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Toggles between light and dark theme modes.
  ///
  /// This method changes the current theme mode from light to dark or from dark to light,
  /// depending on its current state. After updating the theme mode, it calls [notifyListeners]
  /// to update any UI elements that are listening for changes in the theme.
  void toggleTheme() {
    // Switch between light and dark mode.
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    // Notify all the listeners to rebuild their widgets with the new theme mode.
    notifyListeners();
  }
}
