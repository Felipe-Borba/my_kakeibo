import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/model/user.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebaseRepository extends UserRepository {
  final _db = FirebaseFirestore.instance;
  final _table = "Users";

  @override
  Future<(User?, AppError)> getUserById(String id) async {
    try {
      var userQuery =
          await _db.collection(_table).where("id", isEqualTo: id).get();

      var userMap = userQuery.docs.first.data();

      return (UserModel.fromJson(userMap), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Null, AppError)> save(User user) async {
    try {
      await _db.collection(_table).add(user.toJson());

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
