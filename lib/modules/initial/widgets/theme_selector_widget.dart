import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../initial_controller.dart';
import '../../../core/theme/app_theme.dart';

class ThemeSelectorWidget extends GetView<InitialController> {
  const ThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark 
            ? AppColors.surfaceDark.withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
              ? AppColors.borderDark
              : Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.languageController.getText('theme'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDark 
                              ? AppColors.textPrimaryDark
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.themeController.isDarkMode
                            ? controller.languageController.getText('dark_theme')
                            : controller.languageController.getText('light_theme'),
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark 
                              ? AppColors.textSecondaryDark
                              : Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                _CustomSwitch(
                  value: controller.themeController.isDarkMode,
                  onChanged: (_) => controller.themeController.toggleTheme(),
                ),
              ],
            )),
      ),
    );
  }
}

class _CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  
  const _CustomSwitch({
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: isDark 
          ? AppColors.blue400 
          : Colors.white,
      activeTrackColor: isDark 
          ? AppColors.blue400.withValues(alpha: 0.3)
          : Colors.white.withValues(alpha: 0.3),
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: isDark 
          ? AppColors.borderDark 
          : Colors.white.withValues(alpha: 0.2),
    );
  }
} 