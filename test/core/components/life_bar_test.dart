import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/presentation/core/components/life_bar.dart';

import '../../utils_test.dart';

void main() {
  double total = 1000.0;
  double current = 500.0;
  const key = Key("life-bar");

  testWidgets('Should render correctly if inputs are valid', (tester) async {
    total = 1000.0;
    current = 500.0;

    await tester.pumpWidget(
      createTestableWidget(
        LifeBar(
          key: key,
          current: current,
          total: total,
        ),
      ),
    );

    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets('Should render correctly if total id zero', (tester) async {
    total = 0.0;
    current = 500.0;

    await tester.pumpWidget(
      createTestableWidget(
        LifeBar(
          key: key,
          current: current,
          total: total,
        ),
      ),
    );

    expect(find.byKey(key), findsOneWidget);
  });
}
