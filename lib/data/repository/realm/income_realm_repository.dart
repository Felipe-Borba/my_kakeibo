import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/realm/model/income_model.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:realm/realm.dart' hide Uuid;
import 'package:uuid/uuid.dart';

class IncomeRealmRepository extends IncomeRepository {
  final Realm realm;
  final Uuid uuid; 

  IncomeRealmRepository(this.realm, this.uuid);

  @override
  Future<(Income?, AppError)> insert(Income income) async {
    try {
      final model = _toModel(income);
      realm.write(() => realm.add(model));
      return (_toEntity(model), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<Income>, AppError)> findAll() async {
    try {
      final results = realm.all<IncomeModel>();
      final incomes = results.map(_toEntity).toList();
      return (incomes, Empty());
    } catch (e) {
      return (List<Income>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(List<Income>, AppError)> findByMonth(
      {required DateTime month}) async {
    try {
      final start = DateTime(month.year, month.month, 1);
      final end = DateTime(month.year, month.month + 1, 0);

      final results = realm
          .all<IncomeModel>()
          .query(r'date >= $0 AND date <= $1', [start, end]);
      final incomes = results.map(_toEntity).toList();

      return (incomes, Empty());
    } catch (e) {
      return (List<Income>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(Income?, AppError)> update(Income income) async {
    try {
      final model = realm.find<IncomeModel>(income.id);

      if (model == null) {
        return (null, Failure("Income not found"));
      }

      realm.write(() {
        model.amount = income.amount;
        model.date = income.date;
        model.description = income.description;
        model.source = income.source;
      });

      return (_toEntity(model), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Null, AppError)> delete(Income income) async {
    try {
      final model = realm.find<IncomeModel>(income.id);

      if (model == null) {
        return (null, Failure("Income not found"));
      }

      realm.write(() => realm.delete(model));
      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  Income _toEntity(IncomeModel model) {
    return Income(
      id: model.id,
      amount: model.amount,
      date: model.date,
      description: model.description,
      source: model.source,
    );
  }

  IncomeModel _toModel(Income income) {
    var model = IncomeModel(
      income.id ?? uuid.v4(),
      income.amount,
      income.date,
      income.description,
      '',
    );
    model.source = income.source;
    return model;
  }
}
