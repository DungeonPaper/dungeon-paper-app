import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:wheel_spinner/wheel_spinner.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:flutter/material.dart';

class HPEditDialog extends StatefulWidget {
  final DbCharacter character;
  static const int MIN_ROW_WIDTH = 410;

  const HPEditDialog({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  _HPEditDialogState createState() => _HPEditDialogState();
}

enum HPMode { HP, MaxHP }

class _HPEditDialogState extends State<HPEditDialog> {
  int currentHP;
  int maxHP;
  int initialCurrentHP;
  int initialMaxHP;
  HPMode mode;

  @override
  initState() {
    currentHP = widget.character.currentHP ?? 0;
    maxHP = widget.character.maxHP ?? 0;
    initialCurrentHP = currentHP;
    initialMaxHP = maxHP;
    mode = HPMode.HP;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var title = Row(
      children: <Widget>[
        Expanded(child: Text('Manage HP')),
        Text(
          'Editing: ',
          style: Theme.of(context).textTheme.body1,
        ),
        SizedBox(width: 4),
        DropdownButton(
          value: mode,
          onChanged: changeMode,
          items: [
            DropdownMenuItem(
                value: HPMode.HP,
                child: Text('HP' +
                    (currentHP != widget.character.currentHP ? ' *' : ''))),
            DropdownMenuItem(
                value: HPMode.MaxHP,
                child: Text(
                    'Max HP' + (maxHP != widget.character.maxHP ? ' *' : ''))),
          ],
        ),
      ],
    );
    var screenWidth = MediaQuery.of(context).size.width;
    Widget indicator = Container(
      height: 110,
      child: HPEditCurrentHPIndicator(
        initialValue: mode == HPMode.HP ? initialCurrentHP : initialMaxHP,
        value: mode == HPMode.HP ? currentHP : maxHP,
        mode: mode,
      ),
    );
    Widget spinner = Container(
      height: 100,
      child: WheelSpinner(
        key: Key(enumName(mode)),
        min: mode == HPMode.HP ? 0.0 : 1.0,
        max: mode == HPMode.HP
            ? maxHP.toDouble()
            : double.infinity,
        value: mode == HPMode.HP ? currentHP.toDouble() : maxHP.toDouble(),
        minMaxLabelBuilder: (value) => value.toInt().toString(),
        onSlideUpdate: updateValue,
      ),
    );
    return SimpleDialog(
      title: title,
      children: <Widget>[
        Container(
          width: screenWidth >= HPEditDialog.MIN_ROW_WIDTH
              ? HPEditDialog.MIN_ROW_WIDTH.toDouble()
              : 200.0,
          // height: screenWidth >= HPEditDialog.MIN_ROW_WIDTH ? null : 250,
          padding: const EdgeInsets.all(32.0).copyWith(bottom: 0),
          child: screenWidth >= HPEditDialog.MIN_ROW_WIDTH
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
        StandardDialogControls(onOK: () => save(context)),
      ],
    );
  }

  updateValue(val) {
    setState(() {
      if (mode == HPMode.HP) {
        currentHP = val.toInt();
      } else {
        maxHP = val.toInt();
        if (maxHP < currentHP) {
          currentHP = maxHP;
        }
      }
    });
  }

  void save(BuildContext context) {
    DbCharacter char = widget.character;
    char.currentHP = currentHP;
    char.maxHP = maxHP;
    updateCharacter(char, [CharacterKeys.currentHP, CharacterKeys.maxHP]);
    Navigator.pop(context);
  }

  void changeMode(HPMode mode) {
    setState(() {
      this.mode = mode;
    });
  }
}

class HPEditCurrentHPIndicator extends StatelessWidget {
  const HPEditCurrentHPIndicator({
    Key key,
    @required this.initialValue,
    @required this.value,
    @required this.mode,
  }) : super(key: key);

  final int initialValue;
  final int value;
  final HPMode mode;

  @override
  Widget build(BuildContext context) {
    var difference = value - initialValue;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          mode == HPMode.HP ? 'HP ' : 'Max HP ',
          textScaleFactor: 0.9,
          style: TextStyle(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
                mode == HPMode.HP
                    ? "${difference < 0 ? 'Damage' : 'Heal'}: "
                    : "${difference < 0 ? 'Reduce' : 'Add'}: ",
                textScaleFactor: 0.9,
                style: TextStyle(
                  color: difference > 0
                      ? Colors.green
                      : difference < 0
                          ? Colors.red
                          : Theme.of(context).textTheme.body1.color,
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
                          : Theme.of(context).textTheme.body1.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
