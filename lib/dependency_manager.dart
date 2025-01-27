import 'package:flutter/widgets.dart';
import 'package:my_kakeibo/data/repository/expense_category_repository.dart';
import 'package:my_kakeibo/data/repository/expense_repository.dart';
import 'package:my_kakeibo/data/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/data/repository/income_repository.dart';
import 'package:my_kakeibo/data/repository/realm/expense_category_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/expense_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/fixed_expense_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/income_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/user_realm_repository.dart';
import 'package:my_kakeibo/data/repository/user_repository.dart';
import 'package:my_kakeibo/data/service/auth_firebase_service.dart';
import 'package:my_kakeibo/data/service/auth_service.dart';
import 'package:my_kakeibo/data/service/firebase_push_notification_service.dart';
import 'package:my_kakeibo/data/service/local_notification_service.dart';
import 'package:my_kakeibo/data/service/local_notification_service_impl.dart';
import 'package:my_kakeibo/data/service/push_notification_service.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/fixed_expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/domain/use_case/notification_use_case.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

//TODO acho que tem uma forma melhor de fazer isso com um multipleProvider...
class DependencyManager extends ChangeNotifier {
  late final FixedExpenseRepository fixedExpenseRealmRepository;

  late final ExpenseRepository expenseRealmRepository;

  late final IncomeRepository incomeRealmRepository;

  late final UserRepository userRealmRepository;

  late final ExpenseCategoryRepository expenseCategoryRealmRepository;

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
    fixedExpenseRealmRepository = FixedExpenseRealmRepository();

    expenseRealmRepository = ExpenseRealmRepository();

    incomeRealmRepository = IncomeRealmRepository();

    userRealmRepository = UserRealmRepository();

    expenseCategoryRealmRepository = ExpenseCategoryRealmRepository();

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
