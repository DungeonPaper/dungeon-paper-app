import 'dart:convert';
import 'dart:html';
import 'package:dungeon_paper/refactor/auth.dart';
import 'package:dungeon_paper/refactor/user_with_characters.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<UserWithCharacters> doApiLogin(
    FirebaseUser user, ExposedAuthCredential credential) async {
  if (user == null || credential == null) {
    return null;
  }

  var secrets = await loadSecrets();
  var response = await HttpRequest.getString(
    Uri(
      host: '${secrets.API_BASE}',
      path: '/login',
      queryParameters: {
        'email': user.email,
        'accessToken': credential.accessToken,
        'idToken': credential.idToken,
      },
    ).toString(),
  );
  Map<String, dynamic> json = jsonDecode(response);
  if (json.containsKey('status') && json['status'] == 'error') {
    return null;
  }
  return UserWithCharacters.fromData(data: json);
}
