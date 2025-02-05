import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class UserServiceSqlite {
  final SQLiteService _sqlite;

  UserServiceSqlite(this._sqlite);

  AsyncResult<User> insert(User user) async {
    try {
      final db = _sqlite.database;
      final insertedUser = user.copyWith(id: _sqlite.generateId());
      await db.insert('users', insertedUser.toMap());
      return Success(insertedUser);
    } catch (e) {
      return Failure(CustomException.unknownError());
    }
  }

  AsyncResult<User> update(User user) async {
    try {
      if (user.id == null) return Failure(CustomException.userNotFound());
      final db = _sqlite.database;
      final map = user.toMap();
      await db.update('users', map, where: 'id = ?', whereArgs: [user.id]);
      return Success(user);
    } catch (e) {
      return Failure(CustomException.unknownError());
    }
  }

  Future<Result<User>> getSelf() async {
    try {
      final db = _sqlite.database;
      final result = await db.query('users', limit: 1);
      if (result.isEmpty) {
        return Failure(CustomException.userNotFound());
      }
      final user = User.fromMap(result.first);
      return Success(user);
    } catch (e) {
      return Failure(CustomException.unknownError());
    }
  }
}
