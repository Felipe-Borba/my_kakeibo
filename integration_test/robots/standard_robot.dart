import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class StandardRobot {
  final WidgetTester tester;

  StandardRobot(this.tester);

  openDrawer() async {
    final drawer = find.byTooltip('Open navigation menu');
    expect(drawer, findsOneWidget);
    await tester.tap(drawer);
    await tester.pumpAndSettle();
  }

  tapButton(Key key) async {
    final button = find.byKey(key);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }
}
