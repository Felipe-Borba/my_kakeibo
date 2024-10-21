import 'package:my_kakeibo/domain/entity/user/user.dart';

//TODO talvez isso seja meio demais acho que não tem tanto problema assim deixar isso lá na entidade já que isso só diz respeito a ela...
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

  // se eu deixar isso na entity talvez isso poderia ser até um simples construtor já que é isso que ele faz constrói o obj
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
