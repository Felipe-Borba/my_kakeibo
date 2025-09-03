import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/form_validator.dart';

class ExpenseCategoryValidator extends FormValidator {
  ExpenseCategoryValidator({required super.context});

  String? validateColor(ColorCustom? value) {
    if (value == null) return context.intl.fieldRequired;
    return null;
  }

  String? validateIcon(IconCustom? value) {
    if (value == null) return context.intl.fieldRequired;
    return null;
  }

  String? validateName(String? value) {
    if (value == null) return context.intl.fieldRequired;
    return null;
  }
}
