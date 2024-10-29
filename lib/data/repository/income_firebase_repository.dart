import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/user_firebase_repository.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';

class IncomeFirebaseRepository implements IncomeRepository {
  final _db = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  final _table = "Income";

  @override
  Future<(Null, AppError)> delete(Income income) async {
    try {
      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(income.id);

      await docRef.delete();

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<Income>, AppError)> findAll() async {
    try {
      var querySnapshot = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .get();

      var incomes = querySnapshot.docs.map((doc) {
        var data = doc.data();

        Timestamp date = data["date"];
        data["date"] = date.toDate();

        data["id"] = doc.id;

        return Income.fromJson(data);
      }).toList();

      return (incomes, Empty());
    } catch (e) {
      return (List<Income>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(Income?, AppError)> insert(Income income) async {
    try {
      await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .add(income.toJson());

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Income?, AppError)> update(Income income) async {
    try {
      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(income.id);

      await docRef.update(income.toJson());

      return (income, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
