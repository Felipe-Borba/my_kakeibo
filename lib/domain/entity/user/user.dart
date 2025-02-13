import 'package:my_kakeibo/domain/entity/user/user_theme.dart';

class User {
  final String? id;
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
    String? id,
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
      'user_id': id,
      'user_name': name,
      'user_theme': theme.index,
      'user_notification_token': notificationToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user_id'],
      name: map['user_name'],
      theme: UserTheme.values[map['user_theme']],
      notificationToken: map['user_notification_token'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, theme: $theme, notificationToken: $notificationToken}';
  }
}
