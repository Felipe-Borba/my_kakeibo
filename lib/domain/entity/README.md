ator principal do sistema o core o cara do meio o sol do clean code

# Modelagem das entidades do meu sisteminha

```dart
class Transacao {}
class Receita extends Transacao {}
class Despesa extends Trasacao {}
```

Sobre o saldo:

- seria o somatório das transações
- quem tem um saldo é o usuário ele pode ser positivo ou negativo
- só é possível alterar o saldo por meio de um transação
- o usuário tem relacionado com ele uma lista de transações
