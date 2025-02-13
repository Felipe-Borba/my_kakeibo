# Notas do Dev

## Setup your project

instalar as depencias e pau no gato

### Versões do flutter

antes de mais nada é importante notar que o flutter tem várias versões e nem todos os projetos vão estar com as ultimas versões e as vezes você simplesmente precisa rodar uma versão antiga, dito isso o FVM (flutter version manager) trás uma simples solução tipo o nvm

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

---

---

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
- [cloud_firestore]() _(DB do firebase)_
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

para rodar os teste do realm, tem que instalar os binários do realm na máquina [issue](https://github.com/realm/realm-dart/issues/1619)

```console
dart run realm install
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

_É recomendável que o ícone seja um arquivo PNG quadrado, idealmente com 512x512 pixels ou maior, para garantir boa qualidade em diferentes tamanhos._

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

## Manutenção do app

Para verificar quais pacotes estão antigos e podem ser atualizados rode

```console
69 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
```

Depois de analisar o que pode ser atualizado, alterar as versão lá no `pubspec.yaml` e dale o comando.

Para atualizar as dependências para a versão mais recente permitidas pelas restrições de versão no `pubspec.yaml` rode

```console
flutter pub upgrade
```

Depois rode os testes e verifique se o fusca ainda funciona.

## Prototipação

- [Figma](https://www.figma.com/design/4vUcpYbgXym2421mm6m6wf/Untitled?node-id=0-1&t=gru349fF9GRNu7J4-1)
- [gerador de temas material3](https://material-foundation.github.io/material-theme-builder/)
