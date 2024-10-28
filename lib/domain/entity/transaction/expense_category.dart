enum ExpenseCategory {
  misc,
  rent,
  food,
  entertainment,
}

extension ExpenseCategoryExtension on String {
  ExpenseCategory toExpenseCategory() {
    switch (this) {
      case 'misc':
        return ExpenseCategory.misc;
      case 'rent':
        return ExpenseCategory.rent;
      case 'food':
        return ExpenseCategory.food;
      case 'entertainment':
        return ExpenseCategory.entertainment;
      default:
        throw Exception('Unknown category: $this');
    }
  }
}
