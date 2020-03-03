import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/move.dart';

ReturnPredicate<Move> matchMove =
    matcher<Move>((Move i, Move o) => i.key == o.key);

Future updateMove(Move move) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  Character character = dwStore.state.characters.current;
  num index = character.moves.indexWhere(matchMove(move));
  character.moves[index] = move;
  await character
      .update(json: {'moves': findAndReplaceInList(character.moves, move)});
}

Future deleteMove(Move move) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  Character character = dwStore.state.characters.current;
  await character
      .update(json: {'moves': removeFromList(character.moves, move)});
}

Future createMove(Move move) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  Character character = dwStore.state.characters.current;
  await character.update(json: {'moves': addToList(character.moves, move)});
}
