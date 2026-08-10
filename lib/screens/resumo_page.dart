import 'package:flutter/material.dart';
import '../models/atividade.dart';
import '../widgets/tabela_resumo.dart';

class ResumoPage extends StatelessWidget {
  final Atividade atividade;
  final int etapas;

  const ResumoPage({
    super.key,
    required this.atividade,
    required this.etapas,
  });

  @override
  Widget build(BuildContext context) {
    final alertas = atividade.alertas();
    final pronta = alertas.isEmpty;
    final situacao = pronta ? 'Pronta para cadastro' : 'Requer atenção';

    final dados = [
      MapEntry('Atividade', atividade.nome),
      MapEntry('Responsável', atividade.responsavel),
      MapEntry('Local', atividade.local),
      MapEntry('Tipo', atividade.tipo ?? '-'),
      MapEntry('Duração', atividade.formatarDuracao()),
      MapEntry('Capacidade', '${atividade.participantes} participantes'),
      MapEntry('Classificação', atividade.classificacao),
      MapEntry('Recursos ativos', '${atividade.recursosAtivos}'),
      MapEntry('Situação', situacao),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo e análise'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: pronta
                  ? Colors.green.withOpacity(0.12)
                  : Colors.orange.withOpacity(0.15),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      pronta ? Icons.check_circle : Icons.warning,
                      size: 42,
                      color: pronta ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Situação geral',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            situacao,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$etapas etapas concluídas',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(value: etapas / 7),
                    const SizedBox(height: 8),
                    Text('$etapas / 7 etapas'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TabelaResumo(dados: dados),
            if (alertas.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Avisos da análise',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...alertas.map(
                        (aviso) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.warning_amber,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(aviso)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
