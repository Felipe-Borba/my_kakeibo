import 'package:flutter/widgets.dart';
import 'package:my_kakeibo/data/analytics_service.dart';
import 'package:my_kakeibo/data/expense/expense_service_sqlite.dart';
import 'package:my_kakeibo/data/expense_category/expense_category_service_sqlite.dart';
import 'package:my_kakeibo/data/fixed_expense/fixed_expense_service_sqlite.dart';
import 'package:my_kakeibo/data/income/income_service_sqlite.dart';
import 'package:my_kakeibo/data/income_source/income_source_service_sqlite.dart';
import 'package:my_kakeibo/data/notification/local_notification_service.dart';
import 'package:my_kakeibo/data/notification/push_notification_service.dart';
import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/data/user/user_service_sqlite.dart';
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
        //Services
        Provider(create: (context) => AnalyticsService()),
        Provider(create: (context) => SQLiteService()),
        Provider(create: (context) => UserServiceSqlite(context.read())),
        Provider(
          create: (context) => ExpenseCategoryServiceSqlite(context.read()),
        ),
        Provider(
          create: (context) => FixedExpenseServiceSqlite(context.read()),
        ),
        Provider(create: (context) => IncomeServiceSqlite(context.read())),
        Provider(create: (context) => ExpenseServiceSqlite(context.read())),
        Provider(
          create: (context) => IncomeSourceServiceSqlite(context.read()),
        ),
        Provider(create: (context) => LocalNotificationService()),
        Provider(create: (context) => PushNotificationService()),
        //Repositories
        Provider(
          create: (context) => UserRepository(
            context.read(),
            context.read(),
            context.read(),
            context.read(),
            context.read(),
            context.read(),
            context.read(),
          ),
        ),
        Provider(
          create: (context) => ExpenseRepository(
            context.read(),
            context.read(),
          ),
        ),
        Provider(
          create: (context) => ExpenseCategoryRepository(context.read()),
        ),
        Provider(
          create: (context) => FixedExpenseRepository(
            context.read(),
            context.read(),
            context.read(),
            context.read(),
          ),
        ),
        Provider(
          create: (context) => IncomeRepository(
            context.read(),
            context.read(),
          ),
        ),
        Provider(create: (context) => IncomeSourceRepository(context.read())),
      ],
      child: child,
    );
  }
}
