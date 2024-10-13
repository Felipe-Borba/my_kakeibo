abstract interface class Error {}

final class Failure implements Error {
  final String message;

  Failure(this.message);
}

final class Empty implements Error {}

/**
 * Exemplo de uso pode ser visto nos teste
 */


