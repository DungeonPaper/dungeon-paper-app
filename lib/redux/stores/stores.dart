import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:flutter/material.dart';

class CharacterStore {
  String id;
  DbCharacter character;

  CharacterStore({@required this.id, @required this.character});
}

class UserStore {
  String id;
  DbUser user;

  UserStore({@required this.id, @required this.user});
}
