import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/data/datasource/user_memory_repository.dart';
import 'package:my_kakeibo/domain/entity/user.dart';
import 'package:my_kakeibo/domain/entity/user_theme.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

void main() {
  group('UserUseCase', () {
    test('should insert user with all params', () async {
      var repository = UserMemoryRepository();
      var userUseCase = UserUseCase(userRepository: repository);
      var user = User(name: "Bob", theme: UserTheme.system);

      await userUseCase.insert(user);
      var persistedUser = await repository.getUser();

      assert(persistedUser != null);
      expect(user, persistedUser);
    });
  });
}
