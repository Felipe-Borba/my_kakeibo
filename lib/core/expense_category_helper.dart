import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';

class ExpenseCategoryHelper {
  static String getTranslation(
    ExpenseCategory expenseCategory, {
    required BuildContext context,
  }) {
    final intl = AppLocalizations.of(context)!;

    switch (expenseCategory) {
      case ExpenseCategory.misc:
        return intl.misc;
      case ExpenseCategory.rent:
        return intl.rent;
      case ExpenseCategory.food:
        return intl.food;
      case ExpenseCategory.entertainment:
        return intl.entertainment;
    }
  }

  static IconData getIcon(ExpenseCategory expenseCategory) {
    switch (expenseCategory) {
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
