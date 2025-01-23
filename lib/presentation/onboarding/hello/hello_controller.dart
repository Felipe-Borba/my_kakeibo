import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';

class HelloController with ChangeNotifier {
  final BuildContext _context;
  double opacity = 0.0;

  HelloController(this._context) {
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    opacity = 1.0;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!_context.mounted) return;
    _context.pushAndRemoveAllScreen(const DashboardView());
  }
}
