import 'dart:convert';

import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'expansion_states.dart';

enum SettingName {
  keepScreenOn,
  expansionStates,
}

class PrefsSettings {
  bool keepScreenOn;
  ExpansionStates expansionStates;

  PrefsSettings({
    this.keepScreenOn = true,
    ExpansionStates expansionStates,
  }) : expansionStates = expansionStates ?? ExpansionStates();

  static final _SETTING_NAME_KEYS = <SettingName, String>{
    SettingName.keepScreenOn: 'KeepScreenOn',
    SettingName.expansionStates: 'ExpansionStates',
  };

  static final _SETTING_NAME_TYPES = <SettingName, Type>{
    SettingName.keepScreenOn: bool,
    SettingName.expansionStates: String,
  };

  factory PrefsSettings.loadFromPrefs(SharedPreferences prefs) {
    return PrefsSettings(
      keepScreenOn: getFromPrefs(prefs, SettingName.keepScreenOn) ?? true,
      expansionStates: ExpansionStates.fromPrefsString(
          getFromPrefs(prefs, SettingName.expansionStates)),
    );
  }

  static Type getTypeByName(SettingName name) => _SETTING_NAME_TYPES[name];
  static String getPrefName(SettingName name) => _SETTING_NAME_KEYS[name];

  static void setToPrefs<T>(
    SharedPreferences prefs,
    SettingName name,
    T value,
  ) {
    var _type = getTypeByName(name);
    var _name = getPrefName(name);

    switch (_type) {
      case int:
        prefs.setInt(_name, value as int);
        return;
      case double:
        prefs.setDouble(_name, value as double);
        return;
      case String:
        prefs.setString(_name, value as String);
        return;
      case bool:
        prefs.setBool(_name, value as bool);
        return;
      default:
        prefs.setString(_name, json.encode(value));
        return;
    }
  }

  static T getFromPrefs<T>(SharedPreferences prefs, SettingName name) {
    var _type = getTypeByName(name);
    var _name = getPrefName(name);
    try {
      switch (_type) {
        case int:
          return prefs.getInt(_name) as T;
        case double:
          return prefs.getDouble(_name) as T;
        case String:
          return prefs.getString(_name) as T;
        case bool:
          return prefs.getBool(_name) as T;
        default:
          return json.decode(prefs.getString(_name)) as T;
      }
    } catch (e) {
      return null;
    }
  }

  void set<T>(SettingName name, T value) {
    switch (name) {
      case SettingName.keepScreenOn:
        keepScreenOn = value as bool;
        break;
      case SettingName.expansionStates:
        expansionStates = value is ExpansionStates
            ? value
            : ExpansionStates.fromPrefsString(value as String);
        break;
    }
    applySetting(name);
  }

  T get<T>(SettingName name) {
    switch (name) {
      case SettingName.keepScreenOn:
        return keepScreenOn as T;
      case SettingName.expansionStates:
        return expansionStates as T;
    }
    return null;
  }

  void applySetting<T>(SettingName name) {
    var value = get<T>(name);
    logger.d('Applying $name = $value');
    switch (name) {
      case SettingName.keepScreenOn:
        Screen.keepOn(keepScreenOn);
        return;
      case SettingName.expansionStates:
        return;
    }
  }

  void applyAllSettings() {
    for (var name in SettingName.values) {
      applySetting(name);
    }
  }
}
