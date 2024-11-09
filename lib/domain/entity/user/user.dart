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

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        password = '',
        // theme = json['theme'],
        notificationToken = json['notificationToken'],
        balance = json['balance'].toDouble();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': '',
      // 'theme': theme,
      'balance': balance,
      'notificationToken': notificationToken,
    };
  }

  decreaseBalance(double amount) {
    balance -= amount;
  }

  increaseBalance(double amount) {
    balance += amount;
  }
}
