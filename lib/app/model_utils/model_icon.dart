import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:flutter/material.dart';

abstract class WithIcon {
  IconData get icon;
}

IconData iconFor(Type t, dynamic object) {
  switch (t) {
    case AbilityScore:
    case Character:
    case CharacterClass:
    case AlignmentValue:
    case Item:
    case Move:
    case Note:
    case Race:
    case Spell:
      return object.icon;
  }
  throw TypeError();
}

IconData genericIconFor(Type t) {
  switch (t) {
    case Character:
      return Character.genericIcon;
    case CharacterClass:
      return CharacterClass.genericIcon;
    case AlignmentValue:
    case Item:
      return Item.genericIcon;
    case Move:
      return Move.genericIcon;
    case Note:
      return Note.genericIcon;
    case Race:
      return Race.genericIcon;
    case Spell:
      return Spell.genericIcon;
  }
  throw TypeError();
}
