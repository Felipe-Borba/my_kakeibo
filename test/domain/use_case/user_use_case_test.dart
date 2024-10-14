import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/data/datasource/user_memory_repository.dart';
import 'package:my_kakeibo/domain/entity/user.dart';
import 'package:my_kakeibo/domain/entity/user_theme.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

void main() {
  group('UserUseCase', () {
    test('Should insert and retrieve user with all params', () async {
      var repository = UserMemoryRepository();
      var userUseCase = necessidade(userRepository: repository);
      var user = User(name: "Bob", theme: UserTheme.system);

      await userUseCase.insert(user);
      var persistedUser = await repository.getUser();

      assert(persistedUser != null);
      expect(user, persistedUser);
      // pode dar um erro clássico aqui pq ele tá comparando referência de obj, mas como o banco é em memoria acaba que a referência é a mesma mas nem sempre isso é verdade no caso do shared pref por ex.
    });
  });
}
