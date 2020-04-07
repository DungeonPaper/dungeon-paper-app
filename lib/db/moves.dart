import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/move.dart';

ReturnPredicate<Move> matchMove =
    matcher<Move>((Move i, Move o) => i.key == o.key);

Future updateMove(Character character, Move move) async {
  num index = character.moves.indexWhere(matchMove(move));
  character.moves[index] = move;
  await character
      .update(json: {'moves': findAndReplaceInList(character.moves, move)});
}

Future deleteMove(Character character, Move move) async {
  await character
      .update(json: {'moves': removeFromList(character.moves, move)});
}

Future createMove(Character character, Move move) async {
  await character.update(json: {'moves': addToList(character.moves, move)});
}
