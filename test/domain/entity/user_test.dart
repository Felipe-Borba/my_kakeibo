import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user.dart';

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
      expect(error.field, "name");
      expect(error.message, "Name is required");
    });

    test("should not create user with empty email", () {
      user.email = "";

      var (isValid, errors) = user.validate();
      var error = (errors as FieldFailure).fieldErrorList.first;

      expect(isValid, false);
      expect(error.field, "email");
      expect(error.message, "Email is required");
    });

    test("should not create user with empty password", () {
      user.password = "";

      var (isValid, errors) = user.validate();
      var error = (errors as FieldFailure).fieldErrorList.first;

      expect(isValid, false);
      expect(error.field, "password");
      expect(error.message, "Password is required");
    });
  });
}
