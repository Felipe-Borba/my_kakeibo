import 'package:flutter/widgets.dart';
import 'package:my_kakeibo/data/repository/expense_category_repository.dart';
import 'package:my_kakeibo/data/repository/expense_repository.dart';
import 'package:my_kakeibo/data/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/data/repository/income_repository.dart';
import 'package:my_kakeibo/data/repository/income_source_repository.dart';
import 'package:my_kakeibo/data/repository/realm/expense_category_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/expense_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/fixed_expense_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/income_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/income_source_realm_repository.dart';
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
import 'package:provider/provider.dart';

class DependencyManager extends StatelessWidget {
  final Widget child;
  const DependencyManager({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) {
          return UserRealmRepository() as UserRepository;
        }),
        Provider(create: (_) {
          return ExpenseCategoryRealmRepository() as ExpenseCategoryRepository;
        }),
        Provider(create: (_) {
          return FixedExpenseRealmRepository() as FixedExpenseRepository;
        }),
        Provider(create: (_) {
          return IncomeRealmRepository() as IncomeRepository;
        }),
        Provider(create: (context) {
          return ExpenseRealmRepository() as ExpenseRepository;
        }),
        Provider(create: (context) {
          return IncomeSourceRealmRepository() as IncomeSourceRepository;
        }),
        Provider(create: (_) {
          return LocalNotificationServiceImpl() as LocalNotificationService;
        }),
        Provider(create: (_) {
          return FirebasePushNotificationService() as PushNotificationService;
        }),
        Provider(create: (_) {
          return AuthFirebaseService() as AuthService;
        }),
        Provider(
          create: (context) {
            return UserUseCase(
              userRepository: context.read(),
              authRepository: context.read(),
            );
          },
        ),
        Provider(
          create: (context) {
            return ExpenseUseCase(
              expenseRepository: context.read<ExpenseRepository>(),
              userUseCase: context.read<UserUseCase>(),
            );
          },
        ),
        Provider(
          create: (context) {
            return IncomeUseCase(
              incomeRepository: context.read(),
              userUseCase: context.read(),
            );
          },
        ),
        Provider(
          create: (context) {
            return FixedExpenseUseCase(
              fixedExpenseRepository: context.read(),
              expenseRepository: context.read(),
              userUseCase: context.read(),
            );
          },
        ),
        Provider(create: (context) {
          return NotificationUseCase(
            context.read<UserRepository>(),
            context.read<PushNotificationService>(),
            context.read<LocalNotificationService>(),
          );
        }),
      ],
      child: child,
    );
  }
}
