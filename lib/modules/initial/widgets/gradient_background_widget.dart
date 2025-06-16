import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class GradientBackgroundWidget extends StatelessWidget {
  final Widget child;
  
  const GradientBackgroundWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        gradient: isDark 
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundDark,
                  AppColors.surfaceDark,
                  AppColors.backgroundDark,
                ],
                stops: const [0.0, 0.5, 1.0],
              )
            : AppColors.lightGradient,
      ),
      child: child,
    );
  }
} 