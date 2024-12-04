import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';

class HelloController with ChangeNotifier {
  double opacity = 0.0;

  HelloController() {
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    opacity = 1.0;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Modular.to.navigate(DashboardView.routeName);
    });
  }
}
