abstract interface class Error {}

final class Failure implements Error {
  final String message;

  Failure(this.message);
}

final class Empty implements Error {}

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


