part of 'prefs_store.dart';

class SetPrefs {
  final PrefsStore prefs;
  SetPrefs(this.prefs);
}

class ChangeSetting<T> {
  final SettingName name;
  final T value;

  Type get type => T;

  ChangeSetting({
    @required this.name,
    @required this.value,
  });
}
