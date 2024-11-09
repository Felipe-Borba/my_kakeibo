import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/input_field/password_form_field.dart';
import 'package:my_kakeibo/presentation/user/create_account/create_account_controller.dart';
import 'package:provider/provider.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  static const routeName = '/create-account';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateAccountController(context),
      builder: (BuildContext context, Widget? child) {
        final controller = Provider.of<CreateAccountController>(context);

        return Scaffold(
          appBar: const AppBarCustom(title: "Create account"),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      key: const Key("email"),
                      decoration: const InputDecoration(
                        labelText: "email",
                      ),
                      onChanged: controller.setEmail,
                      validator: controller.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 8),
                    PasswordFormField(
                      key: const Key("password"),
                      decoration: const InputDecoration(
                        labelText: "password",
                      ),
                      onChanged: controller.setPassword,
                      validator: controller.validatePassword,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      key: const Key("name"),
                      decoration: const InputDecoration(
                        labelText: "name",
                      ),
                      onChanged: controller.setName,
                      validator: controller.validateName,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        key: const Key("create-account"),
                        onPressed: controller.onClickCreateAccount,
                        child: const Text("Create account"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
