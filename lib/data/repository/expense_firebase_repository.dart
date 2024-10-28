import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/user_firebase_repository.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';

class ExpenseFirebaseRepository implements ExpenseRepository {
  final _db = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  final _table = "Expense";

  @override
  Future<(Null, AppError)> delete(Expense expense) async {
    try {
      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(expense.id);

      await docRef.delete();

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<Expense>, AppError)> findAll() async {
    try {
      var querySnapshot = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .get();

      var expenses = querySnapshot.docs.map((doc) {
        var data = doc.data();
        return Expense.fromJson(data);
      }).toList();

      return (expenses, Empty());
    } catch (e) {
      return (List<Expense>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(Expense?, AppError)> insert(Expense expense) async {
    try {
      await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .add(expense.toJson());

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Expense?, AppError)> update(Expense expense) async {
    try {
      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(expense.id);

      await docRef.update(expense.toJson());

      return (expense, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
