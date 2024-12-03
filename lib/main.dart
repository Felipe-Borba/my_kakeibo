import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/data/repository/realm/expense_realm_repostory.dart';
import 'package:my_kakeibo/data/repository/realm/fixed_expense_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/income_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/realm_config.dart';
import 'package:my_kakeibo/data/repository/realm/user_realm_repository.dart';
import 'package:my_kakeibo/data/service/auth_firebase_service.dart';
import 'package:my_kakeibo/data/repository/firebase/expense_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/firebase/fixed_expense_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/firebase/income_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/firebase/user_firebase_repository.dart';
import 'package:my_kakeibo/data/service/firebase_push_notification_service.dart';
import 'package:my_kakeibo/data/service/local_notification_service_impl.dart';
import 'package:my_kakeibo/domain/service/auth_service.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/service/local_notification_service.dart';
import 'package:my_kakeibo/domain/service/push_notification_service.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/fixed_expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/domain/use_case/notification_use_case.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:my_kakeibo/firebase_options.dart';
import 'package:my_kakeibo/presentation/expense/expense_form/expense_form_view.dart';
import 'package:my_kakeibo/presentation/expense/expense_list/expense_list_view.dart';
import 'package:my_kakeibo/presentation/fixed_expense/fixed_expense_form/fixed_expense_form_view.dart';
import 'package:my_kakeibo/presentation/fixed_expense/fixed_expense_list/fixed_expense_list_view.dart';
import 'package:my_kakeibo/presentation/income/income_form/income_form_view.dart';
import 'package:my_kakeibo/presentation/income/income_list/income_list_view.dart';
import 'package:my_kakeibo/presentation/onboarding/user_info/user_info_view.dart';
import 'package:my_kakeibo/presentation/settings/settings_view.dart';
import 'package:my_kakeibo/presentation/user/create_account/create_account_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';
import 'package:my_kakeibo/presentation/onboarding/welcome/welcome_view.dart';
import 'package:realm/realm.dart' hide Uuid;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:uuid/uuid.dart';

import 'app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Mensagem recebida com app em segundo plano: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  tz.initializeTimeZones();

  Modular.setInitialRoute(LoginView.routeName);
  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class AppModule extends Module {
  @override
  void binds(i) {
    i.add<Realm>(() => Realm(config));
    i.add<Uuid>(Uuid.new);

    // i.addLazySingleton<UserRepository>(UserMemoryDatabase.new);
    i.addLazySingleton<FixedExpenseRepository>(
      FixedExpenseFirebaseRepository.new,
      key: "FixedExpenseFirebaseRepository",
    );
    i.addLazySingleton<FixedExpenseRepository>(
      FixedExpenseRealmRepository.new,
      // key: "FixedExpenseRealmRepository",
    );

    i.addLazySingleton<ExpenseRepository>(
      ExpenseFirebaseRepository.new,
      key: "ExpenseFirebaseRepository",
    );
    i.addLazySingleton<ExpenseRepository>(
      ExpenseRealmRepository.new,
      // key: "ExpenseRealmRepository", //ao tirar a key essa impl vira a default, contrario só acessa pela key
    );
    // i.addSingleton<ExpenseRepository>(() => OfflineFirstExpenseRepository(
    //       localRepository: i.get(key: "ExpenseFirebaseRepository"),
    //       remoteRepository: i.get(key: "ExpenseRealmRepository"),
    //     ));

    i.addLazySingleton<IncomeRepository>(
      IncomeFirebaseRepository.new,
      key: "IncomeFirebaseRepository",
    );
    i.addLazySingleton<IncomeRepository>(
      IncomeRealmRepository.new,
    );

    i.addLazySingleton<UserRepository>(
      UserFirebaseRepository.new,
      key: "UserFirebaseRepository",
    );
    i.addLazySingleton<UserRepository>(
      UserRealmRepository.new,
    );

    i.addLazySingleton<AuthService>(AuthFirebaseService.new);
    i.addSingleton<LocalNotificationService>(LocalNotificationServiceImpl.new);
    i.addSingleton<PushNotificationService>(
      FirebasePushNotificationService.new,
    );

    i.add(FixedExpenseUseCase.new);
    i.add(ExpenseUseCase.new);
    i.add(IncomeUseCase.new);
    i.add(UserUseCase.new);
    i.addSingleton(NotificationUseCase.new);
  }

  @override
  void routes(r) {
    // r.redirect("/", to: WelcomeView.routeName);

    r.child(SettingsView.routeName, child: (context) => const SettingsView());

    r.child(WelcomeView.routeName, child: (context) => const WelcomeView());
    r.child(
      UserInfoView.routeName,
      child: (context) => const UserInfoView(),
    );

    r.child(LoginView.routeName, child: (context) => const LoginView());
    r.child(
      CreateAccountView.routeName,
      child: (context) => const CreateAccountView(),
    );
    r.child(DashboardView.routeName, child: (context) => const DashboardView());

    r.child(
      FixedExpenseListView.routeName,
      child: (context) => const FixedExpenseListView(),
    );
    r.child(
      FixedExpenseFormView.routeName,
      child: (context) => FixedExpenseFormView(fixedExpense: r.args.data),
    );

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
