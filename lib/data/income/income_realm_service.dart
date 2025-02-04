import 'package:my_kakeibo/data/income_source/income_source_realm_service.dart';
import 'package:my_kakeibo/data/realm/model/models.dart';
import 'package:my_kakeibo/data/realm/realm_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:realm/realm.dart';
import 'package:result_dart/result_dart.dart';

class IncomeRealmService {
  final RealmService _realmService;

  IncomeRealmService(this._realmService);

  Future<Result<Income>> insert(Income income) async {
    try {
      final model = _toModel(income);

      _realmService.realm.write(() {
        var source = _realmService.realm.find<IncomeSourceModel>(income.source.id);
        _realmService.realm.add(model..source = source);
      });

      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<Income>>> findAll() async {
    try {
      final results = _realmService.realm.all<IncomeModel>();
      final incomes = results.map(_toEntity).toList();
      return Success(incomes);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<Income>>> findByMonth({required DateTime month}) async {
    try {
      final start = DateTime(month.year, month.month, 1);
      final end = DateTime(month.year, month.month + 1, 0);

      final results = _realmService.realm
          .all<IncomeModel>()
          .query(r'date >= $0 AND date <= $1', [start, end]);
      final incomes = results.map(_toEntity).toList();

      return Success(incomes);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<Income>> update(Income income) async {
    try {
      final model = _realmService.realm.find<IncomeModel>(income.id);

      if (model == null) {
        return Failure(CustomException.incomeNotFound());
      }

      _realmService.realm.write(() {
        model.amount = income.amount;
        model.date = income.date;
        model.description = income.description;
        model.source = _realmService.realm.find<IncomeSourceModel>(
          income.source.id,
        );
      });

      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<void>> delete(Income income) async {
    try {
      final model = _realmService.realm.find<IncomeModel>(income.id);

      if (model == null) {
        return Failure(CustomException.incomeNotFound());
      }

      _realmService.realm.write(() => _realmService.realm.delete(model));
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
      source: IncomeSourceRealmService.toEntity(model.source!),
    );
  }

  IncomeModel _toModel(Income income) {
    return IncomeModel(
      income.id ?? RealmService.generateUuid(),
      income.amount,
      income.date,
      income.description,
    );
  }
}
