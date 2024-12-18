# my_kakeibo

Projeto de flutter MY KAKEIBO

Aplicativo realizado com o flutter e o firebase .

## Setup your project
instalar as depencias e pau no gato

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/to/state-management-sample).

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/to/resolution-aware-images).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter apps](https://flutter.dev/to/internationalization).


-------
-------


## Teste 

[video teste de integração](https://www.youtube.com/watch?v=GEvNj7uogYE)     
[video firebase test lab](https://www.youtube.com/watch?v=RBoMdhPQX1s&t=150s)

Rodar o teste com cobertura
```
flutter test --coverage
```

Para rodar todos os testes

```console
flutter test
```

Rodar os teste de integarção
```
flutter test integration_test/app_test.dart
```
com o driver
```
flutter drive --target=integration_test/app_test.dart
```

## Dependencies

Algumas dependências que vale mencionar e saber sobre

**Para mock:**

- [mocktail](https://pub.dev/packages/mocktail)
- [mockito](https://pub.dev/packages/mockito)

**Para controle de exceção:**

- [dartz](https://pub.dev/packages/dartz)
- [result_dart](https://pub.dev/packages/result_dart)

**Para persistência de dados:**
- [shared_preferences]()
- [cloud_firestore]() *(DB do firebase)*
- [realm](https://pub.dev/packages/realm)

**Para controle de estado:**

- ValueNotifier
- ChangeNotifier
- [Mobx](https://pub.dev/packages/mobx)
- [provider](https://pub.dev/packages/provider)

**Misc:**

- [Equatable](https://pub.dev/packages/equatable)
- [flutter_modular](https://pub.dev/packages/flutter_modular)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [uuid](https://pub.dev/packages/uuid)

**Validação**

- [lucid_validation]()

**Para injeção de deponência:**

- [get_it](https://pub.dev/packages/get_it)

**Styling**
- [Mix](https://www.fluttermix.com)

### Serialização para json
depois de anotar la roda
```
dart run build_runner build --delete-conflicting-outputs
```
existe uma modo maroto que ele fica vendo as mudanças e gerando automático
```
flutter pub run build_runner watch
```

### Usando o realm
depois que mudar alguma coisa lá no model tem que gerar dnv o .realm file
```console
dart run realm generate
```

### Geração de ícone de launcher

Para simplificar o processo usarei a dependência [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)

Para instalar o pacote:
```markdown
flutter pub add flutter_launcher_icons --dev
```

Para criar o arquivo de configuração automaticamente:
```bash
dart run flutter_launcher_icons:generate
```
*É recomendável que o ícone seja um arquivo PNG quadrado, idealmente com 512x512 pixels ou maior, para garantir boa qualidade em diferentes tamanhos.*

Depois de configurar o app e escolher a imagem é so rodar:
```console
flutter pub get
dart run flutter_launcher_icons
```

# Como buildar o projeto
## AAB
```console
flutter build appbundle
```
## APK
```console
flutter build apk
```


## Prototipação
- [Figma](https://www.figma.com/design/4vUcpYbgXym2421mm6m6wf/Untitled?node-id=0-1&t=gru349fF9GRNu7J4-1)
- [gerador de temas material3](https://material-foundation.github.io/material-theme-builder/)

## Próximos passos

- [x] Isolar alguns componentes de input
- [x] Teste nova arquitetura da tela da expense_form
- [x] Filtrar as listas por mês
<!-- - [ ] Login com facebook e google -->
- [ ] Teste tela escrolável dando overflow
- [x] Traduzir o app todo para português
- [ ] Empty state das listas
- [x] Recorrência de coisas
- [ ] Visão computacional
- [x] Colocar um gráficozinho mensal na dashboard comparando receita e despesa (pensei em uma barra azul ou verde com vermelho na horizontal)
- [x] Notificações (fiz setup básico das push notification)
- [ ] Lembretes de pagamentos de boletos, etc
- [ ] Deploy
- [ ] Observabilidade
- [ ] Criar uma identidade visual (tema bonsai, verde)
- [ ] Criar um design mais atrativo
- [x] Onboarding com possível paywall
- [ ] Incorporar a filosofia do kakeibo
- [ ] Tema claro e escuro
- [ ] Talvez uma tela de usuário mostrando o saldo dele, total gasto, ganho, anual? poder editar os dados dele...