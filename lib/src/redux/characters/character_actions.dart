part of 'characters_store.dart';

class SetCharacters {
  final Map<String, Character> characters;
  final bool overwrite;
  SetCharacters(this.characters, [this.overwrite = true]);
}

class SetCurrentChar {
  final Character character;

  SetCurrentChar(this.character);
}

class RemoveCharacter {
  final Character character;
  RemoveCharacter(this.character);
}

class UpsertCharacter {
  final Character character;
  UpsertCharacter(this.character);
}

class ClearCharacters {}
