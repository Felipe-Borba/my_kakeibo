import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return TextCustom(
            context.intl.version(""),
            color: Colors.grey[600],
            theme: CustomTheme.bodySmall,
          );
        } else {
          final packageInfo = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextCustom(
              context.intl.version(packageInfo.version),
              theme: CustomTheme.bodySmall,
              color: Colors.grey[600],
            ),
          );
        }
      },
    );
  }
}
