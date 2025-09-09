import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view_model.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../testing/domain/expense_repository_mock.dart';
import '../../../../testing/domain/income_repository_mock.dart';
import '../../../../testing/domain/user_repository_mock.dart';

void main() {
  late DashboardViewModel viewModel;

  final categoryA = ExpenseCategory(
    id: "A",
    name: 'Category A',
    color: ColorCustom.blue,
    icon: IconCustom.book,
  );
  final categoryB = ExpenseCategory(
    id: "B",
    name: 'Category B',
    color: ColorCustom.blue,
    icon: IconCustom.book,
  );
  final categoryC = ExpenseCategory(
    id: "C",
    name: 'Category C',
    color: ColorCustom.blue,
    icon: IconCustom.book,
  );
  final categoryD = ExpenseCategory(
    id: "D",
    name: 'Category D',
    color: ColorCustom.blue,
    icon: IconCustom.book,
  );

  setUp(() {
    when(() => incomeRepositoryMock.getMonthTotal())
        .thenAnswer((_) async => const Success(0.0));
    when(() => expenseRepositoryMock.getMonthTotal())
        .thenAnswer((_) async => const Success(0.0));
    when(() => incomeRepositoryMock.findByMonth(month: any(named: 'month')))
        .thenAnswer((_) async => const Success([]));
    when(() => expenseRepositoryMock.findByMonth(month: any(named: 'month')))
        .thenAnswer((_) async => const Success([]));
    when(() => userRepositoryMock.getUser())
        .thenAnswer((_) async => Success(User(id: '1', name: 'Test User')));

    viewModel = DashboardViewModel(
      userRepositoryMock,
      expenseRepositoryMock,
      incomeRepositoryMock,
    );
  });

  test('last percentage should be less then 1%', () {
    // Arrange
    final expenses = [
      Expense(
        amount: 899.0,
        category: categoryA,
        date: DateTime.now(),
        description: "",
      ),
      Expense(
        amount: 3671.22,
        category: categoryB,
        date: DateTime.now(),
        description: "",
      ),
      Expense(
        amount: 492.90,
        category: categoryC,
        date: DateTime.now(),
        description: "",
      ),
      Expense(
        amount: 48.90,
        category: categoryD,
        date: DateTime.now(),
        description: "",
      ),
    ];

    // Act
    viewModel.makePieCartData(
      expenses,
      expenses.fold(0, (sum, item) => sum + item.amount),
    );

    // Assert
    final pieChartData = viewModel.pieChartData;
    expect(pieChartData.length, 4);
    expect(pieChartData[0].label, 'Category A');
    expect(pieChartData[0].value, 899.0);
    expect(pieChartData[0].title, '18%');
    expect(pieChartData[1].label, 'Category B');
    expect(pieChartData[1].value, 3671.22);
    expect(pieChartData[1].title, '72%');
    expect(pieChartData[2].label, 'Category C');
    expect(pieChartData[2].value, 492.90);
    expect(pieChartData[2].title, '10%');
    expect(pieChartData[3].label, 'Category D');
    expect(pieChartData[3].value, 48.90);
    expect(pieChartData[3].title, '<1%');
  });

  test('calculatePieChartData with exact 100% total', () {
    // Arrange
    final expenses = [
      Expense(
        amount: 505.9,
        category: categoryA,
        date: DateTime.now(),
        description: "",
      ),
      Expense(
        amount: 299.99,
        category: categoryB,
        date: DateTime.now(),
        description: "",
      ),
      Expense(
        amount: 151.25,
        category: categoryC,
        date: DateTime.now(),
        description: "",
      ),
    ];

    // Act
    viewModel.makePieCartData(
      expenses,
      expenses.fold(0, (sum, item) => sum + item.amount),
    );

    // Assert
    final pieChartData = viewModel.pieChartData;
    expect(pieChartData.length, 3);
    expect(pieChartData[0].label, 'Category A');
    expect(pieChartData[0].value, 505.9);
    expect(pieChartData[0].title, '53%');
    expect(pieChartData[1].label, 'Category B');
    expect(pieChartData[1].value, 299.99);
    expect(pieChartData[1].title, '31%');
    expect(pieChartData[2].label, 'Category C');
    expect(pieChartData[2].value, 151.25);
    expect(pieChartData[2].title, '16%');
  });

  test('pie chart data with a single expense should be 100%', () {
    // Arrange
    final expense = Expense(
      amount: 250.0,
      category: categoryA,
      date: DateTime.now(),
      description: "",
    );
    final expenses = [expense];

    // Act
    viewModel.makePieCartData(
      expenses,
      expenses.fold(0, (sum, item) => sum + item.amount),
    );

    // Assert
    final pieChartData = viewModel.pieChartData;
    expect(pieChartData.length, 1);
    expect(pieChartData[0].label, 'Category A');
    expect(pieChartData[0].value, 250.0);
    expect(pieChartData[0].title, '100%');
  });

  test('pie chart data with one very high and one very low expense', () {
    // Arrange
    final highExpense = Expense(
      amount: 99999.42,
      category: categoryA,
      date: DateTime.now(),
      description: "",
    );
    final lowExpense = Expense(
      amount: 0.50,
      category: categoryB,
      date: DateTime.now(),
      description: "",
    );
    final expenses = [highExpense, lowExpense];

    // Act
    viewModel.makePieCartData(
      expenses,
      expenses.fold(0, (sum, item) => sum + item.amount),
    );

    // Assert
    final pieChartData = viewModel.pieChartData;
    expect(pieChartData.length, 2);
    expect(pieChartData[0].label, 'Category A');
    expect(pieChartData[0].value, 99999.42);
    expect(pieChartData[0].title, '100%');
    expect(pieChartData[1].label, 'Category B');
    expect(pieChartData[1].value, 0.50);
    expect(pieChartData[1].title, '<1%');
  });
}
