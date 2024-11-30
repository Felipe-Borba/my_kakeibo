class User {
  String? id;
  String name;
  String email;
  String password;
  // UserTheme theme;
  double balance;
  String? notificationToken;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.notificationToken,
    // required this.theme,
    this.balance = 0.0,
  });

  decreaseBalance(double amount) {
    balance -= amount;
  }

  increaseBalance(double amount) {
    balance += amount;
  }
}

enum UserTheme {
  system,
  light,
  dark,
}
