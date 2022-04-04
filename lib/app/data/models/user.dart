import 'dart:convert';

class User {
  User({
    required this.displayName,
    required this.email,
    required this.avatarUrl,
    this.isGuest = false,
  });

  final String displayName;
  final String email;
  final String avatarUrl;
  final bool isGuest;

  User copyWith({
    String? displayName,
    String? email,
    String? avatarUrl,
  }) =>
      User(
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        avatarUrl: avatarUrl ?? this.avatarUrl,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        displayName: json['displayName'],
        email: json['email'],
        avatarUrl: json['avatarURL'],
      );

  factory User.guest() => User(displayName: 'Guest', email: '', isGuest: true, avatarUrl: '');

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'email': email,
        'avatarURL': avatarUrl,
      };
}
