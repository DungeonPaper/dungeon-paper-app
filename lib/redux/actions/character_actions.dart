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

class UpdateField {
  String field;
  dynamic value;
  UpdateField(this.field, this.value);
}

class RemoveAll {}

class CharacterActions {
  static SetCurrentChar setCurrentChar(String id, DbCharacter data) =>
      SetCurrentChar(id, data);

  static UpdateField updateField(String field, value) =>
      UpdateField(field, value);

  static SetCharacters setCharacters(Map<String, DbCharacter> characters) =>
      SetCharacters(characters);

  static RemoveAll remove() => RemoveAll();
}
