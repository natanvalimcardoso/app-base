import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/controllers/language_controller.dart';
import '../../core/controllers/theme_controller.dart';
import '../home/home_page.dart';

class InitialController extends GetxController {
  static const String _hasCompletedSetupKey = 'has_completed_initial_setup';
  
  final LanguageController languageController;
  final ThemeController themeController;

  InitialController({
    required this.languageController,
    required this.themeController,
  });

  @override
  void onInit() {
    super.onInit();
    
    // 🚀 REDIRECIONAMENTO AUTOMÁTICO PARA HOME
    // ⚠️ PARA TESTES: Comente a linha abaixo para sempre mostrar esta tela
    // _checkIfShouldSkipInitialScreen();
  }

  /// 🚀 Verifica se deve pular a tela inicial e ir direto para home
  /// 
  /// ⚠️ PARA TESTES: Comente a linha '_checkIfShouldSkipInitialScreen()' no onInit() 
  /// para sempre mostrar a tela inicial durante desenvolvimento
  Future<void> _checkIfShouldSkipInitialScreen() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasCompletedSetup = prefs.getBool(_hasCompletedSetupKey) ?? false;
      
      if (hasCompletedSetup) {
        print('✅ Setup já concluído, redirecionando para Home...');
        // Pequeno delay para garantir que os controllers estejam carregados
        Get.off(() => const HomePage());
      } else {
        print('📱 Primeira vez ou setup não concluído, mostrando tela inicial');
      }
    } catch (e) {
      print('❌ Erro ao verificar setup inicial: $e');
      // Em caso de erro, mostra a tela inicial
    }
  }

  /// 💾 Marca como setup concluído e navega para home
  Future<void> navigateToHome() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_hasCompletedSetupKey, true);
      print('✅ Setup inicial marcado como concluído');
      
      Get.off(() => const HomePage());
    } catch (e) {
      print('❌ Erro ao salvar setup: $e');
      // Mesmo com erro, navega para home
      Get.off(() => const HomePage());
    }
  }

  /// 🔄 Método para resetar o setup (útil para testes)
  /// Descomente e use este método se quiser forçar mostrar a tela inicial novamente
  /*
  Future<void> resetInitialSetup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_hasCompletedSetupKey);
      print('🔄 Setup inicial resetado');
    } catch (e) {
      print('❌ Erro ao resetar setup: $e');
    }
  }
  */
} 