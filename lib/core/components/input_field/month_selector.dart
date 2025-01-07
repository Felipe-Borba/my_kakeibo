// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthSelector extends StatefulWidget {
  final Function(DateTime) onMonthSelected;
  final DateTime initialDate;

  const MonthSelector({
    super.key,
    required this.onMonthSelected,
    required this.initialDate,
  });

  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
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
    );
  }
}
