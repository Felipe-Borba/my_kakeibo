import 'package:flutter/material.dart';
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
          return Text(
            context.intl.version(""),
            //TODO usar o design system
            style: TextStyle(color: Colors.grey[600]),
          );
        } else {
          final packageInfo = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.intl.version(packageInfo.version),
              //TODO usar o design system
              style: TextStyle(color: Colors.grey[600]),
            ),
          );
        }
      },
    );
  }
}
