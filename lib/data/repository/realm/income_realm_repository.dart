import 'package:my_kakeibo/data/repository/income_repository.dart';
import 'package:my_kakeibo/data/repository/realm/income_source_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/model/models.dart';
import 'package:my_kakeibo/data/repository/realm/realm_config.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:realm/realm.dart';
import 'package:result_dart/result_dart.dart';

class IncomeRealmRepository extends IncomeRepository {
  final realm = RealmConfig().realm;
  final uuid = RealmConfig().uuid;

  @override
  Future<Result<Income>> insert(Income income) async {
    try {
      final model = _toModel(income);

      realm.write(() {
        var source = realm.find<IncomeSourceModel>(income.source.id);
        realm.add(model..source = source);
      });

      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Income>>> findAll() async {
    try {
      final results = realm.all<IncomeModel>();
      final incomes = results.map(_toEntity).toList();
      return Success(incomes);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Income>>> findByMonth({required DateTime month}) async {
    try {
      final start = DateTime(month.year, month.month, 1);
      final end = DateTime(month.year, month.month + 1, 0);

      final results = realm
          .all<IncomeModel>()
          .query(r'date >= $0 AND date <= $1', [start, end]);
      final incomes = results.map(_toEntity).toList();

      return Success(incomes);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<Income>> update(Income income) async {
    try {
      final model = realm.find<IncomeModel>(income.id);

      if (model == null) {
        return Failure(Exception("Income not found"));
      }

      realm.write(() {
        model.amount = income.amount;
        model.date = income.date;
        model.description = income.description;
        model.source = realm.find<IncomeSourceModel>(
          income.source.id,
        );
      });

      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> delete(Income income) async {
    try {
      final model = realm.find<IncomeModel>(income.id);

      if (model == null) {
        return Failure(Exception("Income not found"));
      }

      realm.write(() => realm.delete(model));
      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Income _toEntity(IncomeModel model) {
    return Income(
      id: model.id,
      amount: model.amount,
      date: model.date,
      description: model.description,
      source: IncomeSourceRealmRepository.toEntity(model.source!),
    );
  }

  IncomeModel _toModel(Income income) {
    return IncomeModel(
      income.id ?? uuid.v4(),
      income.amount,
      income.date,
      income.description,
    );
  }
}
