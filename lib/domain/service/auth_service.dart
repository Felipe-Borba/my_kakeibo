import 'package:result_dart/result_dart.dart';

abstract class AuthService {
  Future<Result<String>> login(String email, String password);

  Future<Result<void>> logOut();

  Future<Result<String>> createAccess(String email, String password);

  Future<Result<bool>> recoverPassword(String email);

  Future<Result<String>> getLoggedUserId();
}
