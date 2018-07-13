import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({Key key}) : super(key: key);

  @override
  _BasicInfoState createState() => new _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  @override
  Widget build(BuildContext context) {
    return new StoreProvider<Map>(
        store: characterStore,
        child: new StoreConnector<Map, DbCharacter>(
            converter: (character) =>
              character.state['data'],
            builder: (context, character) {
              if (character == null) {
                _getDetailsFromPrefs(context);
                return const CircularProgressIndicator(value: null);
              }

              return new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    character.photoURL != null
                        ? new Container(
                            height: MediaQuery.of(context).size.height / 4.0,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                fit: BoxFit.fitWidth,
                                alignment: FractionalOffset.topCenter,
                                image: new NetworkImage(character.photoURL),
                              ),
                            ),
                          )
                        : const Text('Nothing to see here'),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Material(
                            // margin: EdgeInsets.all(0.0),

                            child: new Padding(
                              padding: new EdgeInsets.all(16.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text('Level ${character.level} ' +
                                          '${capitalize(character.alignment + ' ' + character.mainClass)}' // +
                                      // ', XP: ${character.currentXP.toString()}'
                                      ),
                                  new Text('${character.displayName}',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]);
            }));
  }

  _getDetailsFromPrefs(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('userEmail');
    String characterId = prefs.getString('characterId');

    if (userEmail == null || characterId == null) {
      return;
    }

    var controller = Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text('Logging in with $userEmail...'),
          duration: new Duration(seconds: 4),
        ));

    DbUser user = await setCurrentUserByField('email', userEmail);
    await setCurrentCharacterById(characterId);
    controller.close();

    Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text('Logged in as ${user.displayName}'),
          duration: new Duration(seconds: 4),
        ));
  }
}
