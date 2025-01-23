import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';

class InputFormExpenseCategory extends StatelessWidget {
  final ExpenseCategory? value;
  final String? Function(ExpenseCategory?)? validator;
  final void Function(ExpenseCategory?)? onChanged;

  const InputFormExpenseCategory({
    super.key,
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ExpenseCategory?>(
      key: key,
      hint: Text(context.intl.category),
      value: value,
      onChanged: onChanged,
      items: ExpenseCategory.values.map((ExpenseCategory category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.getTranslation(context)),
        );
      }).toList(),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
