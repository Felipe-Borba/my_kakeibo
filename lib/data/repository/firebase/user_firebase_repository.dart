import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/firebase/model/user_model.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:uuid/uuid.dart';

class UserFirebaseRepository extends UserRepository {
  final _db = FirebaseFirestore.instance;
  static const table = "Users";
  final uuid = const Uuid();

  @override
  Future<(User?, AppError)> getUserById(String id) async {
    try {
      var userQuery = await _db.collection(table).doc(id).get();

      var userMap = userQuery.data();

      if (userMap == null) return (null, Failure("User not found"));

      return (UserModel.fromJson(userMap).toEntity(), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Null, AppError)> save(User user) async {
    try {
      var model = UserModel.fromUser(user);
      await _db.collection(table).doc(user.id).set(model.toJson());

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
