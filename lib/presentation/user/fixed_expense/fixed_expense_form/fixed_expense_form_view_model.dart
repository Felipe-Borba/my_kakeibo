import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/entity/notification/local_notification.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/fixed_expense/fixed_expense_form/fixed_expense_validator.dart';

class FixedExpenseFormViewModel with ChangeNotifier {
  FixedExpenseFormViewModel(
    this._context,
    this._fixedExpense,
    this._fixedExpenseRepository,
  );

  // Dependencies
  final BuildContext _context;
  final FixedExpense? _fixedExpense;
  final FixedExpenseRepository _fixedExpenseRepository;
  late final validator = FixedExpenseValidator(context: _context);

  // State
  late double? amount = _fixedExpense?.amount;
  late DateTime? dueDate = _fixedExpense?.dueDate;
  late String description = _fixedExpense?.description ?? '';
  late ExpenseCategory? category = _fixedExpense?.category;
  late Frequency? frequency = _fixedExpense?.frequency;
  late Remember? remember = _fixedExpense?.remember ?? Remember.no;

  // Actions
  void setAmount(double? value) {
    amount = value;
  }

  void setCategory(ExpenseCategory? value) {
    category = value;
  }

  void setDueDate(DateTime? value) {
    dueDate = value;
  }

  void setDescription(String value) {
    description = value;
  }

  void onClickSave() async {
    if (validator.isInvalid()) return;
    dueDate ??= DateTime.now();

    final notification = remember != Remember.no
        ? LocalNotification(
            date: dueDate!
                .subtract(switch (remember!) {
                  Remember.no => Duration.zero,
                  Remember.atDueDate => Duration.zero,
                  Remember.dayBefore => const Duration(days: 1),
                  Remember.weekBefore => const Duration(days: 7),
                })
                .copyWith(hour: 9, minute: 0, second: 0),
            title: _context.intl.fixedExpenseNotificationTitle,
            body: description,
          )
        : null;

    var result = await _fixedExpenseRepository.insert(
      FixedExpense(
        id: _fixedExpense?.id,
        description: description,
        category: category!,
        dueDate: dueDate!,
        amount: amount!,
        expenseList: _fixedExpense?.expenseList ?? [],
        frequency: frequency!,
        remember: remember!,
        notificationId: notification?.id,
      ),
      notification,
    );

    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });

    result.onSuccess((success) {
      _context.popScreen(true);
    });

    notifyListeners();
  }
}
