import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/presentation/onboarding/terms_and_privacy/terms_and_privacy_view.dart';
import 'package:my_kakeibo/presentation/onboarding/user_info/user_info_view.dart';

class WelcomeController with ChangeNotifier {
  // Dependencies

  // State

  // Actions
  void onContinue() {
    Modular.to.navigate(UserInfoView.routeName);
  }

  void termsAndPrivacyClick() {
    Modular.to.pushNamed(TermsAndPrivacyView.routeName);
  }
}
