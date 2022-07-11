import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/monster.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
// import 'package:dungeon_world_data/gear_option.dart';
// import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

Meta<T> metaFor<T>(dynamic object) {
  if (object is WithMeta) {
    return object.meta as Meta<T>;
  }
  throw TypeError();
}

T copyWithMeta<T extends WithMeta>(dynamic object, Meta? meta) {
  switch (object.runtimeType) {
    case AlignmentValue:
    case CharacterClass:
    case Character:
    case Item:
    case Monster:
    case Move:
    case Note:
    case Race:
    case Spell:
      return object.copyWithInherited(meta: meta) as T;
    default:
      throw UnsupportedError('Type ${object.runtimeType} not supported');
  }
}

/// Returns an item with forked meta, or the same meta if its by the same user
T forkMeta<T extends WithMeta>(dynamic object, User user, {Meta? meta, String? version}) {
  final Meta _m = (meta ?? object.meta);
  // final _o =
  //     force || _m.createdBy != user.username ? object.copyWithInherited(key: uuid()) : object;
  final _o = object;

  return copyWithMeta<T>(
    _o,
    _m.fork(
      createdBy: user.username,
      sourceKey: keyFor(object),
      version: version,
    ),
  );
}

T increaseMetaVersion<T extends WithMeta>(T object) {
  return copyWithMeta(
    object,
    object.meta.copyWith(version: uuid()),
  );
}
