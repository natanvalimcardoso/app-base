import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isDark ? 0.15 : 0.2),
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          color: Colors.white.withValues(alpha: isDark ? 0.25 : 0.3),
          width: 2,
        ),
      ),
      child: const Icon(
        Icons.language,
        size: 60,
        color: Colors.white,
      ),
    );
  }
} 