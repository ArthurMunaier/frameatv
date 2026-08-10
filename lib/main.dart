import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'pages/tela_missao.dart';

void main() {
  runApp(
    // O DevicePreview permite testar a tela em diferentes dispositivos.
    DevicePreview(
      enabled: true,
      builder: (context) => const MeuApp(),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Central de Missões',
      debugShowCheckedModeBanner: false,

      // Configurações usadas pelo DevicePreview.
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),

      home: const TelaMissao(),
    );
  }
}
