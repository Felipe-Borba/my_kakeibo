import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> init() async {
    final crashlytics = FirebaseCrashlytics.instance;

    if (kDebugMode) {
      await crashlytics.setCrashlyticsCollectionEnabled(false);
      final hasUnsentReports = await crashlytics.checkForUnsentReports();
      if (hasUnsentReports) {
        await crashlytics.deleteUnsentReports();
      }
      return;
    }

    await crashlytics.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = crashlytics.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      crashlytics.recordError(error, stack, fatal: true);
      return true;
    };
  }

  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  Future<void> logEvent(String name, Map<String, Object>? parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> logScreen(String name) async {
    await _analytics.logScreenView(screenName: name);
  }

  static bool get isCrashlyticsEnabled => !kDebugMode;
}
