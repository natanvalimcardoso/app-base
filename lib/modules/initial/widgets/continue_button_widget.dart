import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../initial_controller.dart';
import '../../../core/theme/app_theme.dart';

class ContinueButtonWidget extends GetView<InitialController> {
  const ContinueButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => controller.navigateToHome(),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark 
              ? AppColors.blue400 
              : Colors.white,
          foregroundColor: isDark 
              ? AppColors.backgroundDark 
              : AppColors.primaryBlue,
          elevation: isDark ? 6 : 3,
          shadowColor: isDark 
              ? AppColors.blue400.withValues(alpha: 0.3)
              : AppColors.primaryBlue.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Obx(() => Text(
              controller.languageController.getText('continue'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            )),
      ),
    );
  }
} 