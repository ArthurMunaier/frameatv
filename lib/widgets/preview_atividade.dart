import 'package:flutter/material.dart';
import '../models/atividade.dart';

class PreviewAtividade extends StatelessWidget {
  final Atividade atividade;

  const PreviewAtividade({
    super.key,
    required this.atividade,
  });

  IconData _icone() {
    switch (atividade.tipo) {
      case 'Oficina':
        return Icons.build;
      case 'Palestra':
        return Icons.record_voice_over;
      case 'Exposição':
        return Icons.museum;
      case 'Competição':
        return Icons.emoji_events;
      case 'Apresentação cultural':
        return Icons.music_note;
      default:
        return Icons.event;
    }
  }

  Color _cor() {
    switch (atividade.tipo) {
      case 'Oficina':
        return Colors.blue;
      case 'Palestra':
        return Colors.deepPurple;
      case 'Exposição':
        return Colors.orange;
      case 'Competição':
        return Colors.red;
      case 'Apresentação cultural':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cor = _cor();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(
          atividade.tipo == 'Competição' ? 30 : 14,
        ),
        border: Border.all(
          color: cor,
          width: atividade.tipo == null ? 1 : 2,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: atividade.tipo == null ? 2 : 8,
            color: Colors.black.withOpacity(0.10),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: cor,
            child: Icon(_icone(), color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  atividade.nome.isEmpty
                      ? 'Pré-visualização da atividade'
                      : atividade.nome,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text('Tipo: ${atividade.tipo ?? 'Não selecionado'}'),
                Text('Duração: ${atividade.formatarDuracao()}'),
                Text('Participantes: ${atividade.participantes}'),
                Text('Classificação: ${atividade.classificacao}'),
                Text('Recursos ativos: ${atividade.recursosAtivos}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
