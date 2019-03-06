import 'package:dungeon_paper/db/character.dart';

class SetCurrentChar {
  String id;
  DbCharacter character;
  SetCurrentChar(this.id, this.character);
}

class SetCharacters {
  Map<String, DbCharacter> characters;
  SetCharacters(this.characters);
}

class RemoveAll {}

class CharacterActions {
  static SetCurrentChar setCurrentChar(String id, DbCharacter data) =>
      SetCurrentChar(id, data);

  static SetCharacters setCharacters(Map<String, DbCharacter> characters) =>
      SetCharacters(characters);

  static RemoveAll remove() => RemoveAll();
}
