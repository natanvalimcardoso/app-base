import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/ad_button_widget.dart';
import '../home_controller.dart';

class RewardedExamplesWidget extends GetView<HomeController> {
  const RewardedExamplesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdButtonWidget(
          icon: Icons.monetization_on,
          title: 'Ganhar 50 Moedas',
          subtitle: 'Assista um anúncio e ganhe moedas',
          color: Colors.green,
          onPressed: controller.earnCoins,
        ),
        const SizedBox(height: 8),
        AdButtonWidget(
          icon: Icons.flash_on,
          title: 'Boost XP (30min)',
          subtitle: 'Dobrar experiência temporariamente',
          color: Colors.orange,
          onPressed: controller.boostXP,
        ),
        const SizedBox(height: 8),
        AdButtonWidget(
          icon: Icons.block,
          title: 'Remover Ads (1h)',
          subtitle: 'Ficar sem anúncios por 1 hora',
          color: Colors.purple,
          onPressed: controller.removeAdsTemporarily,
        ),
      ],
    );
  }
} 