import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/extensions/currency.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';

class IncomeFormController with ChangeNotifier {
  IncomeFormController(this._context, this._income);

  // Dependencies
  final incomeUseCase = Modular.get<IncomeUseCase>();
  final BuildContext _context;
  final Income? _income;
  final formKey = GlobalKey<FormState>();

  // State
  late double? amount = _income?.amount;
  late DateTime? date = _income?.date;
  late String description = _income?.description ?? '';

  // Actions
  onClickSave() async {
    bool isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    var (_, error) = await incomeUseCase.insert(Income(
      id: _income?.id,
      amount: amount!,
      source: IncomeSource.salary,
      description: description,
      date: date ?? DateTime.now(),
    ));

    switch (error) {
      case Empty():
        Modular.to.pop(true);
        break;
      case Failure(:final message):
        showSnackbar(context: _context, text: message);
        break;
      default:
        showSnackbar(context: _context, text: "Erro desconhecido.");
    }
    notifyListeners();
  }

  String? validateAmount(String? value) {
    if (value == null) return "valor obrigatório";
    double? amount = _context.currency.tryParse(value)?.toDouble();
    if (amount == null) return "valor obrigatório";
    if (amount <= 0) return "valor deve ser maior que zero";
    return null;
  }

  void setAmount(double? value) {
    amount = value;
  }

  void setDate(DateTime? value) {
    date = value;
  }

  String? validateDate(String? value) {
    if (value == null) return "Select a date";
    if (value.isEmpty) return "Select a date";
    return null;
  }

  void setDescription(String value) {
    description = value;
  }

  String? validateDescription(String? value) {
    return null;
  }
}
