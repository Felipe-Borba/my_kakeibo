import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_kakeibo/app_view_model.dart';
import 'package:my_kakeibo/presentation/core/app_theme.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/user_theme_extension.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final theme = getMaterialTheme(context);

    return ChangeNotifierProvider(
      create: (context) => AppViewModel(context.read(), context.read()),
      builder: (context, child) {
        final viewModel = Provider.of<AppViewModel>(context);

        return MaterialApp(
          restorationScopeId: 'myKakeibo',
          debugShowCheckedModeBanner: false,
          //
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // locale: const Locale("pt"),
          supportedLocales: const [
            Locale('en'),
            Locale('pt'),
          ],
          //
          onGenerateTitle: (context) => context.intl.appTitle,
          //
          themeMode: viewModel.userTheme.toThemeMode(),
          theme: theme.light(),
          darkTheme: theme.dark(),
          highContrastTheme: theme.lightHighContrast(),
          highContrastDarkTheme: theme.darkHighContrast(),
          //
          home: viewModel.initialRoute,
          navigatorObservers: [
            viewModel.getAnalyticsObserver(),
          ],
        );
      },
    );
  }
}
