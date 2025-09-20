import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/screen_extension.dart';

class BodyFormLayout extends StatelessWidget {
  final List<Widget> formChildren;
  final List<Widget> bottomChildren;
  final String? title;
  final String? description;
  final double paddingTop;

  const BodyFormLayout({
    super.key,
    required this.formChildren,
    required this.bottomChildren,
    this.title,
    this.description,
    this.paddingTop = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: context.screenPercentage(
                      paddingTop,
                      direction: ScreenDirection.height,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          TextCustom(
                            title!,
                            theme: CustomTheme.headlineSmall,
                            prominent: true,
                          ),
                        if (description != null)
                          TextCustom(
                            description!,
                            theme: CustomTheme.bodySmall,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                      ],
                    ),
                  ),
                  ...formChildren,
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: bottomChildren,
            ),
          ),
        ),
      ],
    );
  }
}
