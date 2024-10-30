import 'package:flutter/material.dart';

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
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<int>(
        tooltip: "Sort options",
        onSelected: onSortChanged,
        child: const Icon(Icons.filter_alt),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                const Text("Date asc"),
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
                const Text("Date desc"),
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
