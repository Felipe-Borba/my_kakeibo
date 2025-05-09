import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/presentation/core/components/charts/life_bar.dart';
import 'package:my_kakeibo/presentation/core/widget_keys.dart';

import '../../../../testing/app.dart';

void main() {
  double total = 1000.0;
  double current = 500.0;
  const key = WidgetKeys.lifeBar;

  testWidgets('Should render correctly if inputs are valid', (tester) async {
    total = 1000.0;
    current = 500.0;

    await createTestableWidget(
      tester,
      child: LifeBar(
        current: current,
        total: total,
      ),
    );

    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets('Should render correctly if total id zero', (tester) async {
    total = 0.0;
    current = 500.0;

    await createTestableWidget(
      tester,
      child: LifeBar(
        key: key,
        current: current,
        total: total,
      ),
    );

    expect(find.byKey(key), findsOneWidget);
  });
}
