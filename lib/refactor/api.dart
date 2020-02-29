import 'dart:convert';
import 'package:dungeon_paper/refactor/auth.dart';
import 'package:dungeon_paper/refactor/user_with_characters.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<UserWithCharacters> doApiLogin(
    FirebaseUser user, ExposedAuthCredential credential) async {
  if (user == null || credential == null) {
    return null;
  }

  var secrets = await loadSecrets();
  var idToken = await user.getIdToken();
  var uri = Uri(
    host: secrets.API_DOMAIN,
    scheme: 'https',
    path: '${secrets.API_PATH}/login/',
  );
  var response = await http.get(uri.toString(), headers: {
    'Authorization': 'Bearer ' + idToken.token,
  });
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json.containsKey('status') && json['status'] == 'error') {
      return null;
    }
    return UserWithCharacters(data: json);
  }
  throw Exception('bad response: ${response.body}');
}
