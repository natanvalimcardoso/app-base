import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/language_model.dart';

class LanguageController extends GetxController {
  static const String _languageKey = 'selected_language';
  
  final _currentLanguage = Language.supportedLanguages.first.obs;
  final _translations = <String, dynamic>{}.obs;
  final _isLoading = false.obs;

  Language get currentLanguage => _currentLanguage.value;
  Map<String, dynamic> get translations => _translations;
  bool get isLoading => _isLoading.value;
  List<Language> get supportedLanguages => Language.supportedLanguages;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    _isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguageCode = prefs.getString(_languageKey);
      
      if (savedLanguageCode != null) {
        final language = supportedLanguages.firstWhere(
          (lang) => lang.code == savedLanguageCode,
          orElse: () => supportedLanguages.first,
        );
        await changeLanguage(language, saveToPrefs: false);
      } else {
        await _loadTranslations(_currentLanguage.value.code);
      }
    } catch (e) {
      debugPrint('Erro ao carregar idioma salvo: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> changeLanguage(Language language, {bool saveToPrefs = true}) async {
    if (_currentLanguage.value == language && _translations.isNotEmpty) return;

    try {
      await _loadTranslations(language.code);
      _currentLanguage.value = language;
      
      // Determina o locale correto para o GetX
      Locale locale;
      switch (language.code) {
        case 'pt':
          locale = const Locale('pt', 'BR');
          break;
        case 'zh':
          locale = const Locale('zh', 'TW');
          break;
        case 'en':
          locale = const Locale('en', 'US');
          break;
        default:
          locale = Locale(language.code);
      }
      
      Get.updateLocale(locale);
      
      if (saveToPrefs) {
        await _saveLanguageToPrefs(language.code);
      }
    } catch (e) {
      debugPrint('Erro ao alterar idioma: $e');
      Get.snackbar(
        'Erro',
        'Não foi possível alterar o idioma',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _loadTranslations(String languageCode) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/locales/$languageCode.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _translations.assignAll(jsonMap);
    } catch (e) {
      debugPrint('Erro ao carregar traduções para $languageCode: $e');
      // Fallback para inglês
      if (languageCode != 'en') {
        await _loadTranslations('en');
      }
    }
  }

  Future<void> _saveLanguageToPrefs(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    } catch (e) {
      debugPrint('Erro ao salvar idioma: $e');
    }
  }

  String getText(String key) {
    return _translations[key] ?? key;
  }
} 