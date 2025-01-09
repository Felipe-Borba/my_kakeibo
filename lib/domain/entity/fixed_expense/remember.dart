enum Remember {
  no,
  weekBefore,
  dayBefore,
  atDueDate,
}

extension RememberExtension on Remember {
  String get description => toString().split('.').last;
}

extension RememberExtensionListExtension on List<Remember> {
  Remember getByDescription(String description) {
    return firstWhere((e) => e.description == description);
  }
}
