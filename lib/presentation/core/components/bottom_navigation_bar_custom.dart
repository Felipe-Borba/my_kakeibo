import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  final Function(int selectedIndex) onTabTapped;

  const BottomNavigationBarCustom({super.key, required this.onTabTapped});

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) {
        if (index == 3) {
          scaffold.openEndDrawer();
        } else {
          _currentIndex = index;
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
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: context.intl.profile,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu),
          label: context.intl.menu,
        ),
      ],
    );
  }
}
