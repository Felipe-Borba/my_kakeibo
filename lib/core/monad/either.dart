abstract class Either<L, R> {
  T fold<T>(T Function(L l) failure, T Function(R r) success);

  bool get isFailure => fold((_) => true, (_) => false);
  bool get isSuccess => fold((_) => false, (_) => true);

  // R getOrElse(R dflt()) => fold((_) => dflt(), (r) => r);
}
// peguei somente o que eu quero da lib https://pub.dev/packages/dartz