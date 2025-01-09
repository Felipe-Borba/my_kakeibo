import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_kakeibo/data/repository/firebase/model/fixed_expense_model.dart';
import 'package:my_kakeibo/data/repository/firebase/user_firebase_repository.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/data/repository/fixed_expense_repository.dart';
import 'package:result_dart/result_dart.dart';

class FixedExpenseFirebaseRepository implements FixedExpenseRepository {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _table = "FixedExpense";

  @override
  Future<Result<void>> delete(FixedExpense fixedExpense) async {
    try {
      var userId = _auth.currentUser?.uid;

      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(fixedExpense.id);

      await docRef.delete();

      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<FixedExpense>>> findAll() async {
    try {
      var userId = _auth.currentUser?.uid;

      var querySnapshot = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .get();

      var fixedExpenses = querySnapshot.docs
          .map((doc) => FixedExpenseModel.fromDoc(doc).toEntity())
          .toList();

      return Success(fixedExpenses);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<FixedExpense>> insert(FixedExpense fixedExpense) async {
    try {
      var userId = _auth.currentUser?.uid;

      var res = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .add(FixedExpenseModel.fromEntity(fixedExpense).toJson());

      fixedExpense.id = res.id;
      return Success(fixedExpense);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<FixedExpense>> update(FixedExpense fixedExpense) async {
    try {
      var userId = _auth.currentUser?.uid;

      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(fixedExpense.id);

      await docRef.update(FixedExpenseModel.fromEntity(fixedExpense).toJson());

      return Success(fixedExpense);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
