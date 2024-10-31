abstract interface class AppError {}

final class Failure implements AppError {
  final String message;

  Failure(this.message);
}

// Verificar mas talvez essa forma mais simples de validação de erro baseada com tuplas seja interessante por causa do polimorfismo e simplicidade
// não que não de para fazer lá com a mesma interface Error mas aqui é bem mais simples, averiguar
// posso começar por aqui e mais para a frente avaliar a necessidade de troca mas vai ser mto chato de trocar.
@Deprecated('Vou remover isso porque a validação vai ser feita de uma forma separada lá direto na presentation e com uma classe externa da validator')
final class FieldFailure implements AppError {
  final List<FieldError> fieldErrorList;

  FieldFailure(this.fieldErrorList);
}

final class FieldError {
  final String name;
  final String message;

  FieldError(this.name, this.message);
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


