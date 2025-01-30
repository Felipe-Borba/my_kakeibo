import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/sort_component.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/income/income_form/income_form_view.dart';

class IncomeListViewModel with ChangeNotifier {
  IncomeListViewModel(this._context, this._incomeUseCase) {
    getInitialData();
  }

  // Dependencies
  final IncomeUseCase _incomeUseCase;
  final BuildContext _context;

  // State
  List<Income> list = List.empty();
  SortEnum sort = SortEnum.dateAsc;
  DateTime monthFilter = DateTime.now();

  // Actions
  getInitialData() async {
    var result = await _incomeUseCase.findByMonth(
      month: monthFilter,
    );

    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });

    result.onSuccess((success) {
      list = success;
      sortBy(sort);
      notifyListeners();
    });
  }

  setSortBy(SortEnum sort) {
    this.sort = sort;
    sortBy(sort);
    notifyListeners();
  }

  void sortBy(SortEnum sort) {
    switch (sort) {
      case SortEnum.dateAsc:
        list.sort((a, b) => a.date.compareTo(b.date));
        break;
      case SortEnum.dateDesc:
        list.sort((a, b) => b.date.compareTo(a.date));
        break;
    }
  }

  onDelete(Income income) async {
    await _incomeUseCase.delete(income);
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
      var list = (await _incomeUseCase.findAll()).getOrThrow();
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
