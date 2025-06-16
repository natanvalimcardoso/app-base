import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  static const String _languageCodeKey = 'selected_language_code';
  static const String _defaultLanguageCode = 'pt';

  Map<String, String> _localizedStrings = {};
  String _currentLanguageCode = _defaultLanguageCode;

  String get currentLanguageCode => _currentLanguageCode;

  /// Inicializa o serviço de localização
  Future<void> initialize() async {
    await _loadSavedLanguage();
    await loadLanguage(_currentLanguageCode);
  }

  /// Carrega o idioma salvo nas preferências
  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguageCode = prefs.getString(_languageCodeKey) ?? _defaultLanguageCode;
  }

  /// Carrega os textos de um idioma específico
  Future<void> loadLanguage(String languageCode) async {
    try {
      final jsonString = await rootBundle.loadString('assets/locales/$languageCode.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      
      _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
      _currentLanguageCode = languageCode;
      
      await _saveLanguageCode(languageCode);
    } catch (e) {
      // Se houver erro ao carregar o idioma, usa o padrão
      if (languageCode != _defaultLanguageCode) {
        await loadLanguage(_defaultLanguageCode);
      }
    }
  }

  /// Salva o código do idioma nas preferências
  Future<void> _saveLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, languageCode);
  }

  /// Retorna o texto localizado para uma chave
  String getText(String key) {
    return _localizedStrings[key] ?? key;
  }

  /// Verifica se uma chave de texto existe
  bool hasKey(String key) {
    return _localizedStrings.containsKey(key);
  }

  /// Retorna todos os textos carregados
  Map<String, String> getAllTexts() {
    return Map<String, String>.from(_localizedStrings);
  }
} 