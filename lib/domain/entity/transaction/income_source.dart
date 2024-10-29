enum IncomeSource {
  salary,
}

IncomeSource mapExpenseSource(String incomeSource) {
  switch (incomeSource) {
    case 'salary':
      return IncomeSource.salary;
    default:
      throw Exception('Unknown category: $incomeSource');
  }
}
