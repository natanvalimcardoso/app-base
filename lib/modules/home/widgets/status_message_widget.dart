import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../home_controller.dart';

class StatusMessageWidget extends GetView<HomeController> {
  const StatusMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.statusMessage.value.isEmpty) {
        return const SizedBox.shrink();
      }
      
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.blue400.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.blue400.withValues(alpha: 0.3)),
        ),
        child: Text(
          controller.statusMessage.value,
          style: const TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      );
    });
  }
} 