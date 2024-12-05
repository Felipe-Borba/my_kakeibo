import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

class Income extends Transaction {
  IncomeSource source;
  // Tax Withholdings

  Income({
    required super.id,
    required super.amount,
    required super.date,
    required super.description,
    required this.source,
  });
}

enum IncomeSource {
  salary,
}

extension IncomeSourceHelper on IncomeSource {
  String getTranslation(BuildContext context) {
    switch (this) {
      case IncomeSource.salary:
        return context.intl.salary;
    }
  }

  String get description => toString().split('.').last;
}

extension IncomeSourceListExtension on List<IncomeSource> {
  IncomeSource getByDescription(String description) {
    return firstWhere((e) => e.description == description);
  }
}
