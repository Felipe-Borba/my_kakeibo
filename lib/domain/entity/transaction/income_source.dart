import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';

class IncomeSource {
  String? id;
  String name;
  IconCustom icon;
  ColorCustom color;

  IncomeSource({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}
