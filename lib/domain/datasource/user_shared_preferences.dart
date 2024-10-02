import 'dart:convert';

import 'package:my_kakeibo/data/entity/user.dart';
import 'package:my_kakeibo/data/repository/user_repository.dart';
import 'package:my_kakeibo/domain/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences implements UserRepository {
  static const String userKey = 'user';

  @override
  void save(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    prefs.setString(userKey, userJson);
  }

  @override
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(userKey);

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }
}
