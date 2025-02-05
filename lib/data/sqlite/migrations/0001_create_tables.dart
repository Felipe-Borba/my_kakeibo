// ignore_for_file: file_names

const createTables = '''
CREATE TABLE IF NOT EXISTS users(
  id TEXT PRIMARY KEY,
  name TEXT,
  theme INTEGER,
  notificationToken TEXT
);

CREATE TABLE IF NOT EXISTS expenses(
  id TEXT PRIMARY KEY,
  userId TEXT,
  amount REAL,
  date TEXT,
  description TEXT,
  categoryId TEXT,
  FOREIGN KEY(userId) REFERENCES users(id),
  FOREIGN KEY(categoryId) REFERENCES expense_categories(id)
);

CREATE TABLE IF NOT EXISTS income(
  id TEXT PRIMARY KEY,
  userId TEXT,
  amount REAL,
  date TEXT,
  description TEXT,
  sourceId TEXT,
  FOREIGN KEY(userId) REFERENCES users(id),
  FOREIGN KEY(sourceId) REFERENCES income_sources(id)
);

CREATE TABLE IF NOT EXISTS fixed_expenses(
  id TEXT PRIMARY KEY,
  userId TEXT,
  amount REAL,
  dueDate TEXT,
  description TEXT,
  categoryId TEXT,
  frequency INTEGER,
  remember INTEGER,
  FOREIGN KEY(userId) REFERENCES users(id),
  FOREIGN KEY(categoryId) REFERENCES expense_categories(id)
);

CREATE TABLE IF NOT EXISTS expense_categories(
  id TEXT PRIMARY KEY,
  name TEXT,
  icon INTEGER,
  color INTEGER
);

CREATE TABLE IF NOT EXISTS income_sources(
  id TEXT PRIMARY KEY,
  name TEXT,
  icon INTEGER,
  color INTEGER
);
''';
