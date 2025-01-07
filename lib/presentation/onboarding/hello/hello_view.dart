import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
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
        final controller = Provider.of<HelloController>(context);

        return Scaffold(
          body: Center(
            child: AnimatedOpacity(
              opacity: controller.opacity,
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
