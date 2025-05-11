import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String _keyNotification = "MY_NOTIFICATION";
  static const String _keyTheme = "MY_THEME";

  Future<void> saveNotificationSettingValue(bool value) async {
    try {
      await _preferences.setBool(_keyNotification, value);
    } catch (e) {
      throw Exception("Shared preferences cannot save notification setting value");
    }
  }

  bool getNotificationSettingValue() {
    return _preferences.getBool(_keyNotification) ?? false;
  }

  Future<void> saveThemeSettingValue(ThemeMode value) async {
    try {
      await _preferences.setInt(_keyTheme, value.index);
    } catch (e) {
      throw Exception("Shared preferences cannot save theme setting value");
    }
  }

  ThemeMode getThemeSettingValue() {
    return ThemeMode.values[_preferences.getInt(_keyTheme) ?? 0];
  }
}