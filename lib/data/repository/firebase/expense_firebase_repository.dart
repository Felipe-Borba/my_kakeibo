import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_kakeibo/data/repository/firebase/model/expense_model.dart';
import 'package:my_kakeibo/data/repository/firebase/user_firebase_repository.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseFirebaseRepository implements ExpenseRepository {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _table = "Expense";

  @override
  Future<Result<Expense>> delete(Expense expense) async {
    try {
      var userId = _auth.currentUser?.uid;

      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(expense.id);

      await docRef.delete();

      return Success(expense);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Expense>>> findAll() async {
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

      return Success(expenses);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<Expense>> insert(Expense expense) async {
    try {
      var userId = _auth.currentUser?.uid;
      expense.date = expense.date.toUtc();

      var res = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .add(ExpenseModel.fromEntity(expense).toJson());

      expense.id = res.id;
      return Success(expense);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<Expense>> update(Expense expense) async {
    try {
      var userId = _auth.currentUser?.uid;
      expense.date = expense.date.toUtc();

      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(expense.id);

      await docRef.update(ExpenseModel.fromEntity(expense).toJson());

      return Success(expense);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Expense>>> findByMonth({
    required DateTime month,
  }) async {
    try {
      var userId = _auth.currentUser?.uid;

      if (userId == null) {
        return Failure(Exception("User not authenticated"));
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

      return Success(expenses);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
