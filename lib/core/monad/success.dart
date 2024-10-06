import 'package:my_kakeibo/core/monad/either.dart';

class Success<L, R> extends Either<L, R> {
  final R value;

  Success(this.value);

  @override
  T fold<T>(T Function(L l) failure, T Function(R r) success) {
    return success(value);
  }
}
