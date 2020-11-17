part of 'characters_store.dart';

class SetCharacters {
  final Map<String, Character> characters;
  SetCharacters(this.characters);

  factory SetCharacters.fromIterable(Iterable<Character> iterable) =>
      SetCharacters({
        for (final char in iterable) char.documentID: char,
      });
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
