import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SortComponent extends StatelessWidget {
  const SortComponent({
    super.key,
    required this.sortNumber,
    required this.onSortChanged,
  });

  final int sortNumber; //TODO eventualmente mudar isso para um enum
  final ValueChanged<int> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final intl = AppLocalizations.of(context)!;

    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<int>(
        tooltip: intl.sortOptions,
        onSelected: onSortChanged,
        child: const Icon(Icons.filter_alt),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Text(intl.dateAsc),
                const SizedBox(width: 8),
                if (sortNumber == 1)
                  const Icon(Icons.check, color: Colors.green),
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                Text(intl.dateDesc),
                const SizedBox(width: 8),
                if (sortNumber == 2)
                  const Icon(Icons.check, color: Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
