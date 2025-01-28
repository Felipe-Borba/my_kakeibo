# MyKakeibo

O seu app de finanças pessoais

## For Developers

Recomendo usar o vscode pq tem uns plugin legais que ajudam a desenvolver, caso queira usar outra ide fique a vontade mas o meu suporte fica limitado

### Plugins recomendados do VSCode

- Dart
- Flutter
- Flutter intl

### Versão do flutter

Esse app tem configurado o `FVM` para gerenciar a versão do dart e do flutter, caso não tenha instalado:

1. Instale o FVM globalmente usando o pub:

No Mac ou Linux.  
Install.sh

```sh
curl -fsSL https://fvm.app/install.sh | bash
```

ou Homebrew

```sh
brew tap leoafarias/fvm
brew install fvm
```

No Windows

```sh
choco install fvm
```

2. Navegue até o diretório do projeto e use o FVM para instalar a versão correta do Flutter:

```sh
fvm install
```

3. Use a versão do Flutter gerenciada pelo FVM:

```sh
fvm use
```

### Rodar o projeto localmente

Para rodar o projeto localmente, siga os passos abaixo:

1. Clone o repositório:

```sh
git clone https://github.com/seu-usuario/my_kakeibo.git
cd my_kakeibo
```

2. Certifique-se de que todas as dependências estão instaladas:

```sh
fvm flutter pub get
```

3. Inicie o aplicativo:

```sh
fvm flutter run
```

Se estiver usando o VSCode, você pode usar a interface gráfica para iniciar o aplicativo clicando no ícone de "Run" na barra lateral ou pressionando `F5`.
