import 'package:my_kakeibo/domain/entity/user.dart';

extension UserModel on User {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'theme': theme,
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      theme: json['theme'],
    );
  }
}
