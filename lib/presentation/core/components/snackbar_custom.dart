import 'package:flutter/material.dart';

showSnackbar({
  required BuildContext context,
  required String text,
  bool isError = true,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(text),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
