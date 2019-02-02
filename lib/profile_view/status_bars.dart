import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:flutter/material.dart';

class StatusBars extends StatelessWidget {
  // StatusBars({Key key}) : super(key: key);
  static const double _PROGRESS_HEIGHT = 20;
  static const double _VALUE_WIDTH = 80;
  static const valueStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const labelStyle =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w300, letterSpacing: -1);

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector(
      builder: (context, state) {
        DbCharacter character = state.characters.current;
        return Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('HP', style: labelStyle),
                          SizedBox(
                              width: _VALUE_WIDTH,
                              child: Center(
                                  child: Text(
                                      '${character.currentHP}/${character.maxHP}',
                                      style: valueStyle)))
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          height: _PROGRESS_HEIGHT,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.red.shade100,
                            valueColor:
                                AlwaysStoppedAnimation(Colors.red.shade700),
                            value: character.currentHP > 0
                                ? character.currentHP / character.maxHP
                                : 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('XP', style: labelStyle),
                          SizedBox(
                              width: _VALUE_WIDTH,
                              child: Center(
                                  child: Text(
                                      '${character.currentXP}/${character.level * 7}',
                                      style: valueStyle)))
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          height: _PROGRESS_HEIGHT,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.lightBlue.shade100,
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                            value: character.currentXP > 0
                                ? character.currentXP / (character.level + 7)
                                : 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
