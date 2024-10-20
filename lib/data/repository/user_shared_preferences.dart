import 'dart:convert';

import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences implements UserRepository {
  static const String userKey = 'user';

  @override
  Future<(Null, AppError)> save(User user) async {
    final preferences = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    preferences.setString(userKey, userJson);

    return (null, Empty());
  }

  @override
  Future<(User?, AppError)> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    String? userJson = preferences.getString(userKey);

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return (UserModel.fromJson(userMap), Empty());
    }

    return (null, Failure("User not found"));
  }

  @override
  Future<(User?, AppError)> getUserById(String id) async {
    return getUser();
  }
}
