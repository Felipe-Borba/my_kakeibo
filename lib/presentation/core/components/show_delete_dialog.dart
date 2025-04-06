import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';

Future<bool?> showDeleteDialog(BuildContext context, {Widget? content}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextCustom(
          context.intl.confirmDelete,
          prominent: true,
          textAlign: TextAlign.center,
        ),
        content: content ?? TextCustom(context.intl.confirmDeleteText),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: TextCustom(context.intl.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: TextCustom(context.intl.delete),
          ),
        ],
      );
    },
  );
}
