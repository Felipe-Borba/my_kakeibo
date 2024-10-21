import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/model/user.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebaseRepository extends UserRepository {
  final _db = FirebaseFirestore.instance;

  @override
  Future<(User?, AppError)> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<(Null, AppError)> save(User user) async {
    try {
      await _db.collection("Feedbacks").add(user.toJson());

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
