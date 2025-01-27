import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
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

extension ColorTranslation on ColorCustom {
  String getTranslation(BuildContext context) {
    return switch (this) {
      ColorCustom.brown => context.intl.brown,
      ColorCustom.blue => context.intl.blue,
      ColorCustom.purple => context.intl.purple,
      ColorCustom.orange => context.intl.orange,
      ColorCustom.yellow => context.intl.yellow,
    };
  }
}

extension IconCustomTranslation on IconCustom {
  String getTranslation(BuildContext context) {
    return switch (this) {
      IconCustom.dog => context.intl.dog,
      IconCustom.home => context.intl.home,
      IconCustom.book => context.intl.book,
      IconCustom.food => context.intl.food,
      IconCustom.rent => context.intl.rent,
      IconCustom.misc => context.intl.misc,
      IconCustom.doctor => context.intl.doctor,
      IconCustom.entertainment => context.intl.entertainment,
    };
  }
}
