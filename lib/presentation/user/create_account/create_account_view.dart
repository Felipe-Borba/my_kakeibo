import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/user/create_account/create_account_controller.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  static const routeName = '/create-account';

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<CreateAccountController>();
    final intl = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          appBar: const AppBarCustom(title: "Create account"),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: controller.email,
                    decoration: InputDecoration(
                      labelText: "email",
                      errorText: controller.emailError,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.password,
                    decoration: InputDecoration(
                      labelText: "password",
                      errorText: controller.passwordError,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.name,
                    decoration: InputDecoration(
                      labelText: "name",
                      errorText: controller.nameError,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: controller.onClickCreateAccount,
                      child: const Text("Create account"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
