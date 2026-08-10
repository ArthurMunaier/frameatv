import 'package:flutter/material.dart';

import '../widgets/card_aventura.dart';
import 'tela_perfil.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  int nivel = 1;

  final TextEditingController nomeController = TextEditingController();

  void aumentarNivel() {
    nivel++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Herói'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield,
            size: 120,
          ),
          const Text(
            'Crie seu herói',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome do herói',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Nível atual: $nivel',
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          ElevatedButton(
            onPressed: aumentarNivel,
            child: const Text('Aumentar nível'),
          ),
          Container(
            width: 350,
            height: 500,
            child: const Column(
              children: [
                CardAventura(
                  icone: Icons.map,
                  texto: 'Explore diferentes regiões',
                ),
                CardAventura(
                  icone: Icons.sports_martial_arts,
                  texto: 'Enfrente inimigos poderosos',
                ),
                CardAventura(
                  icone: Icons.workspace_premium,
                  texto: 'Conquiste recompensas',
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TelaPerfil(
                      nome: nomeController.text,
                      nivel: nivel,
                    );
                  },
                ),
              );
            },
            child: const Text('Visualizar perfil'),
          ),
        ],
      ),
    );
  }
}
