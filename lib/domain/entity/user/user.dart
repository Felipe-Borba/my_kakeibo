import 'package:my_kakeibo/domain/entity/user/user_theme.dart';

class User {
  final int? id;
  final String name;
  final UserTheme theme;
  final String? notificationToken;

  User({
    this.id,
    required this.name,
    this.notificationToken,
    this.theme = UserTheme.light,
  });

  User copyWith({
    int? id,
    String? name,
    UserTheme? theme,
    String? notificationToken,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      theme: theme ?? this.theme,
      notificationToken: notificationToken ?? this.notificationToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'theme': theme.index,
      'notificationToken': notificationToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      theme: UserTheme.values[map['theme']],
      notificationToken: map['notificationToken'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, theme: $theme, notificationToken: $notificationToken}';
  }
}
