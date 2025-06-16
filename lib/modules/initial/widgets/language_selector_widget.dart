import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../initial_controller.dart';
import '../../../core/theme/app_theme.dart';

class LanguageSelectorWidget extends GetView<InitialController> {
  const LanguageSelectorWidget({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => Text(
                  controller.languageController.getText('language_selector'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark 
                        ? AppColors.textPrimaryDark
                        : Colors.white,
                  ),
                )),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.languageController.supportedLanguages.length,
              itemBuilder: (context, index) {
                final language = controller.languageController.supportedLanguages[index];
                
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _LanguageItem(language: language),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _LanguageItem extends GetView<InitialController> {
  final dynamic language;
  
  const _LanguageItem({required this.language});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Obx(() {
      final isSelected = controller.languageController.currentLanguage == language;
      
      return GestureDetector(
        onTap: () => controller.languageController.changeLanguage(language),
        child: Container(
          width: 80,
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark 
                    ? AppColors.blue400.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.2))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? (isDark ? AppColors.blue400 : Colors.white)
                  : (isDark 
                      ? AppColors.borderDark
                      : Colors.white.withValues(alpha: 0.3)),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  language.flagAsset,
                  width: 32,
                  height: 24,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 32,
                      height: 24,
                      color: isDark 
                          ? AppColors.borderDark
                          : Colors.white.withValues(alpha: 0.3),
                      child: Icon(
                        Icons.flag,
                        size: 16,
                        color: isDark 
                            ? AppColors.textSecondaryDark
                            : Colors.white,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 4),
              Text(
                language.name,
                style: TextStyle(
                  fontSize: 10,
                  color: isDark 
                      ? AppColors.textPrimaryDark
                      : Colors.white.withValues(alpha: 0.9),
                  fontWeight: isSelected 
                      ? FontWeight.w600 
                      : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    });
  }
} 