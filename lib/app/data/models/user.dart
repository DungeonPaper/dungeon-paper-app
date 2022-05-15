import 'dart:convert';

class User {
  User({
    required this.username,
    required this.displayName,
    required this.email,
    required this.avatarUrl,
  });

  final String username;
  final String displayName;
  final String email;
  final String avatarUrl;

  User copyWith({
    String? username,
    String? displayName,
    String? email,
    String? avatarUrl,
  }) =>
      User(
        username: username ?? this.username,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        avatarUrl: avatarUrl ?? this.avatarUrl,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'],
        displayName: json['displayName'],
        email: json['email'],
        avatarUrl: json['avatarURL'],
      );

  factory User.guest() => User(
        displayName: 'Guest',
        username: 'guest',
        email: '',
        avatarUrl: '',
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'avatarURL': avatarUrl,
      };

  bool get isGuest => username == 'guest';
}
