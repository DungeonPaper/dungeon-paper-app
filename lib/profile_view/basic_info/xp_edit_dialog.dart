import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:dungeon_paper/profile_view/basic_info/current_stat_indicator.dart';
import 'package:dungeon_paper/profile_view/status_bars.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:wheel_spinner/wheel_spinner.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:flutter/material.dart';

class XPEditDialog extends StatefulWidget {
  final DbCharacter character;
  static const int MIN_ROW_WIDTH = 410;

  const XPEditDialog({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  _XPEditDialogState createState() => _XPEditDialogState();
}

class _XPEditDialogState extends State<XPEditDialog> {
  int currentXP;
  int initialCurrentXP;

  @override
  initState() {
    currentXP = widget.character.currentXP ?? 0;
    initialCurrentXP = currentXP;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    int maxXP = widget.character.level + 7;
    Widget indicator = Container(
      height: 110,
      child: currentXP < maxXP && currentXP > 0
          ? CurrentStatIndicator(
              initialValue: initialCurrentXP,
              value: currentXP,
              label: 'XP',
              differenceTextBuilder: (above) => above ? 'Add' : 'Reduce',
            )
          : Center(
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
                child: Text(currentXP > 0 ? 'Level Up' : 'Level Down'),
                onPressed: currentXP == 0 && widget.character.level == 1
                    ? null
                    : () =>
                        currentXP > 0 ? levelUp(context) : levelDown(context),
              ),
            ),
    );
    Widget spinner = Container(
      height: 100,
      child: WheelSpinner(
        key: Key('${widget.character.level}-spinner'),
        min: 0.0,
        max: maxXP.toDouble(),
        value: currentXP.toDouble(),
        minMaxLabelBuilder: (value) => value.toInt().toString(),
        onSlideUpdate: updateValue,
      ),
    );
    return SimpleDialog(
      title: Text('Manage XP'),
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 32.0).copyWith(top: 10.0),
          child: StatusBarInfo(
            value: currentXP / maxXP,
            minNum: currentXP.toString(),
            maxNum: maxXP.toString(),
            barBackgroundColor: Colors.lightBlue.shade100,
            barForegroundColor: Colors.blue,
          ),
        ),
        Container(
          width: screenWidth >= XPEditDialog.MIN_ROW_WIDTH
              ? XPEditDialog.MIN_ROW_WIDTH.toDouble()
              : 200.0,
          padding: const EdgeInsets.all(32.0).copyWith(bottom: 0),
          child: screenWidth >= XPEditDialog.MIN_ROW_WIDTH
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(child: indicator),
                    Expanded(child: spinner),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    indicator,
                    spinner,
                  ],
                ),
        ),
        StandardDialogControls(
          cancelText: Text('Close'),
          onOK: currentXP != maxXP &&
                  (currentXP != 0 || widget.character.level == 1)
              ? () => save(context)
              : null,
        ),
      ],
    );
  }

  updateValue(val) {
    setState(() {
      currentXP = val.toInt();
    });
  }

  void save(BuildContext context) {
    DbCharacter char = widget.character;
    char.currentXP = currentXP;
    updateCharacter(char, [CharacterKeys.currentXP]);
    Navigator.pop(context);
  }

  void levelUp(BuildContext context) async {
    DbCharacter char = widget.character;
    char.currentXP = 0;
    char.level++;
    updateCharacter(char, [CharacterKeys.currentXP, CharacterKeys.level]);
    setState(() {
      currentXP = char.currentXP;
      initialCurrentXP = currentXP;
    });
    return showDialog(
      context: context,
      builder: (context) => LevelUpDialog(char: char),
    );
  }

  void levelDown(BuildContext context) async {
    DbCharacter char = widget.character;
    char.level--;
    char.currentXP = char.level + 6;
    updateCharacter(char, [CharacterKeys.currentXP, CharacterKeys.level]);
    setState(() {
      currentXP = char.currentXP;
      initialCurrentXP = currentXP;
    });
    return showDialog(
      context: context,
      builder: (context) => LevelUpDialog(char: char, levelDown: true),
    );
  }
}

class LevelUpDialog extends StatelessWidget {
  const LevelUpDialog({
    Key key,
    @required this.char,
    this.levelDown = false,
  }) : super(key: key);

  final DbCharacter char;
  final bool levelDown;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(!levelDown ? 'Woah! Congratulations!' : 'Wait, what?'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text('You are now level ${char.level}!'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              child: Text('Continue'),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        )
      ],
    );
  }
}
