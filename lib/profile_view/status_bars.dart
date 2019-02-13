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
        Color hpBg = Colors.red.shade100;
        if (character == null ||
            character.currentHP == null ||
            character.currentXP == null) {
          return Material(
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.all(5),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        Animation<Color> hpValueColor =
            AlwaysStoppedAnimation(Colors.red.shade700);
        double hpPerc = character != null &&
                character.currentHP != null &&
                character.currentHP > 0
            ? character.currentHP / character.maxHP
            : 0;
        Color xpBg = Colors.lightBlue.shade100;
        Animation<Color> xpValueColor = AlwaysStoppedAnimation(Colors.blue);
        double xpPerc = character != null &&
                character.currentXP != null &&
                character.currentXP > 0
            ? character.currentXP / (character.level + 7)
            : 0;
        return Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
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
                                  style: valueStyle),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          height: _PROGRESS_HEIGHT,
                          child: LinearProgressIndicator(
                            backgroundColor: hpBg,
                            valueColor: hpValueColor,
                            value: hpPerc,
                            // onEditUpdate: (value) => dwStore.dispatch(
                            //     CharacterActions.updateField('currentHP',
                            //         (value * character.maxHP).round())),
                            // onEditEnd: (value) => updateCharacter({
                            //       'currentHP': (value * character.maxHP).round()
                            //    }),
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
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('XP', style: labelStyle),
                          SizedBox(
                            width: _VALUE_WIDTH,
                            child: Center(
                              child: Text(
                                  '${character.currentXP}/${character.level + 7}',
                                  style: valueStyle),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          height: _PROGRESS_HEIGHT,
                          child: LinearProgressIndicator(
                            backgroundColor: xpBg,
                            valueColor: xpValueColor,
                            value: xpPerc,
                            // onEditUpdate: (value) => dwStore.dispatch(
                            //     CharacterActions.updateField(
                            //         'currentXP', value)),
                            // onEditEnd: (value) =>
                            //     updateCharacter({'currentXP': value}),
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
