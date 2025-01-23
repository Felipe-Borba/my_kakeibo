import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';

extension LocalizationsExtension on BuildContext {
  AppLocalizations get intl => AppLocalizations.of(this)!;
}

extension FrequencyTranslation on Frequency {
  String getTranslation(BuildContext context) {
    switch (this) {
      case Frequency.daily:
        return context.intl.daily;
      case Frequency.weekly:
        return context.intl.weekly;
      case Frequency.monthly:
        return context.intl.monthly;
      case Frequency.annually:
        return context.intl.annually;
    }
  }
}

extension IncomeSourceTranslation on IncomeSource {
  String getTranslation(BuildContext context) {
    switch (this) {
      case IncomeSource.salary:
        return context.intl.salary;
    }
  }
}

extension ExpenseCategoryTranslation on ExpenseCategory {
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
}
