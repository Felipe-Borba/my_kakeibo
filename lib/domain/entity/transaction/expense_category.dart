enum ExpenseCategory {
  misc,
  rent,
  food,
  entertainment,
}

ExpenseCategory mapExpenseCategory(String category) {
  switch (category) {
    case 'misc':
      return ExpenseCategory.misc;
    case 'rent':
      return ExpenseCategory.rent;
    case 'food':
      return ExpenseCategory.food;
    case 'entertainment':
      return ExpenseCategory.entertainment;
    default:
      throw Exception('Unknown category: $category');
  }
}
