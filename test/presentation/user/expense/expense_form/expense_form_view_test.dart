import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_kakeibo/presentation/core/widget_keys.dart';
import 'package:my_kakeibo/presentation/user/expense/expense_form/expense_form_view.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../../testing/app.dart';
import '../../../../../testing/domain/expense_category_repository_mock.dart';

void main() {
  testWidgets('Should validate required fields before create expense',
      (tester) async {
    // Arrange
    when(expenseCategoryRepositoryMock.findAll)
        .thenAnswer((_) async => Success(List.empty()));

    await createTestableWidget(
      tester,
      child: const ExpenseFormView(),
    );

    // Act
    await tester.tap(find.byKey(WidgetKeys.saveExpense));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text("Field is required"), findsNWidgets(3));
  });
}
