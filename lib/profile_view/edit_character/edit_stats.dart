import 'package:dungeon_paper/components/number_controller.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_utils.dart';
import 'package:flutter/material.dart';

import 'character_wizard_utils.dart';

class EditStats extends StatefulWidget {
  final DbCharacter character;
  final CharSaveFunction onSave;
  final ScaffoldBuilderFunction builder;

  const EditStats({
    Key key,
    @required this.character,
    @required this.onSave,
    this.builder,
  }) : super(key: key);

  EditStats.withScaffold({
    Key key,
    @required this.character,
    @required this.onSave,
    Function() onDidPop,
    Function() onWillPop,
  })  : builder = characterWizardScaffold(
          titleText: 'Stats',
          onDidPop: onDidPop,
          onWillPop: onWillPop,
        ),
        super(key: key);

  @override
  _EditStatsState createState() => _EditStatsState();
}

class _EditStatsState extends State<EditStats> {
  int _str;
  int _dex;
  int _con;
  int _int;
  int _wis;
  int _cha;

  @override
  Widget build(BuildContext context) {
    var child = Column(
      children: <Widget>[
        for (CharacterKeys stat in ORDERED_STATS)
          EditStatListTile(
            stat: stat,
            value: _str,
            onChange: _valueUpdateBuilder(_setter(stat)),
          ),
      ],
    );
    if (widget.builder != null) {
      return widget.builder(
        context: context,
        child: child,
        save: _save,
        isValid: _isFormValid,
      );
    }
    return child;
  }

  _valueUpdateBuilder(Function(int val) setter) {
    return (val) {
      setState(setter(val));
    };
  }

  _setter(CharacterKeys stat) {
    switch (stat) {
      case (CharacterKeys.str):
        return (val) => _str = val;
      case (CharacterKeys.dex):
        return (val) => _dex = val;
      case (CharacterKeys.con):
        return (val) => _con = val;
      case (CharacterKeys.int):
        return (val) => _int = val;
      case (CharacterKeys.cha):
        return (val) => _cha = val;
      case (CharacterKeys.wis):
        return (val) => _wis = val;
      default:
        return null;
    }
  }

  _save() {
    DbCharacter character = widget.character;
    List<CharacterKeys> keys = ORDERED_STATS;

    character.str = _str;
    character.dex = _dex;
    character.cha = _cha;
    character.wis = _wis;
    character.int = _int;
    character.con = _con;

    if (widget.onSave != null) {
      widget.onSave(character, keys);
    }
  }

  bool _isFormValid() {
    // TODO: validate
    return true;
  }
}

class EditStatListTile extends StatelessWidget {
  final CharacterKeys stat;
  final int value;
  final Function(int newValue) onChange;

  const EditStatListTile({
    Key key,
    @required this.stat,
    @required this.value,
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(CHARACTER_STAT_LABELS[stat]),
      subtitle: Text(
        "${CHARACTER_STAT_MODIFIER_LABELS[stat]}: " +
            "${DbCharacter.statModifier(value)}",
      ),
      trailing: NumberController(
        value: value,
        onChange: onChange,
      ),
    );
  }
}
