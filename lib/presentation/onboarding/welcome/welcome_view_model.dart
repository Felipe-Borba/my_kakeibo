import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/onboarding/terms_and_privacy/terms_and_privacy_view.dart';
import 'package:my_kakeibo/presentation/onboarding/user_info/user_info_view.dart';

class WelcomeViewModel with ChangeNotifier {
  WelcomeViewModel(this._context);

  // Dependencies
  final BuildContext _context;

  // State

  // Actions
  void onContinue() {
    _context.pushScreen(const UserInfoView());
  }

  void termsAndPrivacyClick() {
    _context.pushScreen(const TermsAndPrivacyView());
  }
}
