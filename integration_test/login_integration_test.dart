import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_kakeibo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Page E2E Test', () {
    testWidgets('Clique 5x no FAB Incrementar', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("create-account")));
      await tester.pumpAndSettle();

      expect(find.text('5'), findsOneWidget);
    });
  });
}
