import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/inventory.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';

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
  return updateCharacter(character, [CharacterKeys.inventory]);
}

Future createInventoryItem(InventoryItem item) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.inventory.add(item);
  return updateCharacter(character, [CharacterKeys.inventory]);
}

Future incrItemAmount(num index, InventoryItem item, num amount) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  item.amount += amount;
  item.amount = clamp(item.amount, 0, double.infinity).toInt();
  character.inventory[index] = item;
  return await updateCharacter(character, [CharacterKeys.inventory]);
}
