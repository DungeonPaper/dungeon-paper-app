import 'dart:convert';

import 'package:dungeon_paper/app/data/models/user_settings.dart';

class User {
  User({
    required this.username,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.settings,
  });

  final String username;
  final String displayName;
  final String email;
  final String photoUrl;
  final UserSettings settings;

  User copyWith({
    String? username,
    String? displayName,
    String? email,
    String? photoUrl,
    UserSettings? settings,
  }) =>
      User(
        username: username ?? this.username,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
        settings: settings ?? this.settings,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  String? get documentPath => isLoggedIn ? 'Data/$email' : null;
  String? get fileStoragePath => isLoggedIn ? documentPath! + '/Uploads' : null;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'],
        displayName: json['displayName'],
        email: json['email'],
        photoUrl: json['photoURL'],
        settings:
            json['settings'] != null ? UserSettings.fromJson(json['settings']) : UserSettings(),
      );

  factory User.guest() => User(
        displayName: 'Guest',
        username: 'guest',
        email: '',
        photoUrl: '',
        settings: UserSettings(),
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'photoURL': photoUrl,
        'displayName': displayName,
        'settings': settings.toJson(),
      };

  bool get isGuest => username == 'guest';
  bool get isLoggedIn => !isGuest;
}
