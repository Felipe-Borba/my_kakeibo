import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/form_validator.dart';

class IncomeValidator extends FormValidator {
  IncomeValidator({required super.context});

  String? validateAmount(double? value) {
    if (value == null) return context.intl.fieldRequired;
    if (value <= 0) return context.intl.fieldGreaterThanZero;
    return null;
  }

  String? validateDate(DateTime? value) {
    if (value == null) return context.intl.fieldRequired;
    return null;
  }

  String? validateDescription(String? value) {
    return null;
  }

  String? validateSource(IncomeSource? value) {
    if (value == null) return context.intl.fieldRequired;
    return null;
  }
}
