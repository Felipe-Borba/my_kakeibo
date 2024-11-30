import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/firebase/model/income_model.dart';
import 'package:my_kakeibo/data/repository/firebase/user_firebase_repository.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';

class IncomeFirebaseRepository implements IncomeRepository {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _table = "Income";

  @override
  Future<(Null, AppError)> delete(Income income) async {
    try {
      var userId = _auth.currentUser?.uid;

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
      var userId = _auth.currentUser?.uid;

      var querySnapshot = await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .get();

      var incomes = querySnapshot.docs
          .map((doc) => IncomeModel.fromDoc(doc).toEntity())
          .toList();

      return (incomes, Empty());
    } catch (e) {
      return (List<Income>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(Income?, AppError)> insert(Income income) async {
    try {
      var userId = _auth.currentUser?.uid;

      await _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .add(IncomeModel.fromEntity(income).toJson());

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Income?, AppError)> update(Income income) async {
    try {
      var userId = _auth.currentUser?.uid;

      var docRef = _db
          .collection(UserFirebaseRepository.table)
          .doc(userId)
          .collection(_table)
          .doc(income.id);

      await docRef.update(IncomeModel.fromEntity(income).toJson());

      return (income, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<Income>, AppError)> findByMonth({
    required DateTime month,
  }) async {
    try {
      var userId = _auth.currentUser?.uid;
      if (userId == null) {
        return (List<Income>.empty(), Failure("User not authenticated"));
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

      return (incomes, Empty());
    } catch (e) {
      return (List<Income>.empty(), Failure(e.toString()));
    }
  }
}
