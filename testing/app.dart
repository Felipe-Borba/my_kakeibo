import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> createTestableWidget(
  WidgetTester tester, {
  required Widget child,
}) async {
  // Dispositivos de alta densidade (xxhdpi), como o iPhone X, 11, 12.
  tester.view.devicePixelRatio = 3.0;
  // Tamanho do iPhone X, 11, 12.
  await tester.binding.setSurfaceSize(const Size(414, 896));

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale("pt"),
      supportedLocales: const [
        Locale('en'),
        Locale('pt'),
      ],
      theme: ThemeData.light(),
      home: Scaffold(
        body: child,
      ),
    ),
  );
}
