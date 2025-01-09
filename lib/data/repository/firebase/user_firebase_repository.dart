import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:my_kakeibo/data/repository/firebase/model/user_model.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/data/repository/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

class UserFirebaseRepository extends UserRepository {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  static const table = "Users";
  final uuid = const Uuid();

  @override
  Future<Result<User>> getUserById(String id) async {
    try {
      var userQuery = await _db.collection(table).doc(id).get();

      var userMap = userQuery.data();

      if (userMap == null) return Failure(Exception("User not found"));

      return Success(UserModel.fromJson(userMap).toEntity());
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> save(User user) async {
    try {
      var model = UserModel.fromUser(user);
      await _db.collection(table).doc(user.id).set(model.toJson());

      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<User>> getSelf() async {
    try {
      var id = _auth.currentUser?.uid;
      if (id == null) return Failure(Exception("Unauthorized"));

      var userQuery = await _db.collection(table).doc(id).get();

      var userMap = userQuery.data();

      if (userMap == null) return Failure(Exception("User not found"));

      return Success(UserModel.fromJson(userMap).toEntity());
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
