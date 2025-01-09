import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/data/repository/user_repository.dart';
import 'package:my_kakeibo/data/service/auth_service.dart';
import 'package:result_dart/result_dart.dart';

class OfflineFirstUserRepository extends UserRepository {
  final UserRepository localRepository;
  final UserRepository remoteRepository;
  final AuthService authService;

  OfflineFirstUserRepository({
    required this.localRepository,
    required this.remoteRepository,
    required this.authService,
  });

  @override
  Future<Result<void>> save(User user) async {
    var result = await localRepository.save(user);

    //TODO talvez ver uma estratégia melhor para saber o que j  foi e o que n o foi sincronizado, ex. app Runique
    var loggedUserIdResult = await authService.getLoggedUserId().isError();
    if (loggedUserIdResult) return result;

    return await remoteRepository.save(user);
  }

  @override
  Future<Result<User>> getUserById(String id) async {
    var result = await localRepository.getUserById(id);

    //TODO talvez ver uma estratégia melhor para saber o que j  foi e o que n o foi sincronizado, ex. app Runique
    var loggedUserIdResult = await authService.getLoggedUserId().isError();
    if (loggedUserIdResult) return result;

    result = await remoteRepository.getUserById(id);
    result.onSuccess((user) async {
      await localRepository.save(user);
    });

    return result;
  }

  @override
  Future<Result<User>> getSelf() {
    // TODO: implement getSelf
    throw UnimplementedError();
  }
}
