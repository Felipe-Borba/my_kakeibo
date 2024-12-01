class User {
  String? id;
  String name;
  String email;
  String password;
  UserTheme theme;
  double balance;
  String? notificationToken;
  bool hasOnboarding;
  String? authId;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.notificationToken,
    this.theme = UserTheme.light,
    this.balance = 0.0,
    this.hasOnboarding = false,
    this.authId,
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
