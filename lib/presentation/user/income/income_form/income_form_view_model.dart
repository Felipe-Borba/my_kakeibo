import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';

class IncomeFormViewModel with ChangeNotifier {
  IncomeFormViewModel(this._context, this._income, this._incomeUseCase);

  // Dependencies
  final IncomeUseCase _incomeUseCase;
  final BuildContext _context;
  final Income? _income;
  final formKey = GlobalKey<FormState>();

  // State
  late double? amount = _income?.amount;
  late DateTime? date = _income?.date;
  late String description = _income?.description ?? '';
  late IncomeSource? source = _income?.source;

  // Actions
  onClickSave() async {
    bool isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    var result = await _incomeUseCase.insert(Income(
      id: _income?.id,
      amount: amount!,
      source: source!,
      description: description,
      date: date ?? DateTime.now(),
    ));

    result.onSuccess((success) {
      _context.popScreen(true);
    });

    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });

    notifyListeners();
  }

  String? validateAmount(String? value) {
    if (value == null) return _context.intl.fieldRequired;
    double? amount = _context.currency.tryParse(value)?.toDouble();
    if (amount == null) return _context.intl.fieldRequired;
    if (amount <= 0) return _context.intl.fieldGreaterThenZero;
    return null;
  }

  String? validateDate(String? value) {
    if (value == null) return _context.intl.fieldRequired;
    if (value.isEmpty) return _context.intl.fieldRequired;
    return null;
  }

  String? validateDescription(String? value) {
    return null;
  }

  String? validateSource(IncomeSource? value) {
    if (value == null) return _context.intl.fieldRequired;
    return null;
  }
}
