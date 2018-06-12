import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:redux/redux.dart';

enum UserActions {
  Login, Logout
}

enum CharacterActions {
  Set
}

class Action<A, T> {
  final A type;
  final T payload;

  Action({ this.type, this.payload });
}

DbUser userReducer(DbUser user, dynamic action) { //
  if (action.type == UserActions.Login && action.payload != null) {
    print('Logging in: ' + action.payload.toString());
    return action.payload;
  }
  return user;
}

DbCharacter characterReducer(DbCharacter character, dynamic action) {
  if (action.type == CharacterActions.Set && action.payload != null) {
    return action.payload;
  }
  return character;
}


final userStore = new Store<DbUser>(userReducer, initialState: new DbUser());
final characterStore = new Store<DbCharacter>(characterReducer, initialState: new DbCharacter());
