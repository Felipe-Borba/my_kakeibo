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
}

enum IconCustom {
  misc,
  dog,
  home,
  book,
  food,
  rent,
  doctor,
  entertainment,
}

enum ColorCustom {
  brown,
  blue,
  purple,
  orange,
  yellow,
}
