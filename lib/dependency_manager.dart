import 'package:flutter/material.dart';
import 'package:my_kakeibo/data/repository/firebase/expense_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/firebase/fixed_expense_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/firebase/income_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/firebase/user_firebase_repository.dart';
import 'package:my_kakeibo/data/repository/realm/expense_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/fixed_expense_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/income_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/realm_config.dart';
import 'package:my_kakeibo/data/repository/realm/user_realm_repository.dart';
import 'package:my_kakeibo/data/service/auth_firebase_service.dart';
import 'package:my_kakeibo/data/service/firebase_push_notification_service.dart';
import 'package:my_kakeibo/data/service/local_notification_service_impl.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/service/auth_service.dart';
import 'package:my_kakeibo/domain/service/local_notification_service.dart';
import 'package:my_kakeibo/domain/service/push_notification_service.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/fixed_expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/domain/use_case/notification_use_case.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:realm/realm.dart' hide Uuid;
import 'package:uuid/uuid.dart';

class DependencyManager extends ChangeNotifier {
  late final Realm realm;
  late final Uuid uuid;

  late final FixedExpenseRepository fixedExpenseFirebaseRepository;
  late final FixedExpenseRepository fixedExpenseRealmRepository;

  late final ExpenseRepository expenseFirebaseRepository;
  late final ExpenseRepository expenseRealmRepository;

  late final IncomeRepository incomeFirebaseRepository;
  late final IncomeRepository incomeRealmRepository;

  late final UserRepository userFirebaseRepository;
  late final UserRepository userRealmRepository;

  late final AuthService authService;
  late final LocalNotificationService localNotificationService;
  late final PushNotificationService pushNotificationService;

  // UseCases
  late final FixedExpenseUseCase fixedExpenseUseCase;
  late final ExpenseUseCase expenseUseCase;
  late final IncomeUseCase incomeUseCase;
  late final UserUseCase userUseCase;
  late final NotificationUseCase notificationUseCase;

  DependencyManager() {
    realm = Realm(config);
    uuid = const Uuid();

    fixedExpenseFirebaseRepository = FixedExpenseFirebaseRepository();
    fixedExpenseRealmRepository = FixedExpenseRealmRepository(realm, uuid);

    expenseFirebaseRepository = ExpenseFirebaseRepository();
    expenseRealmRepository = ExpenseRealmRepository(realm, uuid);

    incomeFirebaseRepository = IncomeFirebaseRepository();
    incomeRealmRepository = IncomeRealmRepository(realm, uuid);

    userFirebaseRepository = UserFirebaseRepository();
    userRealmRepository = UserRealmRepository(realm, uuid);

    authService = AuthFirebaseService();
    localNotificationService = LocalNotificationServiceImpl();
    pushNotificationService = FirebasePushNotificationService();

    userUseCase = UserUseCase(
      authRepository: authService,
      userRepository: userRealmRepository,
    );
    fixedExpenseUseCase = FixedExpenseUseCase(
      expenseRepository: expenseRealmRepository,
      fixedExpenseRepository: fixedExpenseRealmRepository,
      userUseCase: userUseCase,
    );
    expenseUseCase = ExpenseUseCase(
      expenseRepository: expenseRealmRepository,
      userUseCase: userUseCase,
    );
    incomeUseCase = IncomeUseCase(
      incomeRepository: incomeRealmRepository,
      userUseCase: userUseCase,
    );
    notificationUseCase = NotificationUseCase(
      userRealmRepository,
      pushNotificationService,
      localNotificationService,
    );
  }
}
