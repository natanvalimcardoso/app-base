import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../initial_controller.dart';

class WelcomeTextWidget extends GetView<InitialController> {
  const WelcomeTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Título de boas-vindas
        Obx(() => Text(
              controller.languageController.getText('welcome_title'),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )),

        const SizedBox(height: 16),

        // Mensagem de boas-vindas
        Obx(() => Text(
              controller.languageController.getText('welcome_message'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.9),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
} 