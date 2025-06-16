import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'isDarkMode';
  
  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  
  // Getter para o tema atual
  ThemeMode get currentThemeMode => _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToPrefs();
  }

  void _loadThemeFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getBool(_themeKey) ?? false;
      _isDarkMode.value = savedTheme;
      
      // Atualiza o tema imediatamente
      Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
      
      print('🎨 Tema carregado: ${_isDarkMode.value ? "Dark" : "Light"}');
    } catch (e) {
      debugPrint('❌ Erro ao carregar tema: $e');
      // Se houver erro, mantém o tema light por padrão
      _isDarkMode.value = false;
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  void _saveThemeToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, _isDarkMode.value);
      print('💾 Tema salvo: ${_isDarkMode.value ? "Dark" : "Light"}');
    } catch (e) {
      debugPrint('❌ Erro ao salvar tema: $e');
    }
  }

  ThemeData get lightTheme => AppTheme.lightTheme;
  ThemeData get darkTheme => AppTheme.darkTheme;
} 