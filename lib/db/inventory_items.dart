import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/inventory.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';

Future updateInventoryItem(num index, InventoryItem item) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.inventory[index] = item;
  await updateCharacter(character, [CharacterKeys.inventory]);
}

Future deleteInventoryItem(num index) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.inventory.removeAt(index);
  await updateCharacter(character, [CharacterKeys.inventory]);
}

Future createInventoryItem(InventoryItem item) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.inventory.add(item);
  await updateCharacter(character, [CharacterKeys.inventory]);
}
