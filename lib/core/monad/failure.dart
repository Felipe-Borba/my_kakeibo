import 'package:my_kakeibo/core/monad/either.dart';

class Failure<L, R> extends Either<L, R> {
  final L value;

  Failure(this.value);

  @override
  T fold<T>(T Function(L l) failure, T Function(R r) success) {
    return failure(value);
  }
}
