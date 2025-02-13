import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';

class ExpenseCategory {
  String? id;
  String name;
  IconCustom icon;
  ColorCustom color;

  ExpenseCategory({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  ExpenseCategory copyWith({
    String? id,
    String? name,
    IconCustom? icon,
    ColorCustom? color,
  }) {
    return ExpenseCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expense_category_id': id,
      'expense_category_name': name,
      'expense_category_icon': icon.index,
      'expense_category_color': color.index,
    };
  }

  factory ExpenseCategory.fromMap(Map<String, dynamic> map) {
    return ExpenseCategory(
      id: map['expense_category_id'],
      name: map['expense_category_name'],
      icon: IconCustom.values[map['expense_category_icon']],
      color: ColorCustom.values[map['expense_category_color']],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseCategory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ExpenseCategory(id: $id, name: $name, icon: $icon, color: $color)';
  }
}
