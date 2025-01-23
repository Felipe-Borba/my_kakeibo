import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/onboarding/hello/hello_controller.dart';
import 'package:provider/provider.dart';

class HelloView extends StatelessWidget {
  const HelloView({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HelloController(context),
      builder: (context, child) {
        final viewModel = Provider.of<HelloController>(context);

        return ScaffoldCustom(
          body: Center(
            child: AnimatedOpacity(
              opacity: viewModel.opacity,
              duration: const Duration(seconds: 2),
              child: Text(
                // 'Bem-vindo',
                context.intl.hello(name),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
