import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/presentation/income/income_form/income_form_view.dart';

class IncomeListController with ChangeNotifier {
  // Dependencies
  final incomeUseCase = Modular.get<IncomeUseCase>();

  // State
  List<Income> list = List.empty();

  // Actions
  getInitialData(BuildContext context) async {
    var (list, error) = await incomeUseCase.findAll();
    if (error is Failure) {
      showSnackbar(context: context, text: error.message);
    }
    this.list = list;
    list.sort((a, b) => a.date.compareTo(b.date));
  }

  onDelete(Income income) async {
    await incomeUseCase.delete(income);
    var (list, error) = await incomeUseCase.findAll();
    this.list = list;
    list.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  onEdit(Income income) async {
    final refresh = await Modular.to.pushNamed(
      IncomeFormView.routeName,
      arguments: income,
    );

    if (refresh == true) {
      var (list, error) = await incomeUseCase.findAll();
      this.list = list;
      list.sort((a, b) => a.date.compareTo(b.date));
      notifyListeners();
    }
  }

  onAdd() {
    Modular.to.pushNamed(IncomeFormView.routeName);
  }
}
