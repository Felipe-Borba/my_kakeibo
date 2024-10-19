import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user_theme.dart';

class User {
  String name;
  String email;
  String password;
  UserTheme theme;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.theme,
  });

  (bool, AppError) validate() {
    List<FieldError> fieldErrorList = [];
    if (name.isEmpty) {
      fieldErrorList.add(FieldError("name", "Name is required"));
    }

    if (email.isEmpty) {
      fieldErrorList.add(FieldError("email", "Email is required"));
    }

    if (password.isEmpty) {
      fieldErrorList.add(FieldError("password", "Password is required"));
    }

    return (
      fieldErrorList.isEmpty,
      fieldErrorList.isEmpty ? Empty() : FieldFailure(fieldErrorList)
    );
  }
}
