import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';

enum Frequency {
  daily,
  weekly,
  monthly,
  annually,
}

extension FrequencyExtension on Frequency {
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

  String get description => toString().split('.').last;
}

extension FrequencyExtensionListExtension on List<Frequency> {
  Frequency getByDescription(String description) {
    return firstWhere((e) => e.description == description);
  }
}
