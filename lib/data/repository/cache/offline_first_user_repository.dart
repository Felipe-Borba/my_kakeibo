import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/service/auth_service.dart';

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
  Future<(Null, AppError)> save(User user) async {
    var (localResult, localError) = await localRepository.save(user);
    if (localError is! Empty) return (null, localError);

    //TODO talvez ver uma estratégia melhor para saber o que já foi e o que não foi sincronizado, ex. app Runique
    var (loggedUserId, userError) = await authService.getLoggedUserId();
    if (loggedUserId.isNotEmpty) return (null, Warning("Local saved but user is not"));

    return await remoteRepository.save(user);
  }

  @override
  Future<(User?, AppError)> getUserById(String id) async {
    var (localUser, localError) = await localRepository.getUserById(id);
    if (localUser != null) {
      return (localUser, Empty());
    }

    //TODO talvez ver uma estratégia melhor para saber o que já foi e o que não foi sincronizado, ex. app Runique
    var (loggedUserId, userError) = await authService.getLoggedUserId();
    if (loggedUserId.isNotEmpty) return (localUser, Warning("Local saved but remote sync failed"));

    var (remoteUser, remoteError) = await remoteRepository.getUserById(id);
    if (remoteUser != null) {
      await localRepository.save(remoteUser);
      return (remoteUser, Empty());
    }

    return (null, remoteError);
  }
}
