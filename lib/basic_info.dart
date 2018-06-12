import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
            converter: (character) => character.state['data'],
            builder: (context, character) {
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
                        : new Placeholder(
                            fallbackHeight:
                                MediaQuery.of(context).size.height / 4,
                            color: Colors.red),
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
}
