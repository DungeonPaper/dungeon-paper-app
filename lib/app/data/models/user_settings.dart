import 'dart:convert';

import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../themes/themes.dart';
import '../services/character_provider.dart';

class UserSettings with CharacterProviderMixin {
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

  factory UserSettings.fromRawJson(String str) =>
      UserSettings.fromJson(json.decode(str));

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        keepScreenAwake: json['keepScreenAwake'],
        defaultLightTheme: json['defaultLightTheme'],
        defaultDarkTheme: json['defaultDarkTheme'],
        brightnessOverride:
            Brightness.values.cast<Brightness?>().firstWhereOrNull(
                  (element) => element!.name == json['brightnessOverride'],
                ),
      );

  Map<String, dynamic> toJson() => {
        'keepScreenAwake': keepScreenAwake,
        'defaultLightTheme': defaultLightTheme,
        'defaultDarkTheme': defaultDarkTheme,
        'brightnessOverride': brightnessOverride?.name,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettings &&
          runtimeType == other.runtimeType &&
          keepScreenAwake == other.keepScreenAwake &&
          defaultLightTheme == other.defaultLightTheme &&
          defaultDarkTheme == other.defaultDarkTheme &&
          brightnessOverride == other.brightnessOverride;

  @override
  int get hashCode => Object.hashAll([
        keepScreenAwake,
        defaultLightTheme,
        defaultDarkTheme,
        brightnessOverride
      ]);

  String get debugProperties =>
      'keepScreenAwake: $keepScreenAwake, defaultLightTheme: $defaultLightTheme, defaultDarkTheme: $defaultDarkTheme, brightnessOverride: $brightnessOverride';

  @override
  String toString() => 'UserSettings($debugProperties)';

  void apply() {
    WakelockPlus.toggle(enable: keepScreenAwake);

    if (maybeChar != null) {
      charProvider.switchToCharacterTheme(char);
    } else {}
  }
}
