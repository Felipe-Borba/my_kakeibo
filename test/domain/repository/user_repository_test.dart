import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../../../testing/analytics_service_mock.dart';
import '../../../testing/expense_category_service_mock.dart';
import '../../../testing/expense_service_mock.dart';
import '../../../testing/fixed_expense_service_mock.dart';
import '../../../testing/income_service_mock.dart';
import '../../../testing/income_source_service_mock.dart';
import '../../../testing/user_service_mock.dart';

void main() {
  late UserRepository userRepository;
  late ExpenseCategoryServiceMock expenseCategoryMock;
  late UserServiceMock userServiceMock;
  late IncomeSourceServiceMock incomeSourceServiceMock;

  final expenseCategories = [
    ExpenseCategory(
      name: "misc",
      icon: IconCustom.misc,
      color: ColorCustom.blue,
    ),
    ExpenseCategory(
      name: "book",
      icon: IconCustom.book,
      color: ColorCustom.brown,
    ),
  ];

  final incomeSources = [
    IncomeSource(
      name: "salary",
      icon: IconCustom.salary,
      color: ColorCustom.green,
    ),
    IncomeSource(
      name: "bonus",
      icon: IconCustom.dog,
      color: ColorCustom.yellow,
    ),
  ];

  setUp(() {
    incomeSourceServiceMock = IncomeSourceServiceMock();
    expenseCategoryMock = ExpenseCategoryServiceMock();
    userServiceMock = UserServiceMock();
    userRepository = UserRepository(
      userServiceMock,
      AnalyticsServiceMock(),
      expenseCategoryMock,
      ExpenseServiceMock(),
      FixedExpenseServiceMock(),
      incomeSourceServiceMock,
      IncomeServiceMock(),
    );

    registerFallbackValue(User(name: "Isis"));
    when(() => userServiceMock.insert(any())).thenAnswer(
      (_) async => Success(User(name: "Isis")),
    );

    registerFallbackValue(expenseCategories.first);
    when(() => expenseCategoryMock.insert(any())).thenAnswer(
      (_) async => Success(expenseCategories.first),
    );

    registerFallbackValue(incomeSources.first);
    when(() => incomeSourceServiceMock.insert(any())).thenAnswer(
      (_) async => Success(incomeSources.first),
    );
  });

  group("createNewUser", () {
    test("Should create user", () async {
      await userRepository.createNewUser(
        name: "Isis",
        expenseCategories: expenseCategories,
        incomeSources: incomeSources,
      );

      verify(() => userServiceMock.insert(any())).called(1);
    });

    test("Should create all default expenseCategories", () async {
      await userRepository.createNewUser(
        name: "Isis",
        expenseCategories: expenseCategories,
        incomeSources: incomeSources,
      );

      verify(() => expenseCategoryMock.insert(any())).called(2);
    });

    test("Should persist all incomeSources", () async {
      await userRepository.createNewUser(
        name: "Isis",
        expenseCategories: expenseCategories,
        incomeSources: incomeSources,
      );

      verify(() => incomeSourceServiceMock.insert(any())).called(2);
    });
  });
}
