import 'package:my_kakeibo/data/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class AuthFirebaseService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Result<String>> createAccess(String email, String password) async {
    try {
      var userCredentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Success(userCredentials.user!.uid);
    } on FirebaseAuthException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<String>> login(String email, String password) async {
    try {
      var userCredentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Success(userCredentials.user!.uid);
    } on FirebaseAuthException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> logOut() async {
    try {
      await _auth.signOut();
      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<bool>> recoverPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return const Success(true);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<String>> getLoggedUserId() async {
    var user = _auth.currentUser;
    if (user != null) {
      return Success(user.uid);
    } else {
      return Failure(CustomException.userNotFound());
    }
  }
}
