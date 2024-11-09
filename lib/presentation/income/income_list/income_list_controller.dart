import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/presentation/income/income_form/income_form_view.dart';

class IncomeListController with ChangeNotifier {
  IncomeListController(this._context);

  // Dependencies
  final incomeUseCase = Modular.get<IncomeUseCase>();
  final BuildContext _context;

  // State
  List<Income> list = List.empty();
  int sortNumber = 1;
  DateTime monthFilter = DateTime.now();

  // Actions
  getInitialData() async {
    var (list, error) = await incomeUseCase.findByMonth(
      month: monthFilter,
    );
    if (error is Failure) {
      showSnackbar(context: _context, text: error.message);
    }
    this.list = list;
    sortBy(sortNumber);
  }

  setSortBy(int sortNumber) {
    this.sortNumber = sortNumber;
    sortBy(sortNumber);
    notifyListeners();
  }

  void sortBy(int sortNumber) {
    switch (sortNumber) {
      case 1:
        list.sort((a, b) => a.date.compareTo(b.date));
        break;
      case 2:
        list.sort((a, b) => b.date.compareTo(a.date));
      default:
    }
  }

  onDelete(Income income) async {
    await incomeUseCase.delete(income);
    _doRefreshList(true);
  }

  onEdit(Income income) async {
    final refresh = await Modular.to.pushNamed<bool>(
      IncomeFormView.routeName,
      arguments: income,
    );
    await _doRefreshList(refresh);
  }

  onAdd() async {
    var refresh = await Modular.to.pushNamed<bool>(IncomeFormView.routeName);
    await _doRefreshList(refresh);
  }

  _doRefreshList(bool? refresh) async {
    if (refresh == true) {
      var (list, error) = await incomeUseCase.findAll();
      this.list = list;
      list.sort((a, b) => a.date.compareTo(b.date));
      notifyListeners();
    }
  }

  setMonthFilter(DateTime value) {
    monthFilter = value;
    getInitialData();
    notifyListeners();
  }
}
