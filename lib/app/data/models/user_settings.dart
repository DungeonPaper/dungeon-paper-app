import 'dart:convert';

import 'package:dungeon_paper/app/themes/themes.dart';

class UserSettings {
  final bool keepScreenAwake;
  final int defaultLightTheme;
  final int defaultDarkTheme;

  UserSettings({
    this.keepScreenAwake = true,
    this.defaultLightTheme = AppThemes.parchment,
    this.defaultDarkTheme = AppThemes.dark,
  });

  UserSettings copyWith({
    bool? keepScreenAwake,
    int? defaultLightTheme,
    int? defaultDarkTheme,
  }) =>
      UserSettings(
        keepScreenAwake: keepScreenAwake ?? this.keepScreenAwake,
        defaultLightTheme: defaultLightTheme ?? this.defaultLightTheme,
        defaultDarkTheme: defaultDarkTheme ?? this.defaultDarkTheme,
      );

  factory UserSettings.fromRawJson(String str) => UserSettings.fromJson(json.decode(str));

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        keepScreenAwake: json['keepScreenAwake'],
        defaultLightTheme: json['defaultLightTheme'],
        defaultDarkTheme: json['defaultDarkTheme'],
      );

  Map<String, dynamic> toJson() => {
        'keepScreenAwake': keepScreenAwake,
        'defaultLightTheme': defaultLightTheme,
        'defaultDarkTheme': defaultDarkTheme,
      };
}
