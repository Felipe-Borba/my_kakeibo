import 'dart:async';

import 'package:my_kakeibo/data/analytics_service.dart';
import 'package:my_kakeibo/data/user/user_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:result_dart/result_dart.dart';

class UserRepository {
  late final UserServiceSqlite _userService;
  final AnalyticsService _analyticsService;

  UserRepository(this._userService, this._analyticsService);

  final _streamController = StreamController<User>.broadcast();
  Stream<User> get userStream => _streamController.stream;

  AsyncResult<User> save(User user) {
    if (user.id != null) {
      return _userService.update(user).onSuccess((success) {
        _streamController.add(success);
      });
    } else {
      return _userService.insert(user).onSuccess((success) {
        _streamController.add(success);
      });
    }
  }

  AsyncResult<User> getUser() async {
    return await _userService.getSelf();
  }

  getAnalyticsObserver() {
    return _analyticsService.getAnalyticsObserver();
  }

  logScreen(String name) {
    _analyticsService.logScreen(name);
  }
}
