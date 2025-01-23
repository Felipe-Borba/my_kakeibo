import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputMonth extends StatefulWidget {
  final Function(DateTime) onMonthSelected;
  final DateTime initialDate;

  const InputMonth({
    super.key,
    required this.onMonthSelected,
    required this.initialDate,
  });

  @override
  _InputMonthState createState() => _InputMonthState();
}

class _InputMonthState extends State<InputMonth> {
  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;
  }

  void _notifyDateChanged() {
    widget.onMonthSelected(DateTime(selectedYear, selectedMonth));
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedMonth,
      items: List.generate(12, (index) {
        return DropdownMenuItem(
          value: index + 1,
          child: Text(
            DateFormat.MMMM(
              Localizations.localeOf(context).toString(),
            ).format(DateTime(0, index + 1)),
          ),
        );
      }),
      onChanged: (value) {
        setState(() {
          selectedMonth = value!;
          _notifyDateChanged();
        });
      },
      underline: Container(),
      isDense: true,
    );
  }
}
