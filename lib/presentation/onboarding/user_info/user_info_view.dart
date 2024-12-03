import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/onboarding/user_info/user_info_controller.dart';
import 'package:provider/provider.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  static const routeName = '/onboarding/userInfo';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserInfoController(context),
      builder: (context, child) {
        final controller = Provider.of<UserInfoController>(context);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Center(
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      context.intl.firstThingsFirst,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                     Text(
                      context.intl.yourName,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      key: const Key("name"),
                      onChanged: (value) => controller.name = value,
                      validator: controller.validateName,
                      decoration: InputDecoration(
                        labelText: context.intl.name,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    //TODO cria um layoutzinho pra deixar os botões ne próximo tudo na mesma altura
                    Center(
                      child: ElevatedButton(
                        key: const Key("create-account"),
                        onPressed: controller.onSubmit,
                        child: Text(context.intl.next),
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
