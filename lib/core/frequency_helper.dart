import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FrequencyHelper {
  static String getTranslation(
    Frequency frequency, {
    required BuildContext context,
  }) {
    final intl = AppLocalizations.of(context)!;
    switch (frequency) {
      case Frequency.daily:
        return intl.daily;
      case Frequency.weekly:
        return intl.weekly;
      case Frequency.monthly:
        return intl.monthly;
      case Frequency.annually:
        return intl.annually;
    }
  }
}
