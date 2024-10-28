import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
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

  group("validate", () {
    test("should create user with all params", () {
      var (isValid, error) = user.validate();

      expect(isValid, true);
      expect(error, isA<Empty>());
    });

    test("should not create user with empty name", () {
      user.name = "";

      var (isValid, errors) = user.validate();
      var error = (errors as FieldFailure).fieldErrorList.first;

      expect(isValid, false);
      expect(error.name, "name");
      expect(error.message, "Name is required");
    });

    test("should not create user with empty email", () {
      user.email = "";

      var (isValid, errors) = user.validate();
      var error = (errors as FieldFailure).fieldErrorList.first;

      expect(isValid, false);
      expect(error.name, "email");
      expect(error.message, "Email is required");
    });

    test("should not create user with empty password", () {
      user.password = "";

      var (isValid, errors) = user.validate();
      var error = (errors as FieldFailure).fieldErrorList.first;

      expect(isValid, false);
      expect(error.name, "password");
      expect(error.message, "Password is required");
    });
  });

  group("decreaseAmount", () {
    test("Should decrease user balance", () {
      user.balance = 100;
      
      user.decreaseBalance(45);

      expect(user.balance, 55);
    });
  });
}
