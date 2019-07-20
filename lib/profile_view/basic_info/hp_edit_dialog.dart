import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:dungeon_paper/profile_view/basic_info/current_stat_indicator.dart';
import 'package:dungeon_paper/profile_view/status_bars.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:wheel_spinner/wheel_spinner.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:flutter/material.dart';

class EditHPDialog extends StatefulWidget {
  final DbCharacter character;
  static const int MIN_ROW_WIDTH = 410;

  const EditHPDialog({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  _EditHPDialogState createState() => _EditHPDialogState();
}

enum HPMode { HP, MaxHP }

class _EditHPDialogState extends State<EditHPDialog> {
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
      child: CurrentStatIndicator(
        initialValue: mode == HPMode.HP ? initialCurrentHP : initialMaxHP,
        value: mode == HPMode.HP ? currentHP : maxHP,
        label: mode == HPMode.HP ? 'HP' : 'Max HP',
        differenceTextBuilder: (above) => mode == HPMode.HP
            ? above ? 'Heal' : 'Damage'
            : above ? 'Add' : 'Reduce',
      ),
    );
    Widget spinner = Container(
      height: 100,
      child: WheelSpinner(
        key: Key(enumName(mode)),
        min: mode == HPMode.HP ? 0.0 : 1.0,
        max: mode == HPMode.HP ? maxHP.toDouble() : double.infinity,
        value: mode == HPMode.HP ? currentHP.toDouble() : maxHP.toDouble(),
        minMaxLabelBuilder: (value) => value.toInt().toString(),
        onSlideUpdate: updateValue,
      ),
    );
    return SimpleDialog(
      title: title,
      contentPadding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: StatusBarInfo(
            value: currentHP / maxHP,
            minNum: currentHP.toString(),
            maxNum: maxHP.toString(),
            barBackgroundColor: Colors.red.shade100,
            barForegroundColor: Colors.red.shade700,
          ),
        ),
        Container(
          width: screenWidth >= EditHPDialog.MIN_ROW_WIDTH
              ? EditHPDialog.MIN_ROW_WIDTH.toDouble()
              : 200.0,
          // height: screenWidth >= HPEditDialog.MIN_ROW_WIDTH ? null : 250,
          padding: const EdgeInsets.only(top: 32.0),
          child: screenWidth >= EditHPDialog.MIN_ROW_WIDTH
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
          onOK: () => save(context),
          extraActions: mode == HPMode.HP
              ? null
              : [
                  RaisedButton(
                    child: Text('Default'),
                    onPressed: () {
                      updateValue(widget.character.defaultMaxHP);
                    },
                  )
                ],
        ),
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
