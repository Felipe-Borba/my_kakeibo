import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/data/user/user_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late SQLiteService sqliteService;
  late UserServiceSqlite userService;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    sqliteService = SQLiteService(version: 'test_user');
    userService = UserServiceSqlite(sqliteService);
  });

  tearDownAll(() async {
    final db = await sqliteService.database;
    await db.close();
    await sqliteService.dropDatabase();
  });

  group('UserServiceSqlite', () {
    setUp(() async {
      final db = await sqliteService.database;
      await db.delete(sqliteService.userTable);
    });

    test('should insert a user', () async {
      final user = User(
        name: 'Test User',
        theme: UserTheme.light,
        notificationToken: 'token',
      );

      final result = await userService.insert(user);
      expect(result.isSuccess(), true);
      result.fold(
        (data) {
          expect(data.id, isNotNull);
          expect(data.name, user.name);
          expect(data.theme, user.theme);
          expect(data.notificationToken, user.notificationToken);
        },
        (error) {
          fail('Insert failed');
        },
      );
    });

    test('should update a user', () async {
      final user = (await userService.insert(User(
        name: 'Test User',
        theme: UserTheme.light,
        notificationToken: 'token',
      )))
          .getOrThrow();

      final updatedUser = user.copyWith(
        name: "Updated name",
        theme: UserTheme.dark,
        notificationToken: "updatedToken",
      );
      final result = await userService.update(updatedUser);

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data.id, updatedUser.id);
        expect(data.name, updatedUser.name);
        expect(data.theme, updatedUser.theme);
        expect(data.notificationToken, updatedUser.notificationToken);
      });
      result.onFailure((error) {
        fail('Update failed');
      });
    });

    test("should throw an exception if id is null", () async {
      await userService.insert(User(
        name: 'Test User',
        theme: UserTheme.light,
        notificationToken: 'token',
      ));

      final userWithoutId = User(name: "Test User");
      final result = await userService.update(userWithoutId);

      expect(result.isError(), true);
      result.onSuccess((data) {
        fail('Update should have failed');
      });
      result.onFailure((error) {
        expect(error, isA<CustomException>());
        if (error is CustomException) {
          expect(error.type, ExceptionType.userNotFound);
        }
      });
    });

    test('should get the user', () async {
      final user = await userService
          .insert(User(
            name: 'Test User',
            theme: UserTheme.light,
            notificationToken: 'token',
          ))
          .getOrThrow();

      final result = await userService.getSelf();

      expect(result.isSuccess(), true);
      result.fold(
        (data) {
          expect(data.id, user.id);
          expect(data.name, user.name);
          expect(data.theme, user.theme);
          expect(data.notificationToken, user.notificationToken);
        },
        (error) {
          fail('Get user failed');
        },
      );
    });

    test('should delete the user', () async {
      await userService.insert(User(
        name: 'Test User',
        theme: UserTheme.light,
        notificationToken: 'token',
      ));

      await userService.delete();
      final result = await userService.getSelf();

      expect(result.isError(), true);
      result.onFailure((err) {
        expect(err, isA<CustomException>());
        if (err is CustomException) {
          expect(err.type, ExceptionType.userNotFound);
        }
      });
    });
  });
}
