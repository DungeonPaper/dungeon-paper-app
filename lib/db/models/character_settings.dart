import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' as painting;

final _alignmentMapping = {
  'topLeft': painting.Alignment.topLeft,
  'topCenter': painting.Alignment.topCenter,
  'topRight': painting.Alignment.topRight,
  'centerLeft': painting.Alignment.centerLeft,
  'center': painting.Alignment.center,
  'centerRight': painting.Alignment.centerRight,
  'bottomLeft': painting.Alignment.bottomLeft,
  'bottomCenter': painting.Alignment.bottomCenter,
  'bottomRight': painting.Alignment.bottomRight,
};

typedef _DataListener = void Function(_CharacterSettingsData);
typedef _ValueListener = void Function(CharacterSettings);

class _CharacterSettingsData {
  final ValueNotifier<bool> _useDefaultMaxHp;
  final ValueNotifier<painting.Alignment> _photoAlignment;

  _CharacterSettingsData({
    bool useDefaultMaxHp = true,
    painting.Alignment photoAlignment = painting.Alignment.topCenter,
  })  : _useDefaultMaxHp = ValueNotifier(useDefaultMaxHp),
        _photoAlignment = ValueNotifier(photoAlignment);

  bool get useDefaultMaxHp => _useDefaultMaxHp.value;
  set useDefaultMaxHp(bool value) => _useDefaultMaxHp.value = value;
  painting.Alignment get photoAlignment => _photoAlignment.value;
  set photoAlignment(painting.Alignment value) => _photoAlignment.value = value;

  void addListener(void Function() listener) {
    _useDefaultMaxHp.addListener(listener);
    _photoAlignment.addListener(listener);
  }

  void removeListener(void Function() listener) {
    _useDefaultMaxHp.removeListener(listener);
    _photoAlignment.removeListener(listener);
  }
}

class CharacterSettings extends ValueNotifier<_CharacterSettingsData> {
  CharacterSettings({
    bool useDefaultMaxHp = true,
    painting.Alignment photoAlignment = painting.Alignment.topCenter,
  }) : super(_CharacterSettingsData(
          useDefaultMaxHp: useDefaultMaxHp,
          photoAlignment: photoAlignment,
        )) {
    value.addListener(notifyListeners);
  }

  bool get useDefaultMaxHp => value.useDefaultMaxHp;
  set useDefaultMaxHp(bool newValue) => value.useDefaultMaxHp = newValue;
  painting.Alignment get photoAlignment => value.photoAlignment;
  set photoAlignment(painting.Alignment newValue) =>
      value.photoAlignment = newValue;

  factory CharacterSettings.fromJSON(Map map) {
    return CharacterSettings(
      useDefaultMaxHp: map['useDefaultMaxHp'] ?? true,
      photoAlignment: stringToEnum(
            map['photoAlignment'] ?? 'topCenter',
            _alignmentMapping,
          ) ??
          painting.Alignment.topCenter,
    );
  }

  CharacterSettings copyWith({
    bool useDefaultMaxHp,
    painting.Alignment photoAlignment,
  }) =>
      CharacterSettings(
        useDefaultMaxHp: useDefaultMaxHp ?? this.useDefaultMaxHp,
        photoAlignment: photoAlignment ?? this.photoAlignment,
      );

  Map toJSON() => {
        'useDefaultMaxHp': useDefaultMaxHp,
        'photoAlignment': photoAlignment,
      };
}
