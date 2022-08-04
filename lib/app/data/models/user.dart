import 'dart:convert';

import 'package:dungeon_paper/app/data/models/user_settings.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:flutter/material.dart';

class User {
  User({
    required this.username,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.settings,
    required this.flags,
  });

  final String username;
  final String displayName;
  final String email;
  final String photoUrl;
  final UserSettings settings;
  final Map<String, dynamic> flags;

  User copyWith({
    String? username,
    String? displayName,
    String? email,
    String? photoUrl,
    UserSettings? settings,
    Map<String, dynamic>? flags,
  }) =>
      User(
        username: username ?? this.username,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
        settings: settings ?? this.settings,
        flags: flags ?? this.flags,
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
        flags: json['flags'] ?? {},
      );

  factory User.guest() => User(
        displayName: 'Guest',
        username: 'guest',
        email: '',
        photoUrl: '',
        settings: UserSettings(),
        flags: {},
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'photoURL': photoUrl,
        'displayName': displayName,
        'settings': settings.toJson(),
        'flags': flags,
      };

  bool get isGuest => username == 'guest';
  bool get isLoggedIn => !isGuest;
  bool get isSu => flags['su'] == true;
  bool get isDm => flags['dm_tools_preview'] == true;

  Brightness get brightness => settings.brightnessOverride ?? getCurrentPlatformBrightness();

  void applySettings() => settings.apply();

  void applyDefaultTheme() {
    AppThemes.setTheme(getTheme());
  }

  int getTheme() =>
      brightness == Brightness.light ? settings.defaultLightTheme : settings.defaultDarkTheme;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          displayName == other.displayName &&
          email == other.email &&
          photoUrl == other.photoUrl &&
          settings == other.settings &&
          flags == other.flags;

  @override
  int get hashCode => Object.hashAll([username, displayName, email, photoUrl, settings, flags]);

  String get debugProperties =>
      'username: $username, displayName: $displayName, email: $email, photoUrl: $photoUrl, settings: $settings';

  @override
  String toString() => 'User($debugProperties)';
}
