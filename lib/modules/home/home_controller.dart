import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/helpers/ad_helper.dart';

class HomeController extends GetxController {
  // Estados para demonstração
  final RxInt coins = 100.obs;
  final RxBool isLoading = false.obs;
  final RxString statusMessage = ''.obs;

  // Estado do boost de XP
  final _hasXPBoost = false.obs;
  bool get hasXPBoost => _hasXPBoost.value;

  // Estado de ads removidos temporariamente
  final _adsRemovedUntil = Rx<DateTime?>(null);
  DateTime? get adsRemovedUntil => _adsRemovedUntil.value;

  // Removed unnecessary onInit override

  /// 🤑 Exemplo Rewarded Ad - Ganhar moedas
  void earnCoins() {
    AdHelper.earnCoins(
      coinAmount: 50,
      onCoinsEarned: () {
        coins.value += 50;
        statusMessage.value = '🎁 Você ganhou 50 moedas!';
        // Limpa mensagem após 3 segundos
        Future.delayed(const Duration(seconds: 3), () {
          statusMessage.value = '';
        });
      },
    );
  }

  /// 🧠 Exemplo Interstitial Ad - Entre transições
  void showInterstitialExample() {
    statusMessage.value = 'Carregando anúncio...';
    
    AdHelper.showInterstitialAd(
      onComplete: () {
        statusMessage.value = '✅ Anúncio exibido com sucesso!';
        Future.delayed(const Duration(seconds: 2), () {
          statusMessage.value = '';
        });
      },
      onFailed: () {
        statusMessage.value = '❌ Falha ao exibir anúncio';
        Future.delayed(const Duration(seconds: 2), () {
          statusMessage.value = '';
        });
      },
    );
  }

  /// 🚫 Exemplo Rewarded - Remover ads temporariamente
  void removeAdsTemporarily() {
    AdHelper.removeAdsTemporarily(
      duration: const Duration(hours: 1),
      onAdsRemoved: () {
        statusMessage.value = '🚫 Anúncios removidos por 1 hora!';
        Future.delayed(const Duration(seconds: 3), () {
          statusMessage.value = '';
        });
      },
    );
  }

  /// 🎯 Exemplo Rewarded personalizado - Boost XP
  void boostXP() {
    AdHelper.showRewardedAd(
      onRewarded: () {
        statusMessage.value = '⚡ Boost XP ativado por 30 minutos!';
        Future.delayed(const Duration(seconds: 3), () {
          statusMessage.value = '';
        });
      },
      onFailed: () {
        statusMessage.value = '❌ Anúncio não disponível';
        Future.delayed(const Duration(seconds: 2), () {
          statusMessage.value = '';
        });
      },
      loadingMessage: 'Preparando boost...',
    );
  }

  /// ℹ️ Método para mostrar status dos anúncios
  void checkAdStatus() {
    if (AdHelper.isReady) {
      statusMessage.value = '✅ Sistema de anúncios ativo\n'
          '🤑 Rewarded: ${AdHelper.isRewardedReady ? "Pronto" : "Carregando..."}\n'
          '🧠 Interstitial: ${AdHelper.isInterstitialReady ? "Pronto" : "Carregando..."}';
    } else {
      statusMessage.value = '❌ Sistema de anúncios não inicializado';
    }
    
    Future.delayed(const Duration(seconds: 4), () {
      statusMessage.value = '';
    });
  }

  /// 🔄 MÉTODO PARA TESTES - Reseta o setup inicial
  /// 
  /// Use este método para forçar o app a mostrar a tela inicial novamente.
  /// Útil durante desenvolvimento para testar o fluxo completo.
  /// 
  /// Para usar: adicione um botão temporário na UI que chama este método
  Future<void> resetInitialSetupForTesting() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('has_completed_initial_setup');
      
      Get.snackbar(
        '🔄 Setup Resetado',
        'Na próxima abertura do app, a tela inicial será mostrada',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      
      print('🔄 Setup inicial resetado para testes');
    } catch (e) {
      print('❌ Erro ao resetar setup: $e');
      Get.snackbar(
        '❌ Erro',
        'Não foi possível resetar o setup',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
} 