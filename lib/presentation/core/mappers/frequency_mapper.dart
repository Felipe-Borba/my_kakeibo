import 'package:flutter/widgets.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';

extension FrequencyMapper on Frequency {
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
