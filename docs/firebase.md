# Firebase

## Add firebase to my flutter app

- [tutorial](https://firebase.google.com/docs/flutter/setup?platform=android)

## App Check

tive que linkar o google play console com o projeto do google cloud que o firebase criou
ai depois vai lá no play console catar a `Certificado da chave de assinatura do app` para copiar a `Impressão digital para certificação SHA-256` e colar lá no cadastro do app check do firebase.
Tem tb uma libzinha que tem que instalar no flutter.

## Analytics

Pelo que eu entendi é um lib em flutter que integra com o firebase que o firebase integra junto com o google analytics e no firebase eles só chamam de `Analytics Dashboard`.

Existe um role de que normalmente os eventos são mandados de hora em hora para economizar bataria e internet, para ver instantaneamente em modo dev

```console
adb shell setprop debug.firebase.analytics.app com.borba.felipe.my_kakeibo
```

Para desativar esse modo dev

```console
adb shell setprop debug.firebase.analytics.app .none.
```

## Crashlytics [link](https://firebase.google.com/docs/crashlytics/get-started?platform=flutter)
Setup bem simples praticamente só instalar a lib pq o analytics e o flutter já estavam instalados
