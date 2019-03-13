import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_world_data/spell.dart';

Future updateSpell(num index, Spell spell) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.spells[index] = spell;
  await updateCharacter(character, [CharacterKeys.spells]);
}

Future deleteSpell(num index) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.spells.removeAt(index);
  await updateCharacter(character, [CharacterKeys.spells]);
}

Future createSpell(Spell spell) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.spells.add(spell);
  await updateCharacter(character, [CharacterKeys.spells]);
}
