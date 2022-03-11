import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';

class CharacterUtils {
  static Character updateMove(Character char, Move move) => char.copyWith(
        moves: updateByKey(char.moves, move),
      );
  static Character removeMove(Character char, Move move) => char.copyWith(
        moves: removeByKey(char.moves, move),
      );
  static Character updateSpell(Character char, Spell spell) => char.copyWith(
        spells: updateByKey(char.spells, spell),
      );
  static Character removeSpell(Character char, Spell spell) => char.copyWith(
        spells: removeByKey(char.spells, spell),
      );
  static Character updateItem(Character char, Item item) => char.copyWith(
        items: updateByKey(char.items, item),
      );
  static Character removeItem(Character char, Item item) => char.copyWith(
        items: removeByKey(char.items, item),
      );
}
