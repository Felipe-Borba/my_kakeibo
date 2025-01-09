import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';

// TODO depois no futuro seria legal deixar o usuário criar isso
// antes de fazer isso criar um componente de seleção para cada enum
enum ExpenseCategory {
  misc,
  rent,
  food,
  entertainment,
}

extension ExpenseCategoryHelper on ExpenseCategory {
  String getTranslation(BuildContext context) {
    switch (this) {
      case ExpenseCategory.misc:
        return context.intl.misc;
      case ExpenseCategory.rent:
        return context.intl.rent;
      case ExpenseCategory.food:
        return context.intl.food;
      case ExpenseCategory.entertainment:
        return context.intl.entertainment;
    }
  }

  IconData getIcon() {
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

  String get description => toString().split('.').last;
}

extension ExpenseCategoryListExtension on List<ExpenseCategory> {
  ExpenseCategory getByDescription(String description) {
    return firstWhere((e) => e.description == description);
  }
}
