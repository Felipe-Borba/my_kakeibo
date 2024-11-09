import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/data/repository/auth_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/expense_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/income_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/user_firebase_repository.dart';
import 'package:my_kakeibo/data/service/firebase_push_notification_service.dart';
import 'package:my_kakeibo/data/service/local_notification_service_impl.dart';
import 'package:my_kakeibo/domain/repository/auth_repository.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/service/local_notification_service.dart';
import 'package:my_kakeibo/domain/service/push_notification_service.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/domain/use_case/notification_use_case.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:my_kakeibo/firebase_options.dart';
import 'package:my_kakeibo/presentation/expense/expense_form/expense_form_view.dart';
import 'package:my_kakeibo/presentation/expense/expense_list/expense_list_view.dart';
import 'package:my_kakeibo/presentation/income/income_form/income_form_view.dart';
import 'package:my_kakeibo/presentation/income/income_list/income_list_view.dart';
import 'package:my_kakeibo/presentation/settings/settings_view.dart';
import 'package:my_kakeibo/presentation/user/create_account/create_account_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_view.dart';

import 'app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Mensagem recebida com app em segundo plano: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Modular.setInitialRoute(LoginView.routeName);
  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class AppModule extends Module {
  @override
  void binds(i) {
    // i.addLazySingleton<UserRepository>(UserMemoryDatabase.new);
    // i.addLazySingleton<UserRepository>(UserSharedPreferences.new);
    i.addLazySingleton<AuthRepository>(AuthFirebaseRepository.new);
    i.addLazySingleton<ExpenseRepository>(ExpenseFirebaseRepository.new);
    i.addLazySingleton<IncomeRepository>(IncomeFirebaseRepository.new);
    i.addLazySingleton<UserRepository>(UserFirebaseRepository.new);
    i.addSingleton<LocalNotificationService>(LocalNotificationServiceImpl.new);
    i.addSingleton<PushNotificationService>(
      FirebasePushNotificationService.new,
    );

    i.add(ExpenseUseCase.new);
    i.add(IncomeUseCase.new);
    i.add(UserUseCase.new);
    i.addSingleton(NotificationUseCase.new);
  }

  @override
  void routes(r) {
    // r.redirect("/", to: LoginView.routeName);

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
      IncomeListView.routeName,
      child: (context) => const IncomeListView(),
    );
    r.child(
      IncomeFormView.routeName,
      child: (context) => IncomeFormView(income: r.args.data),
    );
  }
}
