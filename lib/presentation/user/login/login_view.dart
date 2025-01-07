import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/input_field/password_form_field.dart';
import 'package:my_kakeibo/presentation/user/login/login_controller.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginController(context),
      builder: (BuildContext context, Widget? child) {
        final controller = Provider.of<LoginController>(context);
        final intl = AppLocalizations.of(context)!;

        return Scaffold(
          key: const Key("login-view"),
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: intl.email,
                  ),
                ),
                const SizedBox(height: 8),
                PasswordFormField(
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
                    onPressed: controller.onLogin,
                    child: controller.loading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : Text(intl.login),
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
