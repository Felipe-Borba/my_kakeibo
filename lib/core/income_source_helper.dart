import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';

class IncomeSourceHelper {
  static String getTranslation(
    IncomeSource incomeSource, {
    required BuildContext context,
  }) {
    final intl = AppLocalizations.of(context)!;

    switch (incomeSource) {
      case IncomeSource.salary:
        return intl.salary;
    }
  }
}
