import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/actions/user_actions.dart';
import 'package:dungeon_paper/redux/stores/character_store.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/redux/stores/user_store.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoogleSignIn _googleSignIn = new GoogleSignIn();
final Firestore firestore = Firestore.instance;
FirebaseUser authUser;
DbUser currentUser = DbUser({});
StreamSubscription listener;

class DbUser extends DbBase {
  final defaultData = {
    'characters': [],
    'displayName': 'Guest',
    'photoURL': null,
    'email': 'your@gmail.com',
  };

  DbUser([Map map]) : super(map);

  List get characters => get<List>('characters');
  String get displayName => get<String>('displayName');
  String get photoURL => get<String>('photoURL');
  String get email => get<String>('email');
}

setCurrentUserByEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  QuerySnapshot userQuery = await Firestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .getDocuments();

  if (userQuery.documents.length == 0) {
    return;
  }

  DocumentSnapshot userDoc = userQuery.documents[0];
  DbUser dbUser = DbUser(userDoc.data);

  prefs.setString('userId', userDoc.documentID);
  prefs.setString('userEmail', dbUser.email);

  userStore.dispatch(UserActions.login(userDoc.documentID, dbUser));
}

requestSignOut() async {
  await _googleSignIn.signOut();
  unsetCurrentUser();
  unsetCurrentCharacter();
}

unsetCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('userId');
  prefs.remove('CharacterId');
  prefs.remove('userEmail');
  userStore.dispatch(UserActions.logout());
}

requestSignIn() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  sharedPrefs.setString('accessToken', googleAuth.accessToken);
  sharedPrefs.setString('idToken', googleAuth.idToken);

  FirebaseUser authUser = await performSignIn();
  setCurrentUserByEmail(authUser.email);

  return authUser;
}

registerUserListener() {
  FirebaseAuth.instance.onAuthStateChanged.listen((FirebaseUser authUser) {
    if (listener != null) {
      listener.cancel();
    }
    listener = userStore.onChange.listen((UserStore state) async {
      String id = state.id;
      DbUser dbUser = state.user;

      if (dbUser.characters.length > 0) {
        DocumentSnapshot charSnap = await dbUser.characters[0].get();
        DbCharacter charData = DbCharacter(charSnap.data);
        characterStore.dispatch(CharacterActions.updateChar(id, charData));
      } else {
        createCharacter();
      }
    });
  });
}
