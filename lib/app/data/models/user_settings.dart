import 'dart:convert';

import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:flutter/material.dart';

class UserSettings {
  final bool keepScreenAwake;
  final int defaultLightTheme;
  final int defaultDarkTheme;
  final Brightness? brightnessOverride;

  UserSettings({
    this.keepScreenAwake = true,
    this.defaultLightTheme = AppThemes.parchment,
    this.defaultDarkTheme = AppThemes.dark,
    this.brightnessOverride,
  });

  UserSettings copyWith({
    bool? keepScreenAwake,
    int? defaultLightTheme,
    int? defaultDarkTheme,
    Brightness? brightnessOverride,
  }) =>
      UserSettings(
        keepScreenAwake: keepScreenAwake ?? this.keepScreenAwake,
        defaultLightTheme: defaultLightTheme ?? this.defaultLightTheme,
        defaultDarkTheme: defaultDarkTheme ?? this.defaultDarkTheme,
        brightnessOverride: brightnessOverride ?? this.brightnessOverride,
      );

  factory UserSettings.fromRawJson(String str) => UserSettings.fromJson(json.decode(str));

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        keepScreenAwake: json['keepScreenAwake'],
        defaultLightTheme: json['defaultLightTheme'],
        defaultDarkTheme: json['defaultDarkTheme'],
        brightnessOverride: Brightness.values.cast<Brightness?>().firstWhere(
              (element) => element!.name == json['brightnessOverride'],
              orElse: () => null,
            ),
      );

  Map<String, dynamic> toJson() => {
        'keepScreenAwake': keepScreenAwake,
        'defaultLightTheme': defaultLightTheme,
        'defaultDarkTheme': defaultDarkTheme,
        'brightnessOverride': brightnessOverride?.name,
      };
}
