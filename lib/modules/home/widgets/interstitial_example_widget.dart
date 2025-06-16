import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/ad_button_widget.dart';
import '../home_controller.dart';

class InterstitialExampleWidget extends GetView<HomeController> {
  const InterstitialExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AdButtonWidget(
      icon: Icons.fullscreen,
      title: 'Mostrar Interstitial',
      subtitle: 'Anúncio de tela cheia entre transições',
      color: Colors.blue,
      onPressed: controller.showInterstitialExample,
    );
  }
} 