import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:my_kakeibo/data/analytics_service.dart';
import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/presentation/onboarding/welcome/welcome_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';
import 'package:result_dart/result_dart.dart';

class AppViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final AnalyticsService _analyticsService;

  UserTheme userTheme = UserTheme.system;
  Widget initialRoute = const WelcomeView();

  late final StreamSubscription _userSubscription;

  AppViewModel(this._userRepository, this._analyticsService) {
    _userSubscription = _userRepository.userStream.listen((user) {
      userTheme = user.theme;
      notifyListeners();
    });

    _userRepository.getUser().onSuccess((user) {
      userTheme = user.theme;
      initialRoute = const DashboardView();
      notifyListeners();
    }).onFailure((failure) {
      initialRoute = const WelcomeView();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  getAnalyticsObserver() {
    return _analyticsService.getAnalyticsObserver();
  }
}
