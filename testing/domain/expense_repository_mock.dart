import 'package:mocktail/mocktail.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';

class ExpenseRepositoryMock extends Mock implements ExpenseRepository {}

final expenseRepositoryMock = ExpenseRepositoryMock();
