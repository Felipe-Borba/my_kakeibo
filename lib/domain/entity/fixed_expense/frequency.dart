enum Frequency {
  daily,
  weekly,
  monthly,
  annually,
}

extension FrequencyExtension on Frequency {
  String get description => toString().split('.').last;
}

extension FrequencyExtensionListExtension on List<Frequency> {
  Frequency getByDescription(String description) {
    return firstWhere((e) => e.description == description);
  }
}
