import 'package:mocktail/mocktail.dart';
import 'package:my_kakeibo/domain/repository/expense_category_repository.dart';

class ExpenseCategoryRepositoryMock extends Mock implements ExpenseCategoryRepository {}
final expenseCategoryRepositoryMock = ExpenseCategoryRepositoryMock();
