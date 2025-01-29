import 'package:my_kakeibo/data/repository/income_source_repository.dart';
import 'package:my_kakeibo/data/repository/realm/model/models.dart';
import 'package:my_kakeibo/data/repository/realm/realm_config.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class IncomeSourceRealmRepository extends IncomeSourceRepository {
  final realm = RealmConfig().realm;

  @override
  Future<Result<IncomeSource>> insert(IncomeSource incomeSource) async {
    try {
      final model = toModel(incomeSource);
      realm.write(() => realm.add(model));
      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<IncomeSource>>> findAll() async {
    try {
      final results = realm.all<IncomeSourceModel>();
      final expenseCategories = results.map(toEntity).toList();
      return Success(expenseCategories);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<IncomeSource>> findOne(
    IncomeSource incomeSource,
  ) async {
    try {
      final model = realm.find<IncomeSourceModel>(incomeSource.id);

      if (model == null) {
        return Failure(CustomException.incomeSourceNotFound());
      }

      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<IncomeSource>> update(IncomeSource incomeSource) async {
    try {
      final model = realm.find<IncomeSourceModel>(incomeSource.id);

      if (model == null) {
        return Failure(CustomException.incomeSourceNotFound());
      }

      realm.write(() {
        model.name = incomeSource.name;
        model.color = incomeSource.color;
        model.icon = incomeSource.icon;
      });

      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> delete(IncomeSource incomeSource) async {
    try {
      final model = realm.find<IncomeSourceModel>(incomeSource.id);

      if (model == null) {
        return Failure(CustomException.incomeSourceNotFound());
      }

      realm.write(() => realm.delete(model));
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

  static IncomeSourceModel toModel(IncomeSource incomeSource) {
    final uuid = RealmConfig().uuid;
    return IncomeSourceModel(
      incomeSource.id ?? uuid.v4(),
      incomeSource.name,
      incomeSource.color.index,
      incomeSource.icon.index,
    );
  }
}
