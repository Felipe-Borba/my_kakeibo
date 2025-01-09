import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_kakeibo/data/repository/firebase/model/income_model.dart';
import 'package:my_kakeibo/data/repository/firebase/user_firebase_repository.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/data/repository/income_repository.dart';
import 'package:result_dart/result_dart.dart';

class IncomeFirebaseRepository implements IncomeRepository {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _table = "Income";

  @override
  Future<Result<Income>> delete(Income income) async {
    try {
      var userId = _auth.currentUser?.uid;

      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(income.id);

      await docRef.delete();

      return Success(income);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Income>>> findAll() async {
    try {
      var userId = _auth.currentUser?.uid;

      var querySnapshot = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .get();

      var incomes = querySnapshot.docs
          .map((doc) => IncomeModel.fromDoc(doc).toEntity())
          .toList();

      return Success(incomes);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<Income>> insert(Income income) async {
    try {
      var userId = _auth.currentUser?.uid;

      var docRef = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .add(IncomeModel.fromEntity(income).toJson());

      income.id = docRef.id;
      return Success(income);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<Income>> update(Income income) async {
    try {
      var userId = _auth.currentUser?.uid;

      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(income.id);

      await docRef.update(IncomeModel.fromEntity(income).toJson());

      return Success(income);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Income>>> findByMonth({
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

      var incomes = querySnapshot.docs
          .map((doc) => IncomeModel.fromDoc(doc).toEntity())
          .toList();

      return Success(incomes);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
