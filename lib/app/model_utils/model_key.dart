import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/bio.dart';
import 'package:dungeon_paper/app/data/models/bond.dart';
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

String keyFor<T>(T object) {
  final dyn = object as dynamic;
  switch (T) {
    case AlignmentValue:
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
      return dyn.key;
  }
  throw TypeError();
}
