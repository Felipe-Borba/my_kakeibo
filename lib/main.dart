import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/data/repository/auth_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/expense_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/income_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/user_firebase_repository.dart';
import 'package:my_kakeibo/domain/repository/auth_repository.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:my_kakeibo/firebase_options.dart';
import 'package:my_kakeibo/presentation/expense/expense_form/expense_form_controller.dart';
import 'package:my_kakeibo/presentation/expense/expense_form/expense_form_view.dart';
import 'package:my_kakeibo/presentation/expense/expense_list/expense_list_controller.dart';
import 'package:my_kakeibo/presentation/expense/expense_list/expense_list_view.dart';
import 'package:my_kakeibo/presentation/income/income_form/income_form_controller.dart';
import 'package:my_kakeibo/presentation/income/income_form/income_form_view.dart';
import 'package:my_kakeibo/presentation/settings/settings_view.dart';
import 'package:my_kakeibo/presentation/user/create_account/create_account_controller.dart';
import 'package:my_kakeibo/presentation/user/create_account/create_account_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_controller.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';
import 'package:my_kakeibo/presentation/user/login/login_controller.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_controller.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_view.dart';

import 'app.dart';
import 'presentation/settings/settings_controller.dart';
import 'presentation/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(SettingsService.new);
    i.addSingleton(SettingsController.new);

    i.addLazySingleton<AuthRepository>(AuthFirebaseRepository.new);
    i.addLazySingleton<ExpenseRepository>(ExpenseFirebaseRepository.new);
    i.addLazySingleton<IncomeRepository>(IncomeFirebaseRepository.new);
    i.addLazySingleton<UserRepository>(UserFirebaseRepository.new);
    // i.addLazySingleton<UserRepository>(UserMemoryDatabase.new);
    // i.addLazySingleton<UserRepository>(UserSharedPreferences.new);

    i.add(ExpenseUseCase.new);
    i.add(IncomeUseCase.new);
    i.add(UserUseCase.new);

    i.add(WelcomeController.new);
    i.add(LoginController.new);
    i.add(CreateAccountController.new);
    i.add(DashboardController.new);
    i.add(ExpenseFormController.new);
    i.add(ExpenseListController.new);
    i.add(IncomeFormController.new);
  }

  @override
  void routes(r) {
    r.redirect("/", to: LoginView.routeName);

    r.child(SettingsView.routeName, child: (context) => const SettingsView());

    r.child(WelcomeView.routeName, child: (context) => const WelcomeView());

    r.child(LoginView.routeName, child: (context) => const LoginView());
    r.child(
      CreateAccountView.routeName,
      child: (context) => const CreateAccountView(),
    );
    r.child(DashboardView.routeName, child: (context) => const DashboardView());

    r.child(
      ExpenseListView.routeName,
      child: (context) => const ExpenseListView(),
    );
    r.child(
      ExpenseFormView.routeName,
      child: (context) => ExpenseFormView(expense: r.args.data),
    );

    r.child(
      IncomeFormView.routeName,
      child: (context) => IncomeFormView(id: r.args.params['id']),
    );
  }
}
