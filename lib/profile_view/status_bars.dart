import 'package:dungeon_paper/redux/connectors/character_connector.dart';
import 'package:flutter/material.dart';

class StatusBars extends StatelessWidget {
  // StatusBars({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CharacterConnector(
      builder: (context, character) {
        return Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.pink,
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                    value: character.currentHP > 0
                        ? character.currentHP / character.maxHP * 100
                        : 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white70,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: character.currentXP > 0
                        ? character.currentXP / (character.level + 7) * 100
                        : 0,
                  ),
                ),
              ],
            ),
          ),
          // child: Padding(
          //   padding: EdgeInsets.all(10.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           LinearProgressIndicator(
          //             value: character.currentHP > 0 ? character.currentHP / character.maxHP : 0,
          //           ),
          //         ],
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           LinearProgressIndicator(
          //             value: character.currentXP > 0 ? character.currentXP / (character.level + 7) : 0,
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}
