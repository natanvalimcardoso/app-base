import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mvc/controllers/initial_controller.dart';
import 'mvc/views/initial_screen.dart';
import 'services/localization_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Serviço de localização
        Provider<LocalizationService>(
          create: (_) => LocalizationService(),
        ),
        // Controlador da tela inicial
        ChangeNotifierProvider<InitialController>(
          create: (context) => InitialController(
            context.read<LocalizationService>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'App Base',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF667eea),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        home: const InitialScreen(),
      ),
    );
  }
}
