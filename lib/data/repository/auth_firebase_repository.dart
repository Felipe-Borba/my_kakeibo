import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<(String, AppError)> createAccess(String email, String password) async {
    try {
      var userCredentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return (userCredentials.user!.uid, Empty());
    } catch (e) {
      return ("", Failure(e.toString()));
    }
  }

  @override
  Future<(String, AppError)> login(String email, String password) async {
    try {
      var userCredentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return (userCredentials.user!.uid, Empty());
    } catch (e) {
      return ("", Failure(e.toString()));
    }
  }

  @override
  Future<(bool, AppError)> recoverPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );

      return (true, Empty());
    } catch (e) {
      return (false, Failure(e.toString()));
    }
  }
  
  @override
  Future<(String, AppError)> getLoggedUserId() {
    // TODO: implement getLoggedUserId
    throw UnimplementedError();
  }
}
