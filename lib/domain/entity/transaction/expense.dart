import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

class Expense extends Transaction {
  // TODO depois no futuro seria legal deixar o usuário criar isso
  ExpenseCategory category; //aluguel, conta etc,
  // String payee // quem recebeu
  // PaymentMethod paymentMethod;

  // algumas despesas são dedutíveis como saúde e educação no BR.

  Expense({
    required super.id,
    required super.amount,
    required super.date,
    required super.description,
    required this.category,
  });
}

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