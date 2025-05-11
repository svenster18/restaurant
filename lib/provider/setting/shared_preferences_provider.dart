import 'package:flutter/material.dart';
import 'package:restaurant/services/setting/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  SharedPreferencesProvider(this._service);

  String _message = "";
  String get message => _message;

  bool _notificationEnable = false;
  bool get notificationEnable => _notificationEnable;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Future<void> saveNotificationSettingValue(bool isEnable) async {
    try {
      await _service.saveNotificationSettingValue(isEnable);
      _message = isEnable ? "Notification enabled" : "Notification disabled";
    } catch (e) {
      _message = "Failed to save notification setting";
    }
    notifyListeners();
  }

  Future<void> getNotificationSettingValue() async {
    try {
      _notificationEnable = _service.getNotificationSettingValue();
      _message = "Notification setting retrieved";
    } catch (e) {
      _message = "Failed to get notification setting";
    }
    notifyListeners();
  }

  Future<void> saveThemeSettingValue(ThemeMode value) async {
    try {
      await _service.saveThemeSettingValue(value);
      _message = "Theme setting saved";
    } catch (e) {
      _message = "Failed to save theme setting";
    }
    notifyListeners();
  }

  Future<void> getThemeSettingValue() async {
    try {
      _themeMode = _service.getThemeSettingValue();
      _message = "Theme setting retrieved";
    } catch (e) {
      _message = "Failed to get theme setting";
    }
    notifyListeners();
  }
}