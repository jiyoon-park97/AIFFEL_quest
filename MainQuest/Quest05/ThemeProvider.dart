import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  double _fontSize = 16.0;

  bool get isDarkMode => _isDarkMode;
  double get fontSize => _fontSize;

  ThemeProvider() {
    _loadSettings();
  }

  // ✅ 저장된 설정 불러오기 (예외 처리 추가)
  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool("darkMode") ?? false;
    _fontSize = prefs.getDouble("fontSize") ?? 16.0;
    notifyListeners(); // ✅ UI 업데이트
  }

  // ✅ 다크 모드 변경
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", _isDarkMode);
    notifyListeners(); // ✅ UI 즉시 반영
  }

  // ✅ 폰트 크기 변경
  Future<void> setFontSize(double size) async {
    _fontSize = size;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("fontSize", size);
    notifyListeners(); // ✅ UI 즉시 반영
  }
}
