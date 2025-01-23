import 'package:flutter/material.dart';
import 'package:my_kakeibo/dependency_manager.dart';
import 'package:provider/provider.dart';

extension DependencyManagerExtension on BuildContext {
  DependencyManager get dependencyManager => Provider.of(this, listen: false);
}
