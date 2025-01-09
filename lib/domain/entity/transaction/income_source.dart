import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';

// TODO depois no futuro seria legal deixar o usuário criar isso
// antes de fazer isso criar um componente de seleção para cada enum
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
