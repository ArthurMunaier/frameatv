import 'package:flutter/material.dart';
import '../models/atividade.dart';
import '../widgets/preview_atividade.dart';
import 'resumo_page.dart';

class ConfiguracaoPage extends StatefulWidget {
  const ConfiguracaoPage({super.key});

  @override
  State<ConfiguracaoPage> createState() => _ConfiguracaoPageState();
}

class _ConfiguracaoPageState extends State<ConfiguracaoPage> {
  final atividade = Atividade();

  final nomeController = TextEditingController();
  final responsavelController = TextEditingController();
  final localController = TextEditingController();

  bool recursosAnalisados = false;

  final tipos = const [
    'Oficina',
    'Palestra',
    'Exposição',
    'Competição',
    'Apresentação cultural',
  ];

  @override
  void dispose() {
    nomeController.dispose();
    responsavelController.dispose();
    localController.dispose();
    super.dispose();
  }

  int get etapasConcluidas {
    int total = 0;
    if (nomeController.text.trim().isNotEmpty) total++;
    if (responsavelController.text.trim().isNotEmpty) total++;
    if (localController.text.trim().isNotEmpty) total++;
    if (atividade.tipo != null) total++;
    if (atividade.duracao >= 15 && atividade.duracao <= 180) total++;
    if (atividade.participantes >= 5 && atividade.participantes <= 100) {
      total++;
    }
    if (recursosAnalisados) total++;
    return total;
  }

  void selecionarTipo(String tipo) {
    setState(() {
      atividade.tipo = tipo;

      // Regra 1: palestra ativa o projetor automaticamente.
      if (tipo == 'Palestra') {
        atividade.projetor = true;
      }
    });
  }

  List<String> validarCadastro() {
    final erros = <String>[];

    if (nomeController.text.trim().isEmpty) {
      erros.add('Informe o nome da atividade.');
    }
    if (responsavelController.text.trim().isEmpty) {
      erros.add('Informe o responsável.');
    }
    if (localController.text.trim().isEmpty) {
      erros.add('Informe a sala ou local.');
    }
    if (atividade.tipo == null) {
      erros.add('Selecione o tipo da atividade.');
    }
    if (atividade.participantes < 5 || atividade.participantes > 100) {
      erros.add('A capacidade deve ficar entre 5 e 100 participantes.');
    }
    if (!recursosAnalisados) {
      erros.add('Abra a seção de recursos para analisar os recursos.');
    }

    return erros;
  }

