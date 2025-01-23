import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextNumberFormat on BuildContext {
  NumberFormat get currency {
    return NumberFormat.currency(
      locale: Localizations.localeOf(this).toString(),
      symbol: AppLocalizations.of(this)!.currencyTag,
      decimalDigits: 2,
    );
  }
}
