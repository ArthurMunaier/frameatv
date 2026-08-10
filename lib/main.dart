import 'package:flutter/material.dart';
import 'screens/configuracao_page.dart';

void main() {
  runApp(const PlanejadorEventoApp());
}

class PlanejadorEventoApp extends StatelessWidget {
  const PlanejadorEventoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planejador de Evento',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ConfiguracaoPage(),
    );
  }
}
