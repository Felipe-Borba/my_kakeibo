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

  /// No final das contas não sei se vale muito a pena aquela lib de serialização o preço que eu pago escrevendo isso é baixo
  /// e usando o json_serializable eu só ganhei uma vantagem de serializar o enum automático
  /// mas deu xabu no timestamp pq eu não consegui usar a tipagem do firebase e salvou como string no formato iso8601 sem o timezone.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: '',
      // theme: json['theme'],
      notificationToken: json['notificationToken'],
      balance: json['balance'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
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

enum UserTheme {
  system,
  light,
  dark,
}
