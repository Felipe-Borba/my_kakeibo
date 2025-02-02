import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/repository/income_source_repository.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:provider/provider.dart';
import 'package:result_dart/result_dart.dart';

class InputFormIncomeSource extends StatefulWidget {
  final IncomeSource? value;
  final String? Function(IncomeSource?)? validator;
  final void Function(IncomeSource?)? onChanged;

  const InputFormIncomeSource({
    super.key,
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  State<InputFormIncomeSource> createState() => _InputFormIncomeSourceState();
}

class _InputFormIncomeSourceState extends State<InputFormIncomeSource> {
  bool _showLabel = false;
  List<IncomeSource> _list = List.empty();

  @override
  void initState() {
    super.initState();
    if (widget.value == null) {
      _showLabel = false;
    } else {
      _showLabel = true;
    }

    final incomeSourceRepository = Provider.of<IncomeSourceRepository>(
      context,
      listen: false,
    );
    incomeSourceRepository.findAll().onSuccess(
      (success) {
        setState(() {
          _list = success;
        });
      },
    );
  }

  _onChange(IncomeSource? value) {
    setState(() {
      if (widget.onChanged != null) {
        _showLabel = value != null;
        widget.onChanged!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<IncomeSource?>(
      hint: Text(context.intl.category),
      value: widget.value,
      onChanged: _onChange,
      items: _list.map((IncomeSource category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.name),
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
