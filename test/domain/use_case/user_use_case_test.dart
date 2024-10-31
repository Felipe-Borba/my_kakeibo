import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/user_memory_memory.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/auth_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

import '../../mocks/auth_repository_mock.dart';
import '../../mocks/user_repository_mock.dart';

void main() {
  late UserUseCase userUseCase;
  late UserRepository userRepository;
  late AuthRepository authRepository;
  late User user;

  setUp(() {
    userRepository = UserRepositoryMock();
    authRepository = AuthRepositoryMock();

    userUseCase = UserUseCase(
      userRepository: userRepository,
      authRepository: authRepository,
    );

    user = User(
      name: "Bob",
      email: "e@e.com",
      password: "123",
    );
  });

  group("insert", () {
    setUp(() {
      userRepository = UserMemoryDatabase();

      userUseCase = UserUseCase(
        userRepository: userRepository,
        authRepository: authRepository,
      );
    });

    test('Should persist user with all params', () async {
      when(
        () => authRepository.createAccess(user.email, user.password),
      ).thenAnswer(
        (_) async => ('id', Empty()),
      );
      var (response, error) = await userUseCase.insert(user);

      // Isso pode não parecer fazer sentido no começo mas é por que aqui eu to usando uma implementação do banco do usuário em memória
      var (persistedUser, _) = await userRepository.getUserById("id");
      expect(persistedUser, isNotNull);
      expect(response, null);
      expect(error, isA<Empty>());
      expect(user, persistedUser);
      verify(
        () => authRepository.createAccess(user.email, user.password),
      ).called(1);
      // pode dar um erro clássico aqui pq ele tá comparando referência de obj, mas como o banco é em memoria acaba que a referência é a mesma mas nem sempre isso é verdade no caso do shared pref por ex.
      // para resolver isso tenho que sobre escrever o método de comparação mas é uma sintaxe feia e para isso exite o package equatable
    });

    test('Should not insert user with empty name', () async {
      user.name = "";

      var (_, error) = await userUseCase.insert(user);

      var (persistedUser, _) = await userRepository.getUserById("id");
      expect(persistedUser, null);
      expect(error, isA<FieldFailure>());
      if (error is FieldFailure) {
        var fieldError = error.fieldErrorList[0];
        expect(fieldError.name, "name");
        expect(fieldError.message, "Name is required");
      }
    });
  });

  group("login", () {
    test("Should login and get user from userRepository", () async {
      when(() => authRepository.login("email", "password"))
          .thenAnswer((_) async => ('id', Empty()));
      when(() => userRepository.getUserById("id"))
          .thenAnswer((_) async => (user, Empty()));

      var (loggedUser, _) = await userUseCase.login("email", "password");

      verify(() => authRepository.login("email", "password")).called(1);
      verify(() => userRepository.getUserById("id")).called(1);
      expect(loggedUser, user);
    });

    test("Should return login error if login return failure", () async {
      var failure = Failure("some error");
      when(() => authRepository.login("email", "password"))
          .thenAnswer((_) async => ('id', failure));
      when(() => userRepository.getUserById("id"))
          .thenAnswer((_) async => (user, Empty()));

      var (loggedUser, err) = await userUseCase.login("email", "password");

      verify(() => authRepository.login("email", "password")).called(1);
      verifyNever(() => userRepository.getUserById("id"));
      expect(loggedUser, null);
      expect(err, failure);
    });

    test("Should return userRepository error if getUser return failure",
        () async {
      var failure = Failure("some error");
      when(() => authRepository.login("email", "password"))
          .thenAnswer((_) async => ('id', Empty()));
      when(() => userRepository.getUserById("id"))
          .thenAnswer((_) async => (user, failure));

      var (loggedUser, err) = await userUseCase.login("email", "password");

      verify(() => authRepository.login("email", "password")).called(1);
      verify(() => userRepository.getUserById("id")).called(1);
      expect(loggedUser, null);
      expect(err, failure);
    });
  });
}
