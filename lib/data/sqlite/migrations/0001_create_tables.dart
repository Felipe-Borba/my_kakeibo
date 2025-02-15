// ignore_for_file: file_names

const createUsersTable = '''
CREATE TABLE IF NOT EXISTS users(
  user_id TEXT PRIMARY KEY,
  user_name TEXT,
  user_theme INTEGER,
  user_notification_token TEXT
);
''';

const createExpensesTable = '''
CREATE TABLE IF NOT EXISTS expenses(
  expense_id TEXT PRIMARY KEY,
  expense_amount REAL,
  expense_date TEXT,
  expense_description TEXT,
  expense_category_id TEXT,
  fixed_expense_id TEXT,
  user_id TEXT,
  FOREIGN KEY(fixed_expense_id) REFERENCES fixed_expenses(fixed_expense_id),
  FOREIGN KEY(expense_category_id) REFERENCES expense_categories(expense_category_id),
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
''';

const createIncomeTable = '''
CREATE TABLE IF NOT EXISTS income(
  income_id TEXT PRIMARY KEY,
  income_amount REAL,
  income_date TEXT,
  income_description TEXT,
  income_source_id TEXT,
  user_id TEXT,
  FOREIGN KEY(income_source_id) REFERENCES income_sources(income_source_id),
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
''';

const createFixedExpensesTable = '''
CREATE TABLE IF NOT EXISTS fixed_expenses(
  fixed_expense_id TEXT PRIMARY KEY,
  fixed_expense_amount REAL,
  fixed_expense_due_date TEXT,
  fixed_expense_description TEXT,
  fixed_expense_frequency INTEGER,
  fixed_expense_remember INTEGER,
  expense_category_id TEXT,
  user_id TEXT,
  FOREIGN KEY(expense_category_id) REFERENCES expense_categories(expense_category_id),
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
''';

const createExpenseCategoriesTable = '''
CREATE TABLE IF NOT EXISTS expense_categories(
  expense_category_id TEXT PRIMARY KEY,
  expense_category_name TEXT,
  expense_category_icon INTEGER,
  expense_category_color INTEGER
);
''';

const createIncomeSourcesTable = '''
CREATE TABLE IF NOT EXISTS income_sources(
  income_source_id TEXT PRIMARY KEY,
  income_source_name TEXT,
  income_source_icon INTEGER,
  income_source_color INTEGER
);
''';
