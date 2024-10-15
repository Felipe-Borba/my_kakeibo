import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/core/records/app_error.dart';

void main() {
  group('AppError record', () {
    // this is how it was proposed to be used, instead of the monad pattern (Either)
    (int, AppError) someOperation(int num) {
      if (num > 0) {
        return (num, Empty());
      } else {
        return (0, Failure("O numero deve ser maior que 0"));
      }
    }

    test('Should return error if someOperation is below zero', () {
      final (ok, err) = someOperation(-1);

      if (err is Failure) {
        expect(ok, 0);
        expect(err.message, "O numero deve ser maior que 0");
      } else {
        fail('someOperation deveria ter falhado!');
      }
    });

    test('Should return number if someOperation is greater than zero', () {
      final (ok, err) = someOperation(1);

      if (err is Empty) {
        expect(ok, 1);
      } else {
        fail('someOperation não deveria ter falhado!');
      }
    });
  });
}
