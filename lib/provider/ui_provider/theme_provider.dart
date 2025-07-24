import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

class ThemeProvider with ChangeNotifier {
  final _storage = GetStorage();
  final String _key = 'isDarkMode';

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _isDarkMode = _storage.read(_key) ?? false;
  }

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _storage.write(_key, _isDarkMode);
    notifyListeners();
  }
}
