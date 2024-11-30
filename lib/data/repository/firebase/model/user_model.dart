import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:uuid/uuid.dart';

class UserModel {
  String id;
  String name;
  String email;
  String password;
  String? themeString;
  double balance;
  String? notificationToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.themeString,
    this.balance = 0.0,
    this.notificationToken,
  });

  UserTheme get theme => UserTheme.values
      .firstWhere((e) => e.toString().split('.').last == themeString);

  set theme(UserTheme theme) {
    themeString = theme.toString().split('.').last;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: '',
      themeString: json['theme'],
      notificationToken: json['notificationToken'],
      balance: json['balance'].toDouble(),
    );
  }

  factory UserModel.fromUser(User user) {
    const uuid = Uuid();
    return UserModel(
      id: user.id ?? uuid.v4(),
      name: user.name,
      email: user.email,
      password: user.password,
      balance: user.balance,
      notificationToken: user.notificationToken,
      // themeString: 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'theme': themeString,
      'balance': balance,
      'notificationToken': notificationToken,
    };
  }

  User toEntity() {
    return User(
      name: name,
      email: email,
      password: password,
      balance: balance,
      id: id,
      notificationToken: notificationToken,
    );
  }
}