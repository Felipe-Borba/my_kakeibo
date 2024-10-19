import 'package:my_kakeibo/domain/entity/user.dart';

extension UserModel on User {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'theme': theme,
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      theme: json['theme'],
    );
  }
}
