import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/bindings/core_bindings.dart';
import 'core/theme/app_theme.dart';
import 'modules/initial/initial_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App Base',
      debugShowCheckedModeBanner: false,
      initialBinding: CoreBindings(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Começa sempre no light - ThemeController assumirá controle
      locale: const Locale('pt', 'BR'),
      fallbackLocale: const Locale('en', 'US'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
        Locale('es', 'ES'),
        Locale('zh', 'TW'),
        Locale('ja', 'JP'),
        Locale('de', 'DE'),
        Locale('fr', 'FR'),
        Locale('ru', 'RU'),
        Locale('ko', 'KR'),
        Locale('it', 'IT'),
      ],
      home: const InitialPage(),
    );
  }
}
