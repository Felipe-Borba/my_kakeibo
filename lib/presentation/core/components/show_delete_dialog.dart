import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool?> showDeleteDialog(BuildContext context) {
  final intl = AppLocalizations.of(context)!;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(intl.confirmDelete),
        content: Text(intl.confirmDeleteText),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(intl.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(intl.delete),
          ),
        ],
      );
    },
  );
}
