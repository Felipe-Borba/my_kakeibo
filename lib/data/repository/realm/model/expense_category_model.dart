part of 'models.dart';

@RealmModel()
class _ExpenseCategoryModel {
  @PrimaryKey()
  late String id;

  late String name;

  @MapTo('color')
  late int _colorValue;
  ColorCustom get color => ColorCustom.values[_colorValue];
  set color(ColorCustom color) => _colorValue = color.index;

  @MapTo('icon')
  late int _iconValue;
  IconCustom get icon => IconCustom.values[_iconValue];
  set icon(IconCustom icon) => _iconValue = icon.index;

  late List<_ExpenseModel> expenses;

  late List<_FixedExpenseModel> fixedExpenses;
}
