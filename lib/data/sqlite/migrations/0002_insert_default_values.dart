// ignore_for_file: file_names

const insertDefaultValues = '''
INSERT INTO expense_categories (id, name, icon, color) VALUES
  ('ccda5ebb-10ed-4a36-af1a-ed975161d1d7', 'Book', 3, 0), -- IconCustom.book, ColorCustom.brown
  ('20cc2790-fdcf-40ef-a3e8-ae7027672f05', 'Doctor', 6, 3), -- IconCustom.doctor, ColorCustom.orange
  ('ea407b53-251a-4684-945b-21d31acd736d', 'Dog', 1, 2), -- IconCustom.dog, ColorCustom.purple
  ('da328c46-1680-4fcc-bd8d-ee3b69310b12', 'Food', 4, 4); -- IconCustom.food, ColorCustom.yellow

INSERT INTO income_sources (id, name, icon, color) VALUES
  ('3a9c9b5b-5c9c-4ecb-8bfb-d666bb9b110c', 'Salary', 8, 5), -- IconCustom.salary, ColorCustom.green
  ('3fc78710-0d2a-4b00-9b06-c5e9c25ef86e', 'Misc', 0, 6); -- IconCustom.misc, ColorCustom.grey
''';
