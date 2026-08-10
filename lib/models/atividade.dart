class Atividade {
  String nome;
  String responsavel;
  String local;
  String? tipo;
  int duracao;
  int participantes;

  bool projetor;
  bool computadores;
  bool som;
  bool internet;
  bool mesas;

  Atividade({
    this.nome = '',
    this.responsavel = '',
    this.local = '',
    this.tipo,
    this.duracao = 60,
    this.participantes = 25,
    this.projetor = false,
    this.computadores = false,
    this.som = false,
    this.internet = false,
    this.mesas = false,
  });

  int get recursosAtivos {
    int total = 0;
    if (projetor) total++;
    if (computadores) total++;
    if (som) total++;
    if (internet) total++;
    if (mesas) total++;
    return total;
  }

  String get classificacao {
    if (participantes <= 20) return 'Atividade pequena';
    if (participantes <= 50) return 'Atividade média';
    return 'Atividade grande';
  }

  String formatarDuracao() {
    if (duracao < 60) return '$duracao minutos';

    final horas = duracao ~/ 60;
    final minutos = duracao % 60;

    if (minutos == 0) {
      return horas == 1 ? '1 hora' : '$horas horas';
    }

    return horas == 1
        ? '1 hora e $minutos minutos'
        : '$horas horas e $minutos minutos';
  }

  List<String> alertas() {
    final lista = <String>[];

    if (computadores && participantes > 30) {
      lista.add(
        'Verifique se o laboratório possui computadores suficientes.',
      );
    }

    if (tipo == 'Competição' && duracao < 60) {
      lista.add(
        'Atenção: uma competição deve ter duração mínima de 60 minutos.',
      );
    }

    if (tipo == 'Apresentação cultural' && !som) {
      lista.add(
        'O sistema de som é recomendado para apresentação cultural.',
      );
    }

    if (classificacao == 'Atividade grande' && !mesas) {
      lista.add(
        'Atividades grandes devem considerar mesas adicionais.',
      );
    }

    return lista;
  }
}
