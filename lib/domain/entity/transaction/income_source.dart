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

  IncomeSource copyWith({
    String? id,
    String? name,
    IconCustom? icon,
    ColorCustom? color,
  }) {
    return IncomeSource(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'income_source_id': id,
      'income_source_name': name,
      'income_source_icon': icon.index,
      'income_source_color': color.index,
    };
  }

  factory IncomeSource.fromMap(Map<String, dynamic> map) {
    return IncomeSource(
      id: map['income_source_id'],
      name: map['income_source_name'],
      icon: IconCustom.values[map['income_source_icon']],
      color: ColorCustom.values[map['income_source_color']],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IncomeSource && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'IncomeSource{id: $id, name: $name, icon: $icon, color: $color}';
  }
}
