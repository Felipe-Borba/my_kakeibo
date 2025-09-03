import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/income/income_form/income_validator.dart';

class IncomeFormViewModel with ChangeNotifier {
  IncomeFormViewModel(this._context, this._income, this._incomeRepository);

  // Dependencies
  final IncomeRepository _incomeRepository;
  final BuildContext _context;
  final Income? _income;
  late final validator = IncomeValidator(context: _context);

  // State
  late double? amount = _income?.amount;
  late DateTime? date = _income?.date;
  late String description = _income?.description ?? '';
  late IncomeSource? source = _income?.source;

  // Actions
  onClickSave() async {
    if (validator.isInvalid()) return;

    var result = await _incomeRepository.save(Income(
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
}
