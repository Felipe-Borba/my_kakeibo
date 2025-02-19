import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  pushReplacementScreen(Widget widget) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: widget.runtimeType.toString()),
      ),
    );
  }

  pushScreen(Widget widget) {
    return Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: widget.runtimeType.toString()),
      ),
    );
  }

  popScreen<T extends Object?>([T? result]) {
    return Navigator.of(this).pop(result);
  }

  pushAndRemoveAllScreen(Widget widget) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: widget.runtimeType.toString()),
      ),
      (route) => false,
    );
  }
}
