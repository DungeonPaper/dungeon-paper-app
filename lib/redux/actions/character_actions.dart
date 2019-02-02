import 'package:dungeon_paper/db/character.dart';

class SetCurrentChar {
  String id;
  DbCharacter character;
  SetCurrentChar(this.id, this.character);
}

class UpdateField {
  String field;
  dynamic value;
  UpdateField(this.field, this.value);
}

class RemoveAll {}

class CharacterActions {
  static SetCurrentChar setCurrentChar(
          String id, DbCharacter data) =>
      SetCurrentChar(id, data);

  static UpdateField updateField(String field, value) =>
      UpdateField(field, value);

  static RemoveAll remove() => RemoveAll();
}
