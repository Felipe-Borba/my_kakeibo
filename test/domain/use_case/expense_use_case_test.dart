import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

import '../repository/expense_repository_mock.dart';
import 'user_use_case_mock.dart';

void main() {
  late ExpenseUseCase expenseUseCase;
  late UserUseCase userUseCase;
  late ExpenseRepository expenseRepository;
  late User user;
  late Expense expense;

  setUp(() {
    userUseCase = UserUseCaseMock();
    expenseRepository = ExpenseRepositoryMock();

    expenseUseCase = ExpenseUseCase(
      userUseCase: userUseCase,
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
      when(() => userUseCase.getUser()).thenAnswer(
        (invocation) async => (user, Empty()),
      );

      await expenseUseCase.insert(expense);

      expect(user.balance, 50);
      verify(() => expenseRepository.insert(expense)).called(1);
      verify(() => userUseCase.getUser()).called(1);
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

  group('delete', () {
    test("Should call delete method", () async {
      when(() => expenseRepository.delete(expense)).thenAnswer(
        (_) async => (null, Empty()),
      );

      await expenseUseCase.delete(expense);

      verify(() => expenseRepository.delete(expense)).called(1);
    });
  });
}
