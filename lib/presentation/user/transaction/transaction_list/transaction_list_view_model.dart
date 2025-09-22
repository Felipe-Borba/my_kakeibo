import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/sort_component.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/expense/expense_form/expense_form_view.dart';
import 'package:my_kakeibo/presentation/user/income/income_form/income_form_view.dart';

enum TransactionType {
  all,
  income,
  expense,
}

class TransactionListViewModel with ChangeNotifier {
  TransactionListViewModel(
    this._context,
    this._expenseRepository,
    this._incomeRepository,
  ) {
    getInitialData();
  }

  // Dependencies
  final ExpenseRepository _expenseRepository;
  final IncomeRepository _incomeRepository;
  final BuildContext _context;

  // State
  List<Transaction> allTransactions = [];
  List<Expense> expenses = [];
  List<Income> incomes = [];
  List<Transaction> filteredTransactions = [];

  SortEnum sort = SortEnum.dateDesc;
  DateTime monthFilter = DateTime.now();
  TransactionType selectedType = TransactionType.all;

  // Actions
  getInitialData() async {
    await Future.wait([
      _loadExpenses(),
      _loadIncomes(),
    ]);

    _combineAndFilterTransactions();
    notifyListeners();
  }

  Future<void> _loadExpenses() async {
    var result = await _expenseRepository.findByMonth(
      month: monthFilter,
    );
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      expenses = success;
    });
  }

  Future<void> _loadIncomes() async {
    var result = await _incomeRepository.findByMonth(
      month: monthFilter,
    );
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      incomes = success;
    });
  }

  void _combineAndFilterTransactions() {
    switch (selectedType) {
      case TransactionType.all:
        filteredTransactions = [...incomes, ...expenses];
        break;
      case TransactionType.income:
        filteredTransactions = incomes;
        break;
      case TransactionType.expense:
        filteredTransactions = expenses;
        break;
    }

    sortTransactions();
  }

  void sortTransactions() {
    switch (sort) {
      case SortEnum.dateAsc:
        filteredTransactions.sort((a, b) => a.date.compareTo(b.date));
        break;
      case SortEnum.dateDesc:
        filteredTransactions.sort((a, b) => b.date.compareTo(a.date));
        break;
    }
  }

  setSortBy(SortEnum sort) {
    this.sort = sort;
    sortTransactions();
    notifyListeners();
  }

  setTransactionType(TransactionType type) {
    selectedType = type;
    _combineAndFilterTransactions();
    notifyListeners();
  }

  setMonthFilter(DateTime value) {
    monthFilter = value;
    getInitialData();
  }

  void onDelete(Transaction transaction) async {
    if (transaction is Expense) {
      await _expenseRepository.delete(transaction);
    } else if (transaction is Income) {
      await _incomeRepository.delete(transaction);
    }

    await _loadExpenses();
    _combineAndFilterTransactions();
    notifyListeners();
  }

  onEdit(Transaction transaction) async {
    var refresh = false;
    if (transaction is Expense) {
      refresh =
          await _context.pushScreen(ExpenseFormView(expense: transaction));
    } else if (transaction is Income) {
      refresh = await _context.pushScreen(IncomeFormView(income: transaction));
    }
    if (refresh == true) {
      await _loadIncomes();
      _combineAndFilterTransactions();
      notifyListeners();
    }
  }

  onAddExpense() async {
    var refresh = await _context.pushScreen(const ExpenseFormView());
    if (refresh == true) {
      await _loadExpenses();
      _combineAndFilterTransactions();
      notifyListeners();
    }
  }

  onAddIncome() async {
    var refresh = await _context.pushScreen(const IncomeFormView());
    if (refresh == true) {
      await _loadIncomes();
      _combineAndFilterTransactions();
      notifyListeners();
    }
  }
}
