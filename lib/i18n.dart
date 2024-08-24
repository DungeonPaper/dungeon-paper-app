import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/tag.dart';

import 'app/data/services/intl_service.dart';
import 'i18n/messages.i18n.dart';

/// Get the current language Messages object, which contains all the
/// translations for the current language.
Messages get tr => IntlService.instance.m;

/// Get the static name of a type, for use with `tr.entity*` methods.
String tn(Type type) {
  switch (type) {
    case == AbilityScore:
      return 'AbilityScore';
    case == Campaign:
      return 'Campaign';
    case == Character:
      return 'Character';
    case == AlignmentValue:
      return 'AlignmentValue';
    case == Move:
      return 'Move';
    case == Spell:
      return 'Spell';
    case == Item:
      return 'Item';
    case == CharacterClass:
      return 'CharacterClass';
    case == Race:
      return 'Race';
    case == GearSelection:
      return 'GearSelection';
    case == Note:
      return 'Note';
    case == MoveCategory:
      return 'MoveCategory';
    case == Tag:
      return 'Tag';
    case == Dice:
      return 'Dice';
    default:
      final typeString = type.toString();
      final match = RegExp(r'\w+', caseSensitive: false).firstMatch(typeString);
      return match?.group(0) ?? typeString;
  }
}