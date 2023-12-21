import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/core/route_arguments.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:flutter/widgets.dart';

class SelectMovesSpellsController extends ChangeNotifier {
  var dirty = false;

  var moves = <Move>[];
  var spells = <Spell>[];
  late AbilityScores abilityScores;
  late CharacterClass characterClass;
  late final void Function(List<Move> moves, List<Spell> spells) onChanged;

  SelectMovesSpellsController(BuildContext context) {
    final SelectMovesSpellsArguments args = getArgs(context);
    moves = args.moves.toList();
    spells = args.spells.toList();
    abilityScores = args.abilityScores;
    characterClass = args.characterClass;
    onChanged = args.onChanged;
  }

  Iterable<Move> get sortedMoves =>
      [...moves]..sort((a, b) => a.category == b.category
          ? cleanStr(a.name).compareTo(cleanStr(b.name))
          : a.category == MoveCategory.basic
              ? -1
              : b.category == MoveCategory.basic
                  ? 1
                  : 0);

  void addMoves(Iterable<Move> added) {
    moves = addByKey(moves, added);
    dirty = true;
    notifyListeners();
  }

  void updateMove(Move move) {
    moves = updateByKey(moves, [move]);
    dirty = true;
    notifyListeners();
  }

  void deleteMove(Move move) {
    moves = removeByKey(moves, [move]);
    dirty = true;
    notifyListeners();
  }

  void addSpells(Iterable<Spell> added) {
    spells = addByKey(spells, added);
    dirty = true;
    notifyListeners();
  }

  void updateSpell(Spell spell) {
    spells = updateByKey(spells, [spell]);
    dirty = true;
    notifyListeners();
  }

  void deleteSpell(Spell spell) {
    spells = removeByKey(spells, [spell]);
    dirty = true;
    notifyListeners();
  }
}

class SelectMovesSpellsArguments {
  final void Function(List<Move> moves, List<Spell> spells) onChanged;
  final List<Move> moves;
  final List<Spell> spells;
  final AbilityScores abilityScores;
  final CharacterClass characterClass;

  SelectMovesSpellsArguments({
    required this.onChanged,
    required this.moves,
    required this.spells,
    required this.abilityScores,
    required this.characterClass,
  });
}

