import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';

import '../repository/expense_repository_mock.dart';
import '../repository/user_repository_mock.dart';

void main() {
  late ExpenseUseCase expenseUseCase;
  late UserRepository userRepository;
  late ExpenseRepository expenseRepository;
  late User user;
  late Expense expense;

  setUp(() {
    userRepository = UserRepositoryMock();
    expenseRepository = ExpenseRepositoryMock();

    expenseUseCase = ExpenseUseCase(
      userRepository: userRepository,
      expenseRepository: expenseRepository,
    );

    expense = Expense(
      id: null,
      amount: 100,
      date: DateTime.now(),
      description: "some description",
      category: ExpenseCategory.food,
    );

    user = User(
      name: "Bob",
      email: "e@e.com",
      password: "123",
      balance: 150,
    );
  });

  group("insert", () {
    test(
        "Should validate expense, decrease user balance and persist expense if expense is valid",
        () async {
      when(() => expenseRepository.insert(expense)).thenAnswer(
        (_) async => (expense, Empty()),
      );
      when(() => userRepository.getUser()).thenAnswer(
        (invocation) async => (user, Empty()),
      );

      await expenseUseCase.insert(expense);

      expect(user.balance, 50);
      verify(() => expenseRepository.insert(expense)).called(1);
      verify(() => userRepository.getUser()).called(1);
    });
  });

  group("findAll", () {
    test("Should call find all expenses from expenseRepository", () async {
      when(() => expenseRepository.findAll()).thenAnswer(
        (_) async => ([expense], Empty()),
      );

      await expenseUseCase.findAll();

      verify(() => expenseRepository.findAll()).called(1);
    });
  });
}