  void analisar() {
    final erros = validarCadastro();

    if (erros.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cadastro incompleto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: erros
                .map(
                  (erro) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('• $erro'),
                  ),
                )
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    atividade.nome = nomeController.text.trim();
    atividade.responsavel = responsavelController.text.trim();
    atividade.local = localController.text.trim();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResumoPage(
          atividade: atividade,
          etapas: etapasConcluidas,
        ),
      ),
    );
  }

  void limparFormulario() {
    setState(() {
      nomeController.clear();
      responsavelController.clear();
      localController.clear();

      atividade.nome = '';
      atividade.responsavel = '';
      atividade.local = '';
      atividade.tipo = null;
      atividade.duracao = 60;
      atividade.participantes = 25;
      atividade.projetor = false;
      atividade.computadores = false;
      atividade.som = false;
      atividade.internet = false;
      atividade.mesas = false;

      recursosAnalisados = false;
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulário limpo com sucesso!'),
      ),
    );
  }

  void mostrarSobre() {
    Navigator.pop(context);
    showAboutDialog(
      context: context,
      applicationName: 'Planejador de Evento Escolar',
      applicationVersion: '1.0',
      children: const [
        Text(
          'Aplicativo desenvolvido para organizar as atividades '
          'da feira escolar.',
        ),
      ],
    );
  }

  Widget campo(
    String titulo,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: titulo,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.edit),
        ),
      ),
    );
  }

  IconData iconeTipo(String tipo) {
    switch (tipo) {
      case 'Oficina':
        return Icons.build;
      case 'Palestra':
        return Icons.record_voice_over;
      case 'Exposição':
        return Icons.museum;
      case 'Competição':
        return Icons.emoji_events;
      default:
        return Icons.music_note;
    }
  }

  @override
  Widget build(BuildContext context) {
    final alertas = atividade.alertas();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planejador de Evento'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.event,
                    color: Colors.white,
                    size: 42,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Menu do evento',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Nova atividade'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.event_note),
              title: const Text('Atividade atual'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Limpar formulário'),
              onTap: limparFormulario,
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre o evento'),
              onTap: mostrarSobre,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Configuração da atividade',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              campo('Nome da atividade', nomeController),
              campo('Nome do responsável', responsavelController),
              campo('Sala ou local', localController),

              const SizedBox(height: 8),

              Text(
                'Tipo de atividade',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),

              // Wrap permite quebrar linha sem overflow.
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tipos.map((tipo) {
                  return ChoiceChip(
                    label: Text(tipo),
                    avatar: Icon(
                      iconeTipo(tipo),
                      size: 18,
                    ),
                    selected: atividade.tipo == tipo,
                    onSelected: (_) => selecionarTipo(tipo),
                  );
                }).toList(),
              ),

              const SizedBox(height: 18),

              PreviewAtividade(atividade: atividade),

              const SizedBox(height: 22),

              Text(
                'Duração',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                atividade.formatarDuracao(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: atividade.duracao.toDouble(),
                min: 15,
                max: 180,
                divisions: 33,
                label: atividade.formatarDuracao(),
                onChanged: (valor) {
                  setState(() {
                    atividade.duracao = valor.round();
                  });
                },
              ),

              if (atividade.tipo == 'Competição' &&
                  atividade.duracao < 60)
                const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.warning_amber,
                      color: Colors.orange,
                    ),
                    title: Text(
                      'Atenção: competição deve ter pelo menos 60 minutos.',
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              Text(
                'Capacidade: ${atividade.participantes} participantes',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                atividade.classificacao,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: atividade.participantes.toDouble(),
                min: 5,
                max: 100,
                divisions: 95,
                label: '${atividade.participantes}',
                onChanged: (valor) {
                  setState(() {
                    atividade.participantes = valor.round();
                  });
                },
              ),

              const SizedBox(height: 8),

              ExpansionTile(
                leading: const Icon(Icons.settings),
                title: const Text('Recursos necessários'),
                subtitle: Text(
                  '${atividade.recursosAtivos} recursos ativos',
                ),
                onExpansionChanged: (aberto) {
                  if (aberto) {
                    setState(() {
                      recursosAnalisados = true;
                    });
                  }
                },
                children: [
                  SwitchListTile(
                    title: const Text('Projetor'),
                    value: atividade.projetor,
                    onChanged: (valor) {
                      setState(() {
                        atividade.projetor = valor;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Computadores'),
                    value: atividade.computadores,
                    onChanged: (valor) {
                      setState(() {
                        atividade.computadores = valor;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                      atividade.tipo == 'Apresentação cultural'
                          ? 'Sistema de som (recomendado)'
                          : 'Sistema de som',
                    ),
                    secondary: atividade.tipo == 'Apresentação cultural'
                        ? const Icon(Icons.recommend)
                        : null,
                    value: atividade.som,
                    onChanged: (valor) {
                      setState(() {
                        atividade.som = valor;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Acesso à internet'),
                    value: atividade.internet,
                    onChanged: (valor) {
                      setState(() {
                        atividade.internet = valor;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Mesas adicionais'),
                    value: atividade.mesas,
                    onChanged: (valor) {
                      setState(() {
                        atividade.mesas = valor;
                      });
                    },
                  ),
                ],
              ),

              if (atividade.computadores &&
                  atividade.participantes > 30)
                const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.warning_amber,
                      color: Colors.orange,
                    ),
                    title: Text(
                      'Verifique se o laboratório possui computadores suficientes.',
                    ),
                  ),
                ),

              if (atividade.tipo == 'Apresentação cultural' &&
                  !atividade.som)
                const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.recommend,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Sistema de som recomendado.',
                    ),
                  ),
                ),

              if (atividade.classificacao == 'Atividade grande' &&
                  !atividade.mesas)
                const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.warning_amber,
                      color: Colors.orange,
                    ),
                    title: Text(
                      'Considere adicionar mesas para uma atividade grande.',
                    ),
                  ),
                ),

              if (alertas.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '${alertas.length} aviso(s) serão considerados na análise.',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.check_circle_outline,
                  ),
                  title: const Text('Preparação'),
                  subtitle: Text(
                    '$etapasConcluidas de 7 etapas concluídas',
                  ),
                  trailing: SizedBox(
                    width: 70,
                    child: LinearProgressIndicator(
                      value: etapasConcluidas / 7,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: analisar,
        icon: const Icon(Icons.analytics),
        label: Text(
          'Analisar - $etapasConcluidas de 7',
        ),
      ),
    );
  }
}
