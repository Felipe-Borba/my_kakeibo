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
      'id': id,
      'name': name,
      'icon': icon.index,
      'color': color.index,
    };
  }

  factory IncomeSource.fromMap(Map<String, dynamic> map) {
    return IncomeSource(
      id: map['id'],
      name: map['name'],
      icon: IconCustom.values[map['icon']],
      color: ColorCustom.values[map['color']],
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
