import 'package:mocktail/mocktail.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';

class IncomeRepositoryMock extends Mock implements IncomeRepository {}

final incomeRepositoryMock = IncomeRepositoryMock();
