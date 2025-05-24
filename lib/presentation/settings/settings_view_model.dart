import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/user/user_language.dart';
import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/core/mappers/user_language_mapper.dart';
import 'package:my_kakeibo/presentation/onboarding/welcome/welcome_view.dart';
import 'package:result_dart/result_dart.dart';

class SettingsViewModel with ChangeNotifier {
  final BuildContext _context;
  final UserRepository _userRepository;

  UserTheme userTheme = UserTheme.system;
  UserLanguage userLanguage = UserLanguageMapper.getSystemLanguage();

  SettingsViewModel(this._context, this._userRepository) {
    _userRepository.getUser().onSuccess((user) {
      userTheme = user.theme;
      userLanguage = user.language ?? UserLanguageMapper.getSystemLanguage();
      notifyListeners();
    });
  }

  updateThemeMode(UserTheme? newThemeMode) async {
    if (newThemeMode == null) return;
    userTheme = newThemeMode;

    final user = await _userRepository.getUser().getOrThrow();
    _userRepository
        .save(user.copyWith(theme: newThemeMode))
        .onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    notifyListeners();
  }

  deleteData() async {
    await _userRepository.deleteUserData().onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    }).onSuccess((_) {
      _context.pushAndRemoveAllScreen(const WelcomeView());
    });
  }

  void updateLanguage(UserLanguage? value) async {
    if (value == null) return;
    userLanguage = value;

    final user = await _userRepository.getUser().getOrThrow();
    _userRepository.save(user.copyWith(language: value)).onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    notifyListeners();
  }
}
