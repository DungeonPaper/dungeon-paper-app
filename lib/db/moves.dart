import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/move.dart';
import 'character_db.dart';
import 'character_utils.dart';

ReturnPredicate<Move> matchMove =
    matcher<Move>((Move i, Move o) => i.key == o.key);

Future updateMove(Move move) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  Character character = dwStore.state.characters.current;
  num index = character.moves.indexWhere(matchMove(move));
  character.moves[index] = move;
  await updateCharacter(character, [CharacterKeys.moves]);
}

Future deleteMove(Move move) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  Character character = dwStore.state.characters.current;
  num index = character.moves.indexWhere(matchMove(move));
  character.moves.removeAt(index);
  await updateCharacter(character, [CharacterKeys.moves]);
}

Future createMove(Move move) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  Character character = dwStore.state.characters.current;
  character.moves.add(move);
  await updateCharacter(character, [CharacterKeys.moves]);
}
