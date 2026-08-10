import 'package:flutter/material.dart';
import '../widgets/card_missao.dart';
import 'tela_astronauta.dart';

class TelaMissao extends StatefulWidget {
  const TelaMissao({super.key});

  @override
  State<TelaMissao> createState() => _TelaMissaoState();
}

class _TelaMissaoState extends State<TelaMissao> {
  // Controllers usados para pegar o que o usuário digitou.
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController planetaController = TextEditingController();

  // A energia começa com 50.
  int energia = 50;

  // Tipo escolhido no desafio extra.
  String tipoMissao = 'Exploração';

  // Escolhe o ícone de acordo com o tipo da missão.
  IconData get iconeMissao {
    if (tipoMissao == 'Resgate') {
      return Icons.health_and_safety;
    }

    if (tipoMissao == 'Pesquisa científica') {
      return Icons.science;
    }

    return Icons.explore;
  }

  // Escolhe a cor de acordo com o tipo da missão.
  Color get corMissao {
    if (tipoMissao == 'Resgate') {
      return Colors.red;
    }

    if (tipoMissao == 'Pesquisa científica') {
      return Colors.green;
    }

    return Colors.blue;
  }

  void aumentarEnergia() {
    setState(() {
      energia += 10;

      // A energia não pode passar de 100.
      if (energia > 100) {
        energia = 100;
      }
    });
  }

  void diminuirEnergia() {
    setState(() {
      energia -= 10;

      // A energia não pode ficar abaixo de 0.
      if (energia < 0) {
        energia = 0;
      }
    });
  }

  void visualizarMissao() {
    final nome = nomeController.text.trim();
    final planeta = planetaController.text.trim();

    // Verifica se os campos obrigatórios foram preenchidos.
    if (nome.isEmpty || planeta.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha o nome do astronauta e o planeta de destino.',
          ),
        ),
      );
      return;
    }

    // Abre a segunda tela enviando os dados pelo construtor.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaAstronauta(
          nomeAstronauta: nome,
          planetaDestino: planeta,
          energia: energia,
          tipoMissao: tipoMissao,
          iconeMissao: iconeMissao,
          corMissao: corMissao,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Libera os controllers quando a tela deixa de existir.
    nomeController.dispose();
    planetaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Central de Missões'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.rocket_launch,
                size: 70,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 10),

              const Text(
                'Cadastre sua missão espacial',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do astronauta',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: planetaController,
                decoration: const InputDecoration(
                  labelText: 'Planeta de destino',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.public),
                ),
              ),

              const SizedBox(height: 20),

              // Desafio extra: seleção do tipo da missão.
              DropdownButtonFormField<String>(
                value: tipoMissao,
                decoration: const InputDecoration(
                  labelText: 'Tipo de missão',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Exploração',
                    child: Text('Exploração'),
                  ),
                  DropdownMenuItem(
                    value: 'Resgate',
                    child: Text('Resgate'),
                  ),
                  DropdownMenuItem(
                    value: 'Pesquisa científica',
                    child: Text('Pesquisa científica'),
                  ),
                ],
                onChanged: (valor) {
                  if (valor != null) {
                    setState(() {
                      tipoMissao = valor;
                    });
                  }
                },
              ),

              const SizedBox(height: 25),

              const Text(
                'Energia atual',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),

              Text(
                '$energia',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: diminuirEnergia,
                      icon: const Icon(Icons.remove),
                      label: const Text('Diminuir'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: aumentarEnergia,
                      icon: const Icon(Icons.add),
                      label: const Text('Aumentar'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Text(
                'Etapas da missão',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const CardMissao(
                icone: Icons.rocket_launch,
                titulo: 'Preparação da nave',
                descricao: 'Verifique todos os equipamentos da nave.',
              ),

              const CardMissao(
                icone: Icons.flight,
                titulo: 'Viagem espacial',
                descricao: 'Realize a viagem até o planeta escolhido.',
              ),

              const CardMissao(
                icone: Icons.public,
                titulo: 'Exploração do planeta',
                descricao: 'Explore o planeta e cumpra os objetivos da missão.',
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: visualizarMissao,
                icon: const Icon(Icons.visibility),
                label: const Text('Visualizar missão'),
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
