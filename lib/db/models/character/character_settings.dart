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

class CharacterSettings {
  final bool useDefaultMaxHp;
  final bool autoCalcArmor;
  final painting.Alignment photoAlignment;

  CharacterSettings({
    this.useDefaultMaxHp = true,
    this.autoCalcArmor = true,
    this.photoAlignment = painting.Alignment.topCenter,
  });

  factory CharacterSettings.fromJSON(Map map) {
    return CharacterSettings(
      useDefaultMaxHp: map['useDefaultMaxHp'] ?? true,
      autoCalcArmor: map['autoCalcArmor'] ?? true,
      photoAlignment: stringToEnum(
            map['photoAlignment'] ?? 'topCenter',
            _alignmentMapping,
          ) ??
          painting.Alignment.topCenter,
    );
  }

  CharacterSettings copyWith({
    bool useDefaultMaxHp,
    bool autoCalcArmor,
    painting.Alignment photoAlignment,
  }) =>
      CharacterSettings(
        useDefaultMaxHp: useDefaultMaxHp ?? this.useDefaultMaxHp,
        autoCalcArmor: autoCalcArmor ?? this.autoCalcArmor,
        photoAlignment: photoAlignment ?? this.photoAlignment,
      );

  Map toJSON() => {
        'useDefaultMaxHp': useDefaultMaxHp,
        'autoCalcArmor': autoCalcArmor,
        'photoAlignment': enumName(photoAlignment),
      };
}
