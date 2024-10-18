import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_controller.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<WelcomeController>();

    return Scaffold(
      // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1641979319851-a8ed7ed67314?w=1280&h=720',
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
              child: Text('Welcome to our Finance App!'),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: Text('Manage your finances with ease.'),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Text('Track your expenses, set budgets, and save money.'),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: ElevatedButton(
                onPressed: controller.onContinue,
                child: const Text("Get Started"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
