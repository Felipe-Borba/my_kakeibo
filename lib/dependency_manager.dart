import 'package:flutter/widgets.dart';
import 'package:my_kakeibo/data/expense/expense_realm_service.dart';
import 'package:my_kakeibo/data/expense_category/expense_category_realm_service.dart';
import 'package:my_kakeibo/data/fixed_expense/fixed_expense_realm_service.dart';
import 'package:my_kakeibo/data/income/income_realm_service.dart';
import 'package:my_kakeibo/data/income_source/income_source_realm_service.dart';
import 'package:my_kakeibo/data/notification/local_notification_service.dart';
import 'package:my_kakeibo/data/notification/push_notification_service.dart';
import 'package:my_kakeibo/data/realm/realm_service.dart';
import 'package:my_kakeibo/data/user/user_realm_service.dart';
import 'package:my_kakeibo/domain/repository/expense_category_repository.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/domain/repository/income_source_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:provider/provider.dart';

class DependencyManager extends StatelessWidget {
  final Widget child;
  const DependencyManager({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => RealmService()),
        //Services
        Provider(create: (context) {
          return UserRealmService(context.read<RealmService>());
        }),
        Provider(create: (context) {
          return ExpenseCategoryRealmService(context.read<RealmService>());
        }),
        Provider(create: (context) {
          return FixedExpenseRealmService(context.read<RealmService>());
        }),
        Provider(create: (context) {
          return IncomeRealmService(context.read<RealmService>());
        }),
        Provider(create: (context) {
          return ExpenseRealmService(context.read<RealmService>());
        }),
        Provider(create: (context) {
          return IncomeSourceRealmService(context.read<RealmService>());
        }),
        Provider(create: (context) {
          return LocalNotificationService();
        }),
        Provider(create: (context) {
          return PushNotificationService();
        }),
        //Repositories
        Provider(create: (context) {
          return UserRepository(context.read<UserRealmService>());
        }),
        Provider(create: (context) {
          return ExpenseRepository(
            context.read<ExpenseRealmService>(),
            context.read<UserRepository>(),
          );
        }),
        Provider(create: (context) {
          return ExpenseCategoryRepository(
            context.read<ExpenseCategoryRealmService>(),
          );
        }),
        Provider(create: (context) {
          return FixedExpenseRepository(
            context.read<FixedExpenseRealmService>(),
            context.read<ExpenseRealmService>(),
          );
        }),
        Provider(create: (context) {
          return IncomeRepository(
            context.read<IncomeRealmService>(),
            context.read<UserRepository>(),
          );
        }),
        Provider(create: (context) {
          return IncomeSourceRepository(
            context.read<IncomeSourceRealmService>(),
          );
        }),
      ],
      child: child,
    );
  }
}
