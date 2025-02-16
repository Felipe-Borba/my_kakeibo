import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/repository/expense_category_repository.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/screen_extension.dart';
import 'package:provider/provider.dart';
import 'package:result_dart/result_dart.dart';

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
  List<ExpenseCategory> _list = [];

  @override
  void initState() {
    super.initState();
    if (widget.value == null) {
      _showLabel = false;
    } else {
      _showLabel = true;
    }

    final expenseCategoryRepository = Provider.of<ExpenseCategoryRepository>(
      context,
      listen: false,
    );
    expenseCategoryRepository.findAll().onSuccess(
      (success) {
        setState(() {
          _list = success;
        });
      },
    );
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
      items: _list.map((ExpenseCategory category) {
        return DropdownMenuItem(
          value: category,
          child: Container(
            constraints: BoxConstraints(maxWidth: context.percentage(80)),
            child: Text(category.name, overflow: TextOverflow.ellipsis),
          ),
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
