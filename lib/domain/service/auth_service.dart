import 'package:my_kakeibo/core/records/app_error.dart';

abstract class AuthService {
  Future<(String, AppError)> login(String email, String password);

  Future<(Null, AppError)> logOut();

  Future<(String, AppError)> createAccess(String email, String password);

  Future<(bool, AppError)> recoverPassword(String email);

  Future<(String, AppError)> getLoggedUserId();
}
