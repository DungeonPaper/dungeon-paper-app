part of 'characters_store.dart';

class SetCharacters {
  final Map<String, Character> characters;
  SetCharacters(this.characters);
}

class SetCurrentChar {
  final Character character;

  SetCurrentChar(this.character);
}

class AddCharacter {
  final Character character;
  AddCharacter(this.character);
}

class RemoveCharacter {
  final Character character;
  RemoveCharacter(this.character);
}

class UpdateCharacter {
  final Character character;
  UpdateCharacter(this.character);
}

class ClearCharacters {}
