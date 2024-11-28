import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';

void main() {
  late User user;

  setUp(() {
    user = User(
      name: "user",
      email: "e@e.com",
      password: "123",
    );
  });

  group("decreaseAmount", () {
    test("Should decrease user balance", () {
      user.balance = 100;

      user.decreaseBalance(45);

      expect(user.balance, 55);
    });
  });
}
