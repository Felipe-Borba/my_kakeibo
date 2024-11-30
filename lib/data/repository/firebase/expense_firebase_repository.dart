import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/firebase/model/expense_model.dart';
import 'package:my_kakeibo/data/repository/firebase/user_firebase_repository.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';

class ExpenseFirebaseRepository implements ExpenseRepository {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _table = "Expense";

  @override
  Future<(Null, AppError)> delete(Expense expense) async {
    try {
      var userId = _auth.currentUser?.uid;

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
      var userId = _auth.currentUser?.uid;

      var querySnapshot = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .get();

      var expenses = querySnapshot.docs
          .map((doc) => ExpenseModel.fromDoc(doc).toEntity())
          .toList();

      return (expenses, Empty());
    } catch (e) {
      return (List<Expense>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(Expense?, AppError)> insert(Expense expense) async {
    try {
      var userId = _auth.currentUser?.uid;
      expense.date = expense.date.toUtc();

      var res = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .add(ExpenseModel.fromExpense(expense).toJson());

      expense.id = res.id;
      return (expense, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Expense?, AppError)> update(Expense expense) async {
    try {
      var userId = _auth.currentUser?.uid;
      expense.date = expense.date.toUtc();

      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(expense.id);

      await docRef.update(ExpenseModel.fromExpense(expense).toJson());

      return (expense, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<Expense>, AppError)> findByMonth({
    required DateTime month,
  }) async {
    try {
      var userId = _auth.currentUser?.uid;

      if (userId == null) {
        return (List<Expense>.empty(), Failure("User not authenticated"));
      }

      DateTime startOfMonth = DateTime(month.year, month.month, 1);
      DateTime endOfMonth =
          DateTime(month.year, month.month + 1, 0, 23, 59, 59);

      var query = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .where("date",
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth))
          .where("date", isLessThanOrEqualTo: Timestamp.fromDate(endOfMonth));

      var querySnapshot = await query.get();

      var expenses = querySnapshot.docs
          .map((doc) => ExpenseModel.fromDoc(doc).toEntity())
          .toList();

      return (expenses, Empty());
    } catch (e) {
      return (List<Expense>.empty(), Failure(e.toString()));
    }
  }
}
