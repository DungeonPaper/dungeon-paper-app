import 'base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbUser extends DbBase {
  final defaultData = {
    'characters': [],
    'displayName': 'Guest',
    'photoURL': null,
    'email': 'your@gmail.com',
  };

  DbUser([Map map]): super(map);

  List get characters { return get<List>('characters'); }
  String get displayName { return get<String>('displayName'); }
  String get photoURL { return get<String>('photoURL'); }
  String get email { return get<String>('email'); }
}

FirebaseUser authUser;
DbUser currentUser = DbUser({});

setUser(user) {
  authUser = user;
}

setDbUser(dbUser) {
  currentUser = dbUser;
}
