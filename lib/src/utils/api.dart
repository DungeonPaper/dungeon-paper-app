import 'dart:convert';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'credentials.dart';

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<User> doApiLogin(FirebaseUser fbUser, Credentials credential) async {
  if (fbUser == null || credential == null) {
    return null;
  }

  var secrets = await loadSecrets();
  var idToken = await fbUser.getIdToken();
  var uri = Uri(
    host: secrets.API_DOMAIN,
    scheme: 'https',
    path: '${secrets.API_PATH}/login/',
    queryParameters: {'include_nested': 'false'},
  );
  var response = await http.get(uri.toString(), headers: {
    'Authorization': 'Bearer ' + idToken.token,
  });
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json.containsKey('status') && json['status'] == 'error') {
      return null;
    }
    var user = User(
      ref: firestore.collection('user_data').document(fbUser.email),
      autoLoad: false,
    );
    await user.getRemoteData();
    return user;
  }
  throw Exception('bad response: ${response.body}');
}
