import 'package:flutter/material.dart';

import '../widgets/card_aventura.dart';
import 'tela_perfil.dart';
import 'tela_sobre.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  int nivel = 1;

  final TextEditingController nomeController = TextEditingController();

  void aumentarNivel() {
    setState(() {
      nivel++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Herói'),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Cadastro de Herói",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Crie seu personagem!",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Início"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Perfil"),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TelaPerfil(
                      nome: nomeController.text,
                      nivel: nivel,
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Sobre"),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TelaSobre(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  Icons.shield,
                  size: 120,
                ),
              ),

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  'Crie seu herói',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

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
                style: const TextStyle(fontSize: 22),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: aumentarNivel,
                child: const Text('Aumentar nível'),
              ),

              const SizedBox(height: 25),

              const CardAventura(
                icone: Icons.map,
                texto: 'Explore diferentes regiões',
              ),

              const CardAventura(
                icone: Icons.sports_martial_arts,
                texto: 'Enfrente inimigos poderosos',
              ),

              const CardAventura(
                icone: Icons.workspace_premium,
                texto: 'Conquiste recompensas',
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TelaPerfil(
                          nome: nomeController.text,
                          nivel: nivel,
                        ),
                      ),
                    );
                  },
                  child: const Text('Visualizar perfil'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}