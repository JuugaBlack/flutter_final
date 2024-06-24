import 'package:flutter/material.dart';

class SettingsNotifier extends ChangeNotifier {
  bool _notificationsEnabled = true;
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('zh', 'CN');

  bool get notificationsEnabled => _notificationsEnabled;
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
