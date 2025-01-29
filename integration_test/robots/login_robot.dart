import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class LoginRobot {
  final WidgetTester tester;

  LoginRobot({required this.tester});

  enterEmail(String email) async {
    final inputField = find.byKey(const Key('email'));
    expect(inputField, findsOneWidget);
    await tester.enterText(inputField, email);
    await tester.pump();
  }

  enterPassword(String password) async {
    final inputField = find.byKey(const Key('password'));
    expect(inputField, findsOneWidget);
    await tester.enterText(inputField, password);
    await tester.pump();
  }

  tapLoginButton() async {
    final button = find.byKey(const Key('login'));
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  verify() {
    //check if current screen is the login screen, this can be done by add a key on the login screen findByKey end expect findsOneWidget
  }
}
