import 'dart:convert';

import 'package:dungeon_paper/src/redux/shared_preferences/prefs_settings.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_store.dart';

import '../stores.dart';

class ExpansionStates {
  final Map<String, Map<String, bool>> _data = {};

  Map<String, bool> get _charData {
    _data[charId] ??= {};
    return _data[charId];
  }

  ExpansionStates([Map<String, Map<String, bool>> initialData]) {
    if (initialData != null && initialData.isNotEmpty) {
      _initData(initialData);
    }
  }

  ExpansionStates.fromData(Map<String, Map<String, bool>> initialData) {
    if (initialData != null && initialData.isNotEmpty) {
      _initData(initialData);
    }
  }

  ExpansionStates.fromPrefsString(String str) {
    if (str == null || str.isEmpty) {
      _initData({});
      return;
    }

    try {
      final orig = Map<String, String>.from(jsonDecode(str));
      final parsed = Map.fromEntries(
        orig.entries.map(
          (entry) => MapEntry(
            entry.key,
            Map<String, bool>.fromEntries(
              entry.value.split(',').map(
                    (i) => MapEntry(i, false),
                  ),
            ),
          ),
        ),
      );

      _initData(parsed);
    } catch (e) {
      print(e);
      _initData({});
    }
  }

  void _initData(Map<String, Map<String, bool>> initialData) {
    _data.addAll(initialData);
  }

  bool isExpanded(String key) =>
      key == null || !_charData.containsKey(key) || _charData[key] == true;

  String get charId => dwStore.state.characters.current?.documentID;

  void toggle(String key) {
    if (_charData.containsKey(key)) {
      _set(key, !_charData[key]);
    } else {
      _set(key, false);
    }
  }

  void _set(String key, bool value) {
    if (key == null) {
      return;
    }
    _charData[key] = value;
    _save();
  }

  void setExpansion(String key, bool value) {
    _set(key, value);
  }

  void _save() {
    dwStore.dispatch(ChangeSetting(
      name: SettingName.expansionStates,
      value: toPrefsString(),
    ));
  }

  String toPrefsString() => jsonEncode(
        Map.fromEntries(
          _data.entries.map(
            (entry) => MapEntry(
              entry.key,
              entry.value.entries
                  .where((e) =>
                      e.key != null && e.key != 'null' && e.value == false)
                  .map((e) => e.key)
                  .join(','),
            ),
          ),
        ),
      );
}