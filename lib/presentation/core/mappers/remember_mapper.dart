import 'package:flutter/widgets.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';

extension RememberMapper on Remember {
  String getTranslation(BuildContext context) {
    switch (this) {
      case Remember.no:
        return context.intl.no;
      case Remember.weekBefore:
        return context.intl.weekBefore;
      case Remember.dayBefore:
        return context.intl.dayBefore;
      case Remember.atDueDate:
        return context.intl.atDueDate;
    }
  }
}
