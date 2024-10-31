import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_kakeibo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //WARN modelo antigo não usar de referencia
  testWidgets('Should create account and redirect to dashboard page',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key("create-account")));
    await tester.pumpAndSettle();

    final emailInputFinder = find.byKey(const Key('email'));
    await tester.enterText(emailInputFinder, 'toni@email.com');
    final passwordInputFinder = find.byKey(const Key('password'));
    await tester.enterText(passwordInputFinder, '123456789');
    final nameInputFinder = find.byKey(const Key('name'));
    await tester.enterText(nameInputFinder, 'Toni');
    await tester.pumpAndSettle();

    expect(find.text('toni@email.com'), findsOneWidget);
    expect(find.text('123456789'), findsOneWidget);
    expect(find.text('Toni'), findsOneWidget);

    await tester.tap(find.byKey(const Key("create-account")));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    expect(find.text('Bem vindo Toni!'), findsOneWidget);
  });
}
