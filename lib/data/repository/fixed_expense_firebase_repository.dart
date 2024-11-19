import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/user_firebase_repository.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';

class FixedExpenseFirebaseRepository implements FixedExpenseRepository {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _table = "FixedExpense";

  @override
  Future<(Null, AppError)> delete(FixedExpense fixedExpense) async {
    try {
      var userId = _auth.currentUser?.uid;

      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(fixedExpense.id);

      await docRef.delete();

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<FixedExpense>, AppError)> findAll() async {
    try {
      var userId = _auth.currentUser?.uid;

      var querySnapshot = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .get();

      var expenses = querySnapshot.docs.map((doc) {
        var data = doc.data();
        data["id"] = doc.id;

        return FixedExpense.fromJson(data);
      }).toList();

      return (expenses, Empty());
    } catch (e) {
      return (List<FixedExpense>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(FixedExpense?, AppError)> insert(FixedExpense fixedExpense) async {
    try {
      var userId = _auth.currentUser?.uid;
      fixedExpense.dueDate = fixedExpense.dueDate
          .toUtc(); // no firebase isso ƒoi uma gambi para lidar com utc timestamp ja que a lib serializa para string iso8601

      var res = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .add(fixedExpense.toJson());

      fixedExpense.id = res.id;
      return (fixedExpense, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(FixedExpense?, AppError)> update(FixedExpense fixedExpense) async {
    try {
      var userId = _auth.currentUser?.uid;
      fixedExpense.dueDate = fixedExpense.dueDate.toUtc();

      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(fixedExpense.id);

      await docRef.update(fixedExpense.toJson());

      return (fixedExpense, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
