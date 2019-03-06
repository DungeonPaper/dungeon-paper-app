import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_world_data/move.dart';

Future updateMove(num index, Move move) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.moves[index] = move;
  await updateCharacter(character, [CharacterKeys.moves]);
}

Future deleteMove(num index) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.moves.removeAt(index);
  await updateCharacter(character, [CharacterKeys.moves]);
}

Future createMove(Move move) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.moves.add(move);
  await updateCharacter(character, [CharacterKeys.moves]);
}
