// TODO depois no futuro seria legal deixar o usuário criar isso
enum ExpenseCategory {
  misc,
  rent,
  food,
  entertainment,
}

extension ExpenseCategoryHelper on ExpenseCategory {

  String get description => toString().split('.').last;
}

extension ExpenseCategoryListExtension on List<ExpenseCategory> {
  ExpenseCategory getByDescription(String description) {
    return firstWhere((e) => e.description == description);
  }
}
