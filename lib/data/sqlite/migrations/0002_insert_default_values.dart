// ignore_for_file: file_names

const insertDefaultValues = '''
INSERT INTO expense_categories (id, name, icon, color) VALUES
  ('1', 'Book', 3, 0), -- IconCustom.book, ColorCustom.brown
  ('2', 'Doctor', 6, 3), -- IconCustom.doctor, ColorCustom.orange
  ('3', 'Dog', 1, 2), -- IconCustom.dog, ColorCustom.purple
  ('4', 'Food', 4, 4); -- IconCustom.food, ColorCustom.yellow

INSERT INTO income_sources (id, name, icon, color) VALUES
  ('1', 'Salary', 8, 5), -- IconCustom.salary, ColorCustom.green
  ('2', 'Misc', 0, 6); -- IconCustom.misc, ColorCustom.grey
''';
