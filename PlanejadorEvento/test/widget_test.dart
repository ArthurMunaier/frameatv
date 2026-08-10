import 'package:flutter_test/flutter_test.dart';
import 'package:planejador_evento/main.dart';

void main() {
  testWidgets('tela inicial do planejador', (tester) async {
    await tester.pumpWidget(const PlanejadorEventoApp());

    expect(find.text('Planejador de Evento'), findsOneWidget);
    expect(find.text('Configuração da atividade'), findsOneWidget);
  });
}
