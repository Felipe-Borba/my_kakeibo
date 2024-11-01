import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/main.dart' as app;
import '../robots/login_robot.dart';
import '../robots/standard_robot.dart';

void main() {
  testWidgets('Teste de login com sucesso', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final loginRobot = LoginRobot(tester: tester);

    await loginRobot.enterEmail('toni@email.com');
    await loginRobot.enterPassword('123456789');
    await loginRobot.tapLoginButton();

    expect(find.byKey(const Key("dashboard")), findsOneWidget);
  });

  testWidgets(
    "Should log out user from dasboard page",
    (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final robot = StandardRobot(tester);

      await robot.openDrawer();
      await robot.tapButton(const Key("settings"));
      await robot.tapButton(const Key("logout"));

      expect(find.byKey(const Key("login-view")), findsOneWidget);
    },
  );
}
