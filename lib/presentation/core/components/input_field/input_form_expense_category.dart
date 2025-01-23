import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';

class InputFormExpenseCategory extends StatefulWidget {
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
  State<InputFormExpenseCategory> createState() =>
      _InputFormExpenseCategoryState();
}

class _InputFormExpenseCategoryState extends State<InputFormExpenseCategory> {
  bool _showLabel = false;

  @override
  void initState() {
    super.initState();
    if (widget.value == null) {
      _showLabel = false;
    } else {
      _showLabel = true;
    }
  }

  _onChange(ExpenseCategory? value) {
    setState(() {
      if (widget.onChanged != null) {
        _showLabel = value != null;
        widget.onChanged!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ExpenseCategory?>(
      hint: Text(context.intl.category),
      value: widget.value,
      onChanged: _onChange,
      items: ExpenseCategory.values.map((ExpenseCategory category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.getTranslation(context)),
        );
      }).toList(),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: _showLabel == true ? Text(context.intl.category) : null,
      ),
    );
  }
}
