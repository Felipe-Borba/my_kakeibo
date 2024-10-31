import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/main.dart' as app;
import '../robots/login_robot.dart';

void main() {
  testWidgets('Teste de login com sucesso', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final loginRobot = LoginRobot(tester: tester);

    await loginRobot.enterEmail('toni@email.com');
    await loginRobot.enterPassword('123456789');
    await loginRobot.tapLoginButton();

    expect(find.text('Bem vindo Toni!'), findsOneWidget);
  });
}
