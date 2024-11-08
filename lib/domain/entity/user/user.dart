class User {
  String? id;
  String name;
  String email;
  String password;
  // UserTheme theme;
  double balance;

  //TODO sera que rola colocar uma lista de expense aqui?
  // como se fosse um relacionamento no spring? sei que isso não tem nada a ver mas é um usuário que tem a despesa ou receita....

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    // required this.theme,
    this.balance = 0.0,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        // TODO password should no be saved as plain text on satabase
        password = json['password'],
        // theme = json['theme'],
        balance = json['balance'].toDouble();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      // 'theme': theme,
      'balance': balance,
    };
  }

  decreaseBalance(double amount) {
    balance -= amount;
  }

  increaseBalance(double amount) {
    balance += amount;
  }
}
