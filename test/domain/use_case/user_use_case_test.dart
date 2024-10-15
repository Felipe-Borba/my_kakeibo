import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/datasource/user_memory_repository.dart';
import 'package:my_kakeibo/domain/entity/user.dart';
import 'package:my_kakeibo/domain/entity/user_theme.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

void main() {
  group('UserUseCase', () {
    group("insert", () {
      test('Should persist user with all params', () async {
        var repository = UserMemoryRepository();
        var userUseCase = UserUseCase(userRepository: repository);
        var user = User(name: "Bob", theme: UserTheme.system);

        var (response, error) = await userUseCase.insert(user);

        var (persistedUser, _) = await repository.getUser();
        expect(persistedUser, isNotNull);
        expect(response, null);
        expect(error, isA<Empty>());
        expect(user, persistedUser);
        // pode dar um erro clássico aqui pq ele tá comparando referência de obj, mas como o banco é em memoria acaba que a referência é a mesma mas nem sempre isso é verdade no caso do shared pref por ex.
        // para resolver isso tenho que sobre escrever o método de comparação mas é uma sintaxe feia e para isso exite o package equatable
      });

      test('Should not insert user with empty name', () async {
        var repository = UserMemoryRepository();
        var userUseCase = UserUseCase(userRepository: repository);
        var user = User(name: "", theme: UserTheme.system);

        var (_, error) = await userUseCase.insert(user);

        var (persistedUser, _) = await repository.getUser();
        expect(persistedUser, null);
        expect(error, isA<FieldFailure>());
        if (error is FieldFailure) {
          var fieldError = error.fieldErrorList[0];
          expect(fieldError.field, "name");
          expect(fieldError.message, "Field required");
        }
      });
    });
  });
}
