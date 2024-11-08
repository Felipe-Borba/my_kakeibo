import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';

class IncomeFormController with ChangeNotifier {
  // Dependencies
  final incomeUseCase = Modular.get<IncomeUseCase>();

  // State
  TextEditingController amount = TextEditingController();
  String? amountError;

  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();
  String? dateError;

  TextEditingController description = TextEditingController();
  String? descriptionError;

  Income? income;

  // Actions
  loadInitialData(Income? income) async {
    this.income = income;
    if (income != null) {
      amount.text = income.amount.toString();
      selectedDate = income.date;
      dateController.text = "${income.date.toLocal()}".split(' ')[0];
      description.text = income.description;
    }
  }

  onSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = "${selectedDate!.toLocal()}".split(' ')[0];
    }
    notifyListeners();
  }

  onClickSave(BuildContext context) async {
    //TODO talvez exista uma forma melhor de validar a entidade principalmente quando se trata de campos de tipos diferentes de string?
    // se eu não me engano tem um padrao de validator melhor e separado da entity
    var (_, error) = await incomeUseCase.insert(Income(
      id: income?.id,
      amount: double.parse(amount.text),
      source: IncomeSource.salary,
      description: description.text,
      date: selectedDate ?? DateTime.now(),
    ));

    amountError = null;
    dateError = null;
    descriptionError = null;

    switch (error) {
      case Empty():
        Modular.to.pop(true);
        break;
      case Failure(:final message):
        showSnackbar(context: context, text: message);
        break;
      default:
        showSnackbar(context: context, text: "Erro desconhecido.");
    }
    notifyListeners();
  }
}
