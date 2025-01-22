import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  final ValueNotifier<int> currentIndexNotifier;
  final Function(int selectedIndex) onTabTapped;

  const BottomNavigationBarCustom({
    super.key,
    required this.currentIndexNotifier,
    required this.onTabTapped,
  });

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currentIndexNotifier.value,
      onTap: (index) {
        widget.currentIndexNotifier.value = index;
        if (index == 2) {
          scaffold.openEndDrawer();
        } else {
          widget.onTabTapped(index);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: context.intl.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.insert_chart_outlined_rounded),
          label: context.intl.insights,
        ),
        // BottomNavigationBarItem(
        //   icon: const Icon(Icons.person_outline),
        //   label: context.intl.profile,
        // ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu),
          label: context.intl.menu,
        ),
      ],
    );
  }
}
