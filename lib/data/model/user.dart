import 'package:my_kakeibo/domain/entity/user.dart';

extension UserModel on User {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      // 'theme': theme,
      'balance': balance,
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      // theme: json['theme'],
      balance: json['balance'],
    );
  }
}
