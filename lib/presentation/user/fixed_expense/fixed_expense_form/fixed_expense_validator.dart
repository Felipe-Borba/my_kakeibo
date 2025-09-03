import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/form_validator.dart';

class FixedExpenseValidator extends FormValidator {
  FixedExpenseValidator({required super.context});

  String? validateAmount(double? value) {
    if (value == null) return context.intl.fieldRequired;
    if (value <= 0) return context.intl.fieldGreaterThanZero;
    return null;
  }

  String? validateCategory(ExpenseCategory? value) {
    if (value == null) return context.intl.fieldRequired;
    return null;
  }

  String? validateDueDate(DateTime? value) {
    if (value == null) return context.intl.fieldRequired;
    return null;
  }

  String? validateFrequency(Frequency? value) {
    if (value == null) return context.intl.fieldRequired;
    return null;
  }

  String? validateDescription(String? value) {
    return null;
  }

  String? validateRemember(Remember? value) {
    if (value == null) return context.intl.fieldRequired;
    return null;
  }
}
