import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:result_dart/result_dart.dart';

class SettingsViewModel with ChangeNotifier {
  final BuildContext _context;
  final UserRepository _userRepository;
  UserTheme userTheme = UserTheme.system;

  SettingsViewModel(this._context, this._userRepository) {
    _userRepository.getUser().onSuccess((user) {
      userTheme = user.theme;
      notifyListeners();
    });
  }

  updateThemeMode(UserTheme? newThemeMode) async {
    if (newThemeMode == null) return;
    userTheme = newThemeMode;

    final user = await _userRepository.getUser().getOrThrow();
    user.theme = newThemeMode;
    _userRepository.save(user).onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    notifyListeners();
  }

  deleteData() async {
    throw UnimplementedError('TODO interfaces e implementar');
  }
}
