import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/expense/expense_form/expense_validator.dart';

class ExpenseFormViewModel with ChangeNotifier {
  ExpenseFormViewModel(this._context, this._expense, this._expenseRepository);

  // Dependencies
  final BuildContext _context;
  final Expense? _expense;
  final ExpenseRepository _expenseRepository;
  late final validator = ExpenseValidator(context: _context);

  late double? amount = _expense?.amount;
  late DateTime? date = _expense?.date;
  late String description = _expense?.description ?? '';
  late ExpenseCategory? category = _expense?.category;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Actions
  void onClickSave() async {
    if (validator.isInvalid()) return;

    _isLoading = true;
    notifyListeners();

    var result = await _expenseRepository.save(Expense(
      id: _expense?.id,
      amount: amount!,
      date: date ?? DateTime.now(),
      description: description,
      category: category!,
    ));

    result.onFailure((error) {
      showSnackbar(
        context: _context,
        text: error.toString(),
      );
    });

    result.onSuccess((success) {
      showSnackbar(
        context: _context,
        text: 'Despesa salva com sucesso!',
      );
      _context.popScreen(true);
    });

    _isLoading = false;
    notifyListeners();
  }

  void cancel() {
    _context.popScreen(false);
  }
}
