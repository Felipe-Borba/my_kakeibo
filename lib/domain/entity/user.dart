import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user_theme.dart';

class User {
  String? id;
  String name;
  String email;
  String password;
  UserTheme theme;
  double balance;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.theme,
    this.balance = 0.0,
  });

  (bool, AppError) validate() {
    List<FieldError> fieldErrorList = [];
    if (name.isEmpty) {
      //TODO isso prejudica a internacionalização depois, retornar uma msg de erro para mostrar diretor na tela
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
