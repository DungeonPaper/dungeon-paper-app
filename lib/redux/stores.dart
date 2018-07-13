import 'package:dungeon_paper/db/user.dart';
import 'package:redux/redux.dart';

enum UserActions { Login, Logout, Loading }

enum CharacterActions { Change, Remove, RemoveAll, Loading }

class Action<T, A> {
  final A type;
  final T payload;

  Action({this.type, this.payload});
}

Map userReducer(Map state, dynamic action) {
  if (action.type == UserActions.Login && action.payload != null) {
    print('Logging in: ' + action.payload.toString());
    state['id'] = action.payload['id'];
    state['data'] = action.payload['data'];
    return state;
  }

  if (action.type == UserActions.Loading && action.payload != null) {
    state['loading'] = action.payload;
    return state;
  }

  if (action.type == UserActions.Logout) {
    print('Logging out');
    state['id'] = null;
    state['data'] = null;
    state['loading'] = false;
    return state;
  }

  return state;
}

Map characterReducer(Map state, dynamic action) {
  if (action.type == CharacterActions.Change && action.payload != null) {
    state['id'] = action.payload['id'];
    state['data'] = action.payload['data'];
    return state;
  }

  if (action.type == CharacterActions.Loading && action.payload != null) {
    state['loading'] = action.payload;
    return state;
  }

  if (action.type == CharacterActions.RemoveAll) {
    state['id'] = null;
    state['data'] = null;
    state['loading'] = false;
    return state;
  }

  return state;
}

final userStore = new Store<Map>(
  userReducer,
  initialState: {
    'id': null,
    'data': null,
    'loading': false,
  },
);

final characterStore = new Store<Map>(
  characterReducer,
  initialState: {
    'id': null,
    'data': null,
    'loading': false,
  },
);
