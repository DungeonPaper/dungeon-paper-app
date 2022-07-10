import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/bio.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/monster.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_world_data/gear_option.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

Map<String, dynamic> toJsonFor(dynamic object) {
  final dyn = object as dynamic;
  switch (object.runtimeType) {
    case AlignmentValue:
    case Bio:
    case SessionMark:
    case CharacterClass:
    case CharacterStats:
    case Character:
    case GearChoice:
    case GearSelection:
    case GearOption:
    case Item:
    case Monster:
    case Move:
    case Note:
    case Race:
    case Spell:
    case dw.Tag:
      return dyn.toJson();
  }
  throw TypeError();
}

T fromJsonFor<T>(Map<String, dynamic> json) {
  switch (T) {
    case AlignmentValue:
      return AlignmentValue.fromJson(json) as T;
    case Bio:
      return Bio.fromJson(json) as T;
    case SessionMark:
      return SessionMark.fromJson(json) as T;
    case CharacterClass:
      return CharacterClass.fromJson(json) as T;
    case CharacterStats:
      return CharacterStats.fromJson(json) as T;
    case Character:
      return Character.fromJson(json) as T;
    case GearChoice:
      return GearChoice.fromJson(json) as T;
    case GearSelection:
      return GearSelection.fromJson(json) as T;
    case GearOption:
      return GearOption.fromJson(json) as T;
    case Item:
      return Item.fromJson(json) as T;
    case Monster:
      return Monster.fromJson(json) as T;
    case Move:
      return Move.fromJson(json) as T;
    case Note:
      return Note.fromJson(json) as T;
    case Race:
      return Race.fromJson(json) as T;
    case Spell:
      return Spell.fromJson(json) as T;
    case dw.Tag:
      return dw.Tag.fromJson(json) as T;
  }
  throw TypeError();
}
