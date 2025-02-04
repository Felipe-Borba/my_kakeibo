import 'package:my_kakeibo/data/realm/model/models.dart';
import 'package:my_kakeibo/data/realm/realm_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class IncomeSourceRealmService {
  final RealmService _realmService;

  IncomeSourceRealmService(this._realmService);

  Future<Result<IncomeSource>> insert(IncomeSource incomeSource) async {
    try {
      final model = toModel(incomeSource);
      _realmService.realm.write(() => _realmService.realm.add(model));
      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<IncomeSource>>> findAll() async {
    try {
      final results = _realmService.realm.all<IncomeSourceModel>();
      final expenseCategories = results.map(toEntity).toList();
      return Success(expenseCategories);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<IncomeSource>> findOne(
    IncomeSource incomeSource,
  ) async {
    try {
      final model = _realmService.realm.find<IncomeSourceModel>(incomeSource.id);

      if (model == null) {
        return Failure(CustomException.incomeSourceNotFound());
      }

      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<IncomeSource>> update(IncomeSource incomeSource) async {
    try {
      final model = _realmService.realm.find<IncomeSourceModel>(incomeSource.id);

      if (model == null) {
        return Failure(CustomException.incomeSourceNotFound());
      }

      _realmService.realm.write(() {
        model.name = incomeSource.name;
        model.color = incomeSource.color;
        model.icon = incomeSource.icon;
      });

      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<void>> delete(IncomeSource incomeSource) async {
    try {
      final model = _realmService.realm.find<IncomeSourceModel>(incomeSource.id);

      if (model == null) {
        return Failure(CustomException.incomeSourceNotFound());
      }

      _realmService.realm.write(() => _realmService.realm.delete(model));
      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  static IncomeSource toEntity(IncomeSourceModel model) {
    return IncomeSource(
      id: model.id,
      name: model.name,
      color: model.color,
      icon: model.icon,
    );
  }

   IncomeSourceModel toModel(IncomeSource incomeSource) {
    return IncomeSourceModel(
      incomeSource.id ?? RealmService.generateUuid(),
      incomeSource.name,
      incomeSource.color.index,
      incomeSource.icon.index,
    );
  }
}
