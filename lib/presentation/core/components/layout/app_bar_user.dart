import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';

class AppBarUser extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarUser({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/launcher/icon.png',
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    context.intl.appTitle,
                    theme: CustomTheme.titleMedium,
                    prominent: true,
                  ),
                  TextCustom(
                    context.intl.subtitle,
                    theme: CustomTheme.bodyMedium,
                  ),
                ],
              ),
              const Expanded(child: SizedBox(width: 10)),
              const SizedBox(width: 30),
              // IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
