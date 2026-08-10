import 'package:flutter/material.dart';

class TelaAstronauta extends StatelessWidget {
  final String nomeAstronauta;
  final String planetaDestino;
  final int energia;
  final String tipoMissao;
  final IconData iconeMissao;
  final Color corMissao;

  const TelaAstronauta({
    super.key,
    required this.nomeAstronauta,
    required this.planetaDestino,
    required this.energia,
    required this.tipoMissao,
    required this.iconeMissao,
    required this.corMissao,
  });

  // Define a situação da missão conforme a energia.
  String get situacaoMissao {
    if (energia >= 70) {
      return 'Missão pronta para iniciar';
    }

    if (energia >= 40) {
      return 'Missão precisa de preparação';
    }

    return 'Energia insuficiente para a missão';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ficha do Astronauta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CircleAvatar(
                radius: 55,
                child: Icon(
                  Icons.person,
                  size: 65,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                nomeAstronauta,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Planeta de destino',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        planetaDestino,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Energia',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$energia pontos',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Informação do desafio extra.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        iconeMissao,
                        size: 35,
                        color: corMissao,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tipo de missão',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              tipoMissao,
                              style: TextStyle(
                                fontSize: 18,
                                color: corMissao,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Situação da missão',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        situacaoMissao,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              ElevatedButton.icon(
                onPressed: () {
                  // Volta para a tela anterior.
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Voltar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
