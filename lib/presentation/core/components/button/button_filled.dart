import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';

class ButtonFilled extends StatelessWidget {
  const ButtonFilled({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.width,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : TextCustom(
                text,
                theme: CustomTheme.titleMedium,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
      ),
    );
  }
}
