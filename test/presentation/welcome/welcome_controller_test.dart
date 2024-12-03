import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';
import 'package:my_kakeibo/presentation/onboarding/welcome/welcome_controller.dart';

import '../../mocks/modular_navigate_mock.dart';

void main() {
  late WelcomeController controller;
  late ModularNavigateMock mockNavigator;

  setUp(() {
    mockNavigator = ModularNavigateMock();
    Modular.navigatorDelegate = mockNavigator;
    controller = WelcomeController();
  });

  group("onContinue", () {
    test('Should navigate to LoginView when calling onContinue', () {
      // Action
      controller.onContinue();

      // Verification
      verify(() => mockNavigator.navigate(LoginView.routeName)).called(1);
    });
  });
}
