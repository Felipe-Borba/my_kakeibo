import 'package:my_kakeibo/data/repository/realm/model/user_model.dart';
import 'package:realm/realm.dart';

final config = Configuration.local(
  [
    UserModel.schema,
  ],
);

class RealmService {
  static Realm? _realm;

  static Realm get instance {
    _realm ??= Realm(config);
    return _realm!;
  }

  RealmService._();
}
