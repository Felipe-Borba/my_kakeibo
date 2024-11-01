import 'package:flutter/material.dart';

enum ExpenseCategory {
  misc,
  rent,
  food,
  entertainment,
}

//TODO ver como melhorar essa questão de salvar enum em banco, serializar deserializar e como mostrar em tela com intl etc...
extension ExpenseCategoryIconExtension on ExpenseCategory {
  IconData get icon {
    switch (this) {
      case ExpenseCategory.misc:
        return Icons.help;
      case ExpenseCategory.rent:
        return Icons.house;
      case ExpenseCategory.food:
        return Icons.fastfood;
      case ExpenseCategory.entertainment:
        return Icons.theater_comedy;
      default:
        return Icons.error;
    }
  }
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
