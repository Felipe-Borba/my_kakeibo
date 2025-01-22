import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/keyboard_aware.dart';
import 'package:my_kakeibo/presentation/core/components/layout/drawer_custom.dart';

class ScaffoldCustom extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget body;
  final FloatingActionButton? floatingActionButton;

  const ScaffoldCustom({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardAware(
      child: Scaffold(
        appBar: appBar,
        endDrawer: const DrawerCustom(),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        body: SafeArea(child: body),
      ),
    );
  }
}
