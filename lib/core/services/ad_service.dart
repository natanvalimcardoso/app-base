import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';

class AdService extends GetxService {
  static AdService get instance => Get.find<AdService>();
  
  // 📱 IDs dos anúncios (substitua pelos seus IDs reais)
  static const String _androidBannerId = 'ca-app-pub-3940256099942544/6300978111'; // Test ID
  static const String _iosBannerId = 'ca-app-pub-3940256099942544/2934735716'; // Test ID
  
  static const String _androidInterstitialId = 'ca-app-pub-3940256099942544/1033173712'; // Test ID
  static const String _iosInterstitialId = 'ca-app-pub-3940256099942544/4411468910'; // Test ID
  
  static const String _androidRewardedId = 'ca-app-pub-3940256099942544/5224354917'; // Test ID
  static const String _iosRewardedId = 'ca-app-pub-3940256099942544/1712485313'; // Test ID
  
  static const String _androidNativeId = 'ca-app-pub-3940256099942544/2247696110'; // Test ID
  static const String _iosNativeId = 'ca-app-pub-3940256099942544/3986624511'; // Test ID

  // 📊 Estados dos anúncios
  final RxBool _isAdMobInitialized = false.obs;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  NativeAd? _nativeAd;
  
  // 🔄 Controle de carregamento
  final RxBool _isLoadingInterstitial = false.obs;
  final RxBool _isLoadingRewarded = false.obs;
  final RxBool _isLoadingNative = false.obs;

  bool get isInitialized => _isAdMobInitialized.value;
  bool get isInterstitialReady => _interstitialAd != null;
  bool get isRewardedReady => _rewardedAd != null;
  bool get isNativeReady => _nativeAd != null;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initializeAdMob();
  }

  /// 🚀 Inicializa o AdMob
  Future<void> initializeAdMob() async {
    try {
      await MobileAds.instance.initialize();
      _isAdMobInitialized.value = true;
      
      // Pre-carrega anúncios importantes
      _loadInterstitialAd();
      _loadRewardedAd();
      
      print('✅ AdMob inicializado com sucesso');
    } catch (e) {
      print('❌ Erro ao inicializar AdMob: $e');
    }
  }

  /// 📊 BANNER ADS
  /// Melhor para: Apps com longo tempo de uso
  /// Receita: Baixa, mas constante
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: _getBannerId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('✅ Banner carregado'),
        onAdFailedToLoad: (ad, error) {
          print('❌ Erro ao carregar banner: $error');
          ad.dispose();
        },
      ),
    );
  }

  /// 🧠 INTERSTITIAL ADS  
  /// Melhor para: Apps com etapas, fases ou transições
  /// Receita: Média-Alta
  void _loadInterstitialAd() {
    if (_isLoadingInterstitial.value) return;
    
    _isLoadingInterstitial.value = true;
    
    InterstitialAd.load(
      adUnitId: _getInterstitialId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoadingInterstitial.value = false;
          print('✅ Interstitial carregado');
        },
        onAdFailedToLoad: (error) {
          _isLoadingInterstitial.value = false;
          print('❌ Erro ao carregar interstitial: $error');
        },
      ),
    );
  }

  Future<bool> showInterstitialAd() async {
    if (_interstitialAd == null) {
      print('⚠️ Interstitial não está pronto');
      _loadInterstitialAd(); // Carrega para próxima vez
      return false;
    }

    bool adShown = false;
    
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('📱 Interstitial exibido');
        adShown = true;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('❌ Interstitial fechado');
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitialAd(); // Carrega próximo
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('❌ Erro ao exibir interstitial: $error');
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitialAd();
      },
    );

    await _interstitialAd!.show();
    return adShown;
  }

  /// 🤑 REWARDED ADS
  /// Melhor para: Maior lucro - ótima relação engajamento × receita
  /// Receita: Alta
  void _loadRewardedAd() {
    if (_isLoadingRewarded.value) return;
    
    _isLoadingRewarded.value = true;
    
    RewardedAd.load(
      adUnitId: _getRewardedId(),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isLoadingRewarded.value = false;
          print('✅ Rewarded carregado');
        },
        onAdFailedToLoad: (error) {
          _isLoadingRewarded.value = false;
          print('❌ Erro ao carregar rewarded: $error');
        },
      ),
    );
  }

  Future<bool> showRewardedAd({
    required Function() onRewarded,
    Function()? onAdClosed,
  }) async {
    if (_rewardedAd == null) {
      print('⚠️ Rewarded não está pronto');
      _loadRewardedAd();
      return false;
    }

    bool rewardEarned = false;
    
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('📱 Rewarded exibido');
      },
      onAdDismissedFullScreenContent: (ad) {
        print('❌ Rewarded fechado');
        ad.dispose();
        _rewardedAd = null;
        _loadRewardedAd();
        onAdClosed?.call();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('❌ Erro ao exibir rewarded: $error');
        ad.dispose();
        _rewardedAd = null;
        _loadRewardedAd();
      },
    );

    await _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        print('🎁 Recompensa ganha: ${reward.amount} ${reward.type}');
        rewardEarned = true;
        onRewarded();
      },
    );
    
    return rewardEarned;
  }

  /// 🧩 NATIVE ADS
  /// Melhor para: Apps com conteúdo visual, feeds e listas
  /// Receita: Média-Alta, boa integração
  void loadNativeAd({
    required Function(NativeAd) onLoaded,
    Function(LoadAdError)? onError,
  }) {
    if (_isLoadingNative.value) return;
    
    _isLoadingNative.value = true;
    
    _nativeAd = NativeAd(
      adUnitId: _getNativeId(),
      factoryId: 'listTile', // Defina no Android/iOS
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          _isLoadingNative.value = false;
          _nativeAd = ad as NativeAd;
          onLoaded(_nativeAd!);
          print('✅ Native ad carregado');
        },
        onAdFailedToLoad: (ad, error) {
          _isLoadingNative.value = false;
          ad.dispose();
          _nativeAd = null;
          onError?.call(error);
          print('❌ Erro ao carregar native: $error');
        },
      ),
    );
    
    _nativeAd!.load();
  }

  /// 🔧 Métodos auxiliares
  String _getBannerId() {
    return Platform.isAndroid ? _androidBannerId : _iosBannerId;
  }

  String _getInterstitialId() {
    return Platform.isAndroid ? _androidInterstitialId : _iosInterstitialId;
  }

  String _getRewardedId() {
    return Platform.isAndroid ? _androidRewardedId : _iosRewardedId;
  }

  String _getNativeId() {
    return Platform.isAndroid ? _androidNativeId : _iosNativeId;
  }

  /// 🧹 Limpeza de recursos
  @override
  void onClose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _nativeAd?.dispose();
    super.onClose();
  }
} 