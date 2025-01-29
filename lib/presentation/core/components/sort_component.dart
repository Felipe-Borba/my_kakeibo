import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SortComponent extends StatelessWidget {
  const SortComponent({
    super.key,
    required this.sort,
    required this.onSortChanged,
  });

  final SortEnum sort;
  final ValueChanged<SortEnum> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final intl = AppLocalizations.of(context)!;

    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<SortEnum>(
        tooltip: intl.sortOptions,
        onSelected: onSortChanged,
        child: const Icon(Icons.filter_alt),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: SortEnum.dateAsc,
            child: Row(
              children: [
                Text(intl.dateAsc),
                const SizedBox(width: 8),
                if (sort == SortEnum.dateAsc)
                  const Icon(Icons.check, color: Colors.green),
              ],
            ),
          ),
          PopupMenuItem(
            value: SortEnum.dateDesc,
            child: Row(
              children: [
                Text(intl.dateDesc),
                const SizedBox(width: 8),
                if (sort == SortEnum.dateDesc)
                  const Icon(Icons.check, color: Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum SortEnum {
  dateAsc,
  dateDesc,
}
