import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class KeyboardAware extends StatelessWidget {
  final Widget child;

  const KeyboardAware({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: child,
    );
  }
}
