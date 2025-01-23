// TODO depois no futuro seria legal deixar o usuário criar isso
enum IncomeSource {
  salary,
}

extension IncomeSourceHelper on IncomeSource {
  String get description => toString().split('.').last;
}

extension IncomeSourceListExtension on List<IncomeSource> {
  IncomeSource getByDescription(String description) {
    return firstWhere((e) => e.description == description);
  }
}
