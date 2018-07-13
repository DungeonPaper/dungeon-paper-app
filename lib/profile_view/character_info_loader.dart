import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/profile_view/character_headliner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoLoaderState extends State {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<Map, DbCharacter>(
        converter: (characterStore) => characterStore.state['data'],
        builder: (context, character) {
          if (character == null) {
            _getDetailsFromPrefs(context); // TODO: move somewhere
            var loading = false;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: loading
                      ? const CircularProgressIndicator(value: null)
                      : const Text('Please log in!'),
                ),
              ],
            );
          }

          List<Widget> charImageWidget = character.photoURL != null
              ? [
                  Container(
                      height: MediaQuery.of(context).size.height / 4.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: FractionalOffset.topCenter,
                        image: NetworkImage(character.photoURL),
                      )))
                ]
              : [];

          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: charImageWidget +
                  <Widget>[
                    new CharacterHeadline(character: character),
                  ]);
        });
  }

  _getDetailsFromPrefs(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('userEmail');
    String characterId = prefs.getString('characterId');

    if (userEmail == null || characterId == null) {
      return;
    }

    var controller = Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Logging in with $userEmail...'),
          duration: Duration(seconds: 4),
        ));

    DbUser user = await setCurrentUserByField('email', userEmail);
    await setCurrentCharacterById(characterId);
    controller.close();

    Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Logged in as ${user.displayName}'),
          duration: Duration(seconds: 4),
        ));
  }
}

class UserInfoLoader extends StatefulWidget {
  final Widget loader;
  final VoidCallback builder;
  UserInfoLoader({Key key, this.loader, this.builder}) : super(key: key);

  @override
  UserInfoLoaderState createState() => UserInfoLoaderState();
}
