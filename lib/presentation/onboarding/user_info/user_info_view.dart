import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_string.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/onboarding/user_info/user_info_controller.dart';
import 'package:provider/provider.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserInfoController(context),
      builder: (context, child) {
        final viewModel = Provider.of<UserInfoController>(context);

        return ScaffoldCustom(
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Center(
              child: Form(
                key: viewModel.formKey,
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
                    InputFormString(
                      key: const Key("name"),
                      onChanged: (value) => viewModel.name = value,
                      validator: viewModel.validateName,
                      labelText: context.intl.name,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        key: const Key("create-account"),
                        onPressed: viewModel.onSubmit,
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
