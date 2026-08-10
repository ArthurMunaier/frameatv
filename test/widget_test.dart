import 'package:flutter_test/flutter_test.dart';
import 'package:central_missoes_espaciais/main.dart';

void main() {
  testWidgets('Tela inicial da Central de Missões', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    expect(find.text('Central de Missões'), findsOneWidget);
    expect(find.text('Cadastre sua missão espacial'), findsOneWidget);
    expect(find.text('50'), findsOneWidget);
  });
}
