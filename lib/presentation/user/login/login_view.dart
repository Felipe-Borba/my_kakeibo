import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/user/login/login_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<LoginController>();
    final intl = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          appBar: AppBarCustom(
            title: intl.welcome,
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  key: const Key("email"),
                  onChanged: (value) => controller.email = value,
                  decoration: InputDecoration(
                    labelText: intl.email,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  key: const Key("password"),
                  onChanged: (value) => controller.password = value,
                  decoration: InputDecoration(
                    labelText: intl.password,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    key: const Key("login"),
                    onPressed: () => controller.onLogin(context),
                    child: Text(intl.login),
                  ),
                ),
                TextButton(
                  key: const Key("create-account"),
                  onPressed: controller.onClickCreateAccount,
                  child: Text(intl.createAccount),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
