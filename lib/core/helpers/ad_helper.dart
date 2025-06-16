import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_service.dart';

/// 🎯 Helper para facilitar o uso de anúncios em qualquer lugar do app
class AdHelper {
  static AdService get _adService => AdService.instance;

  /// 🤑 REWARDED AD - Maior lucro
  /// Use para: Recompensas, vidas extras, moedas, desbloquear conteúdo
  /// 
  /// Exemplo:
  /// ```dart
  /// AdHelper.showRewardedAd(
  ///   onRewarded: () => _giveCoins(100),
  ///   onFailed: () => _showMessage('Anúncio não disponível'),
  /// );
  /// ```
  static Future<void> showRewardedAd({
    required VoidCallback onRewarded,
    VoidCallback? onFailed,
    VoidCallback? onClosed,
    String? loadingMessage,
  }) async {
    if (!_adService.isInitialized) {
      print('⚠️ AdMob não inicializado');
      onFailed?.call();
      return;
    }

    if (!_adService.isRewardedReady) {
      if (loadingMessage != null) {
        Get.showSnackbar(GetSnackBar(
          title: 'Carregando anúncio',
          message: loadingMessage,
          duration: const Duration(seconds: 2),
        ));
      }
      onFailed?.call();
      return;
    }

    await _adService.showRewardedAd(
      onRewarded: onRewarded,
      onAdClosed: onClosed,
    );
  }

  /// 🧠 INTERSTITIAL AD - Bom retorno
  /// Use para: Entre fases, após ações, transições de tela
  /// 
  /// Exemplo:
  /// ```dart
  /// AdHelper.showInterstitialAd(
  ///   onComplete: () => _navigateToNextLevel(),
  /// );
  /// ```
  static Future<void> showInterstitialAd({
    VoidCallback? onComplete,
    VoidCallback? onFailed,
  }) async {
    if (!_adService.isInitialized) {
      print('⚠️ AdMob não inicializado');
      onFailed?.call();
      onComplete?.call();
      return;
    }

    bool adShown = await _adService.showInterstitialAd();
    
    if (adShown) {
      // Pequeno delay para garantir que o anúncio seja exibido
      await Future.delayed(const Duration(milliseconds: 500));
      onComplete?.call();
    } else {
      onFailed?.call();
      onComplete?.call(); // Continua mesmo se anúncio falhar
    }
  }

  /// 📊 BANNER AD Widget - Receita constante
  /// Use para: Telas com longo tempo de permanência
  /// 
  /// Exemplo:
  /// ```dart
  /// AdHelper.bannerWidget(
  ///   onError: () => print('Banner falhou'),
  /// )
  /// ```
  static Widget bannerWidget({
    VoidCallback? onError,
    EdgeInsets? margin,
  }) {
    if (!_adService.isInitialized) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      height: 60,
      child: _BannerAdWidget(onError: onError),
    );
  }

  /// 🧩 NATIVE AD Widget - Boa integração
  /// Use para: Feeds, listas, conteúdo visual
  /// 
  /// Exemplo:
  /// ```dart
  /// AdHelper.nativeWidget(
  ///   height: 120,
  ///   onError: () => print('Native falhou'),
  /// )
  /// ```
  static Widget nativeWidget({
    double height = 120,
    VoidCallback? onError,
    EdgeInsets? margin,
  }) {
    if (!_adService.isInitialized) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      height: height,
      child: _NativeAdWidget(onError: onError),
    );
  }

  /// 🎲 Métodos de conveniência

  /// Mostra anúncio recompensado para ganhar moedas
  static Future<void> earnCoins({
    required int coinAmount,
    required VoidCallback onCoinsEarned,
  }) async {
    await showRewardedAd(
      onRewarded: () {
        onCoinsEarned();
        Get.showSnackbar(GetSnackBar(
          title: '🎁 Recompensa!',
          message: 'Você ganhou $coinAmount moedas!',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ));
      },
      onFailed: () {
        Get.showSnackbar(const GetSnackBar(
          title: '😕 Ops!',
          message: 'Anúncio não disponível no momento',
          duration: Duration(seconds: 2),
        ));
      },
      loadingMessage: 'Preparando recompensa...',
    );
  }

  /// Mostra anúncio para remover ads temporariamente
  static Future<void> removeAdsTemporarily({
    required Duration duration,
    required VoidCallback onAdsRemoved,
  }) async {
    await showRewardedAd(
      onRewarded: () {
        onAdsRemoved();
        final hours = duration.inHours;
        Get.showSnackbar(GetSnackBar(
          title: '🚫 Anúncios removidos!',
          message: 'Sem anúncios por ${hours}h',
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.blue,
        ));
      },
      onFailed: () {
        Get.showSnackbar(const GetSnackBar(
          title: '😕 Ops!',
          message: 'Anúncio não disponível no momento',
          duration: Duration(seconds: 2),
        ));
      },
      loadingMessage: 'Carregando benefício...',
    );
  }

  /// Verifica se anúncios estão prontos
  static bool get isReady => _adService.isInitialized;
  static bool get isRewardedReady => _adService.isRewardedReady;
  static bool get isInterstitialReady => _adService.isInterstitialReady;
}

/// Widget interno para Banner
class _BannerAdWidget extends StatefulWidget {
  final VoidCallback? onError;
  
  const _BannerAdWidget({this.onError});

  @override
  State<_BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<_BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid 
          ? 'ca-app-pub-3940256099942544/6300978111' 
          : 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isLoaded = true;
            });
          }
          print('✅ Banner carregado');
        },
        onAdFailedToLoad: (ad, error) {
          print('❌ Erro ao carregar banner: $error');
          widget.onError?.call();
          ad.dispose();
        },
      ),
    );
    _bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded && _bannerAd != null
        ? SizedBox(
            height: _bannerAd!.size.height.toDouble(),
            width: _bannerAd!.size.width.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          )
        : const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}

/// Widget interno para Native Ads  
class _NativeAdWidget extends StatefulWidget {
  final VoidCallback? onError;
  
  const _NativeAdWidget({this.onError});

  @override
  State<_NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<_NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadNativeAd();
  }

  void _loadNativeAd() {
    _nativeAd = NativeAd(
      adUnitId: Platform.isAndroid 
          ? 'ca-app-pub-3940256099942544/2247696110' 
          : 'ca-app-pub-3940256099942544/3986624511',
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isLoaded = true;
            });
          }
          print('✅ Native ad carregado');
        },
        onAdFailedToLoad: (ad, error) {
          print('❌ Erro ao carregar native: $error');
          widget.onError?.call();
          ad.dispose();
        },
      ),
    );
    _nativeAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded && _nativeAd != null
        ? AdWidget(ad: _nativeAd!)
        : const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
} 