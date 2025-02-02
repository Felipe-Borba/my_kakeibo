import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/onboarding/welcome/welcome_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';

class SettingsViewModel with ChangeNotifier {
  SettingsViewModel(this._context, this._userRepository);

  final BuildContext _context;
  final UserRepository _userRepository;

  UserTheme userTheme = UserTheme.system;
  Widget initialRoute = const WelcomeView();

  loadSettings() async {
    var result = await _userRepository.getUser();
    result.onSuccess((user) {
      initialRoute = const DashboardView();

      // userTheme = user.theme;
      /// TODO existe um problema aqui por causa do FutureBuilder sempre recarrega a pagina toda
      /// acho que se eu seguir o role do flutter com o repository exportando um Stream resolva
    });
  }

  updateThemeMode(UserTheme? newThemeMode) async {
    if (newThemeMode == null) return;
    userTheme = newThemeMode;
    notifyListeners();
  }

  deleteData() async {
    var result = await _userRepository.deleteData();
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      Navigator.of(_context).pop(true);
    });
  }
}
