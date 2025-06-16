import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/section_title_widget.dart';
import '../../core/widgets/banner_example_widget.dart';
import 'home_controller.dart';
import 'widgets/coins_header_widget.dart';
import 'widgets/status_message_widget.dart';
import 'widgets/rewarded_examples_widget.dart';
import 'widgets/interstitial_example_widget.dart';
import 'widgets/native_info_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Exemplos de Anúncios'),
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          actions: [
            // 🔄 BOTÃO PARA TESTES - Remove em produção
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: controller.resetInitialSetupForTesting,
              tooltip: 'Resetar Setup (Teste)',
            ),
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: controller.checkAdStatus,
              tooltip: 'Status dos Anúncios',
            ),
          ],
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header com moedas
              CoinsHeaderWidget(),
              SizedBox(height: 20),

              // Status Message
              StatusMessageWidget(),
              SizedBox(height: 20),

              // 🤑 REWARDED ADS Section
              SectionTitleWidget(
                title: '🤑 Rewarded Ads',
                subtitle: 'Maior lucro',
              ),
              SizedBox(height: 12),
              RewardedExamplesWidget(),
              SizedBox(height: 24),

              // 🧠 INTERSTITIAL ADS Section  
              SectionTitleWidget(
                title: '🧠 Interstitial Ads',
                subtitle: 'Bom retorno',
              ),
              SizedBox(height: 12),
              InterstitialExampleWidget(),
              SizedBox(height: 24),

              // 📊 BANNER ADS Section
              SectionTitleWidget(
                title: '📊 Banner Ads',
                subtitle: 'Receita constante',
              ),
              SizedBox(height: 12),
              BannerExampleWidget(),
              SizedBox(height: 24),

              // 🧩 NATIVE ADS Section
              SectionTitleWidget(
                title: '🧩 Native Ads',
                subtitle: 'Requer configuração adicional',
              ),
              SizedBox(height: 12),
              NativeInfoWidget(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}