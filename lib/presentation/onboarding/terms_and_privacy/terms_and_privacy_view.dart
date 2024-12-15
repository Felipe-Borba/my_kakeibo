import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';

class TermsAndPrivacyView extends StatelessWidget {
  const TermsAndPrivacyView({super.key});

  static const routeName = '/terms-and-privacy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: context.intl.terms_and_privacy_title),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              context.intl.terms_of_use_title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              context.intl.terms_of_use_description,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            Text(
              context.intl.privacy_policy_title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              context.intl.privacy_policy_description,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text(
                context.intl.back,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
