import 'package:flutter/foundation.dart';
import '../models/language_model.dart';
import '../../services/localization_service.dart';

class InitialController extends ChangeNotifier {
  final LocalizationService _localizationService;
  
  Language _currentLanguage = Language.supportedLanguages.first;
  bool _isLoading = false;

  InitialController(this._localizationService);

  // Getters
  Language get currentLanguage => _currentLanguage;
  bool get isLoading => _isLoading;
  List<Language> get supportedLanguages => Language.supportedLanguages;

  /// Inicializa o controlador
  Future<void> initialize() async {
    _setLoading(true);
    
    try {
      await _localizationService.initialize();
      _updateCurrentLanguageFromService();
    } catch (e) {
      debugPrint('Erro ao inicializar controlador: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Atualiza o idioma atual baseado no serviço de localização
  void _updateCurrentLanguageFromService() {
    final currentCode = _localizationService.currentLanguageCode;
    final language = supportedLanguages.firstWhere(
      (lang) => lang.code == currentCode,
      orElse: () => supportedLanguages.first,
    );
    _currentLanguage = language;
  }

  /// Altera o idioma da aplicação
  Future<void> changeLanguage(Language language) async {
    if (_currentLanguage == language || _isLoading) return;

    _setLoading(true);
    
    try {
      await _localizationService.loadLanguage(language.code);
      _currentLanguage = language;
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao alterar idioma: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Retorna um texto localizado
  String getText(String key) {
    return _localizationService.getText(key);
  }

  /// Simula navegação para próxima tela
  void navigateToNextScreen() {
    // TODO: Implementar navegação para próxima tela
    debugPrint('Navegando para próxima tela...');
  }

  /// Define o estado de carregamento
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
} 