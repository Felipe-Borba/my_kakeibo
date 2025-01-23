import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/user/income/income_form/income_form_view.dart';

class IncomeListController with ChangeNotifier {
  IncomeListController(this._context) {
    getInitialData();
  }

  // Dependencies
  late final incomeUseCase = _context.dependencyManager.incomeUseCase;
  final BuildContext _context;

  // State
  List<Income> list = List.empty();
  int sortNumber = 1;
  DateTime monthFilter = DateTime.now();

  // Actions
  getInitialData() async {
    var result = await incomeUseCase.findByMonth(
      month: monthFilter,
    );

    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });

    result.onSuccess((success) {
      list = success;
      sortBy(sortNumber);
      notifyListeners();
    });
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
    final refresh = await _context.pushScreen(IncomeFormView(income: income));
    await _doRefreshList(refresh);
  }

  onAdd() async {
    var refresh = await _context.pushScreen(const IncomeFormView());
    await _doRefreshList(refresh);
  }

  _doRefreshList(bool? refresh) async {
    if (refresh == true) {
      var list = (await incomeUseCase.findAll()).getOrThrow();
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
