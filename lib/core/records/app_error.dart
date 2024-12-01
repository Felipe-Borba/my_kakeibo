abstract interface class AppError {}

final class Failure implements AppError {
  final String message;

  Failure(this.message);
}

final class Warning implements AppError {
  final String message;

  Warning(this.message);
}

final class Empty implements AppError {}

/**
 * Exemplo de uso pode ser visto nos teste
 * Pesquisar sobre o problema do goto quando usa muitos try catch
 * Parece ter um problema sobre colocar muitos try catch no mesmo fluxo que isso vai minando o código ai cria uns efeitos colaterais difíceis de prever e debugar
 *
 * it's better to only catch exception that I will handle
 * try {
 *   //Some code
 * } on Exception catch(e) {
 *   //Error handling
 * }
 *
 */


