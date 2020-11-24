import 'package:dungeon_paper/src/redux/shared_preferences/prefs_settings.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_store.dart';

import '../stores.dart';

class ExpansionStates {
  final _data = <String, bool>{};

  ExpansionStates([Map<String, bool> initialData]) {
    if (initialData != null && initialData.isNotEmpty) {
      _initData(initialData);
    }
  }

  ExpansionStates.fromData(Map<String, bool> initialData) {
    if (initialData != null && initialData.isNotEmpty) {
      _initData(initialData);
    }
  }

  ExpansionStates.fromPrefsString(String str) {
    if (str == null || str.isEmpty) {
      _initData({});
      return;
    }

    final vals = Map<String, bool>.fromEntries(
      str.split(',').map(
            (i) => MapEntry(i, false),
          ),
    );

    _initData(vals);
  }

  void _initData(Map<String, bool> initialData) {
    _data.addAll(initialData);
  }

  bool isExpanded(String key) => !_data.containsKey(key) || _data[key] == true;

  void toggle(String key) {
    if (_data.containsKey(key)) {
      _set(key, !_data[key]);
    } else {
      _set(key, false);
    }
  }

  void _set(String key, bool value) {
    if (key == null) {
      return;
    }
    _data[key] = value;
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

  String toPrefsString() => _data.entries
      .where((e) => e.key != null && e.key != 'null' && e.value == false)
      .map((e) => e.key)
      .join(',');
}
