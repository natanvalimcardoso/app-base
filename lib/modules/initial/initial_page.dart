import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'initial_controller.dart';
import 'widgets/app_logo_widget.dart';
import 'widgets/continue_button_widget.dart';
import 'widgets/gradient_background_widget.dart';
import 'widgets/language_selector_widget.dart';
import 'widgets/theme_selector_widget.dart';
import 'widgets/welcome_text_widget.dart';

class InitialPage extends GetView<InitialController> {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackgroundWidget(
        child: SafeArea(
          child: Obx(() {
            if (controller.languageController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 
                      MediaQuery.of(context).padding.top - 
                      MediaQuery.of(context).padding.bottom - 48,
                ),
                child: const IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo/Ícone da aplicação
                      AppLogoWidget(),

                      SizedBox(height: 32),

                      // Texto de boas-vindas
                      WelcomeTextWidget(),

                      SizedBox(height: 40),

                      // Seletor de idioma
                      LanguageSelectorWidget(),

                      SizedBox(height: 24),

                      // Seletor de tema
                      ThemeSelectorWidget(),

                      Spacer(),

                      // Botão Continuar
                      ContinueButtonWidget(),

                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
} 