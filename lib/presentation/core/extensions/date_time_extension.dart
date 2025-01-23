import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatToString(BuildContext context) {
    return DateFormat.MMMEd(
      Localizations.localeOf(context).toString(),
    ).format(this);
  }
}
