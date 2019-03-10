import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:dungeon_paper/components/wheel_slider.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:flutter/material.dart';

class HPEditDialog extends StatefulWidget {
  final DbCharacter character;

  const HPEditDialog({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  _HPEditDialogState createState() => _HPEditDialogState();
}

class _HPEditDialogState extends State<HPEditDialog> {
  int value;
  int initialValue;

  @override
  initState() {
    value = widget.character.currentHP ?? 0;
    initialValue = value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int difference = value - initialValue;
    return SimpleDialog(
      title: Text('Manage HP'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                width: 150,
                height: 100,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'HP ',
                            textScaleFactor: 0.9,
                            style: TextStyle(),
                          ),
                          Text(
                            initialValue.toString(),
                            style: TextStyle(fontSize: 36.0),
                          ),
                          Icon(Icons.arrow_forward),
                          Text(
                            value.toString(),
                            style: TextStyle(fontSize: 36.0),
                          ),
                        ],
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${difference < 0 ? 'Damage' : 'Heal'}: ",
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                color: difference > 0
                                    ? Colors.green
                                    : difference < 0
                                        ? Colors.red
                                        : Theme.of(context)
                                            .textTheme
                                            .body1
                                            .color,
                              ),
                            ),
                            Text(
                              "${difference >= 0 ? '+' : ''}$difference",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: difference > 0
                                    ? Colors.green
                                    : difference < 0
                                        ? Colors.red
                                        : Theme.of(context)
                                            .textTheme
                                            .body1
                                            .color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: WheelSlider(
                  min: 0.0,
                  max: widget.character.maxHP.toDouble(),
                  value: widget.character.currentHP.toDouble(),
                  onSlideUpdate: (val) {
                    setState(() {
                      value = val.toInt();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        StandardDialogControls(
          onCancel: () => Navigator.pop(context),
          onOK: () => save(context),
        ),
      ],
    );
  }

  void save(BuildContext context) {
    DbCharacter char = widget.character;
    char.currentHP = value;
    updateCharacter(char, [CharacterKeys.currentHP]);
    Navigator.pop(context);
  }
}
