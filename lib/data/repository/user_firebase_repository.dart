import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

class UserFirebaseRepository extends UserRepository {
  final _db = FirebaseFirestore.instance;
  static const table = "Users";

  @override
  Future<(User?, AppError)> getUserById(String id) async {
    try {
      var userQuery =
          await _db.collection(table).where("id", isEqualTo: id).get();

      var userMap = userQuery.docs.first.data();

      return (User.fromJson(userMap), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Null, AppError)> save(User user) async {
    try {
      await _db.collection(table).doc(user.id).set(user.toJson());

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
