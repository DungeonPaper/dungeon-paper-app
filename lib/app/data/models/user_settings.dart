import 'dart:convert';

import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../themes/themes.dart';
import '../services/character_provider.dart';
import '../services/intl_service.dart';

class UserSettings with CharacterProviderMixin {
  final bool keepScreenAwake;
  final int defaultLightTheme;
  final int defaultDarkTheme;
  final Brightness? brightnessOverride;
  final Locale locale;

  UserSettings({
    this.keepScreenAwake = true,
    this.defaultLightTheme = AppThemes.parchment,
    this.defaultDarkTheme = AppThemes.dark,
    this.brightnessOverride,
    this.locale = Locales.en_US,
  });

  UserSettings copyWith({
    bool? keepScreenAwake,
    int? defaultLightTheme,
    int? defaultDarkTheme,
    Brightness? brightnessOverride,
    Locale? locale,
  }) =>
      UserSettings(
        keepScreenAwake: keepScreenAwake ?? this.keepScreenAwake,
        defaultLightTheme: defaultLightTheme ?? this.defaultLightTheme,
        defaultDarkTheme: defaultDarkTheme ?? this.defaultDarkTheme,
        brightnessOverride: brightnessOverride ?? this.brightnessOverride,
        locale: locale ?? this.locale,
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
        locale: json['locale'] != null
            ? Locale(json['locale'].first, json['locale'].last)
            : Locales.en_US,
      );

  Map<String, dynamic> toJson() => {
        'keepScreenAwake': keepScreenAwake,
        'defaultLightTheme': defaultLightTheme,
        'defaultDarkTheme': defaultDarkTheme,
        'brightnessOverride': brightnessOverride?.name,
        'locale': [locale.languageCode, locale.countryCode],
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
    // keep screen awake
    WakelockPlus.toggle(enable: keepScreenAwake);
    // theme
    if (maybeChar != null) {
      charProvider.switchToCharacterTheme(char);
    }
    final intl = IntlService.instance;
    // locale
    if (locale != intl.locale) {
      intl.changeLocale(locale);
    }
  }
}