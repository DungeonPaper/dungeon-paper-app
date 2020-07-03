import 'dart:convert';

import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SettingName {
  keepScreenOn,
}

class PrefsSettings {
  bool keepScreenOn;

  PrefsSettings({
    this.keepScreenOn = true,
  });

  static final _SETTING_NAME_KEYS = <SettingName, String>{
    SettingName.keepScreenOn: 'KeepScreenOn',
  };

  static final _SETTING_NAME_TYPES = <SettingName, Type>{
    SettingName.keepScreenOn: bool,
  };

  factory PrefsSettings.loadFromPrefs(SharedPreferences prefs) {
    return PrefsSettings(
      keepScreenOn: getFromPrefs(prefs, SettingName.keepScreenOn) ?? true,
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
    logger.d('Setting $name = $value');
    switch (name) {
      case SettingName.keepScreenOn:
        keepScreenOn = value as bool;
        break;
    }
    applySetting(name);
  }

  T get<T>(SettingName name) {
    switch (name) {
      case SettingName.keepScreenOn:
        return keepScreenOn as T;
      default:
        return null;
    }
  }

  void applySetting<T>(SettingName name) {
    var value = get<T>(name);
    logger.d('Applying $name = $value');
    switch (name) {
      case SettingName.keepScreenOn:
        Screen.keepOn(keepScreenOn);
        return;
    }
  }

  void applyAllSettings() {
    for (var name in SettingName.values) {
      applySetting(name);
    }
  }
}
