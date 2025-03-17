import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/domain/repository/expense_category_repository.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:provider/provider.dart';

import 'expense_category_repository_mock.dart';
import 'expense_repository_mock.dart';

Future<void> createTestableWidget(
  WidgetTester tester, {
  required Widget child,
}) async {
  // Dispositivos de alta densidade (xxhdpi), como o iPhone X, 11, 12.
  tester.view.devicePixelRatio = 3.0;
  // Tamanho do iPhone X, 11, 12.
  await tester.binding.setSurfaceSize(const Size(414, 896));

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale("en"),
      supportedLocales: const [
        Locale('en'),
        Locale('pt'),
      ],
      theme: ThemeData.light(),
      home: MultiProvider(
        providers: [
          Provider<ExpenseRepository>.value(value: expenseRepositoryMock),
          Provider<ExpenseCategoryRepository>.value(
            value: expenseCategoryRepositoryMock,
          ),
        ],
        child: Scaffold(
          body: child,
        ),
      ),
    ),
  );
}
