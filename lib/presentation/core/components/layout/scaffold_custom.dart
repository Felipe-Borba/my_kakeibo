import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/layout/drawer_custom.dart';

class ScaffoldCustom extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget body;

  const ScaffoldCustom({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      endDrawer: const DrawerCustom(),
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(child: body),
    );
  }
}
