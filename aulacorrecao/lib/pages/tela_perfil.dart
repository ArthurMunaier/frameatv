import 'package:flutter/material.dart';

import 'tela_cadastro.dart';

class TelaPerfil extends StatelessWidget {
  final String nome;
  final int nivel;

  const TelaPerfil({
    super.key,
    required this.nome,
    required this.nivel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Herói'),
      ),
      body: Column(
        children: [
          const CircleAvatar(
            radius: 70,
            child: Icon(
              Icons.person,
              size: 80,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Nome: nome',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            'Nível: $nivel',
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const TelaCadastro();
                  },
                ),
              );
            },
            child: const Text('Voltar'),
          ),
        ],
      ),
    );
  }
}
