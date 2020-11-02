import 'package:dungeon_paper/db/helpers/character_utils.dart';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/atoms/number_controller.dart';
import 'package:dungeon_paper/src/utils/types.dart';
import 'package:flutter/material.dart';

class EditStats extends StatefulWidget {
  final Character character;
  final VoidCallbackDelegate<Character> onUpdate;

  const EditStats({
    Key key,
    @required this.character,
    @required this.onUpdate,
  }) : super(key: key);

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
  Map<CharacterKey, bool> errors = {};

  @override
  void initState() {
    _str = widget.character.str;
    _dex = widget.character.dex;
    _con = widget.character.con;
    _int = widget.character.int;
    _wis = widget.character.wis;
    _cha = widget.character.cha;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            for (CharacterKey stat in ORDERED_STATS)
              EditStatListTile(
                stat: stat,
                value: _getter(stat),
                onChange: _valueUpdateBuilder(_setter(stat)),
              ),
          ],
        ),
      ),
    );
  }

  void Function(num) _valueUpdateBuilder(
      CallbackDelegate<num, VoidEmptyCallbackDelegate> setter) {
    return (val) {
      final setterVal = setter(val);
      setState(setterVal);
    };
  }

  CallbackDelegate<num, VoidEmptyCallbackDelegate> _setter(CharacterKey stat) {
    Function(num) setter;
    Function(bool) errorSetter;
    switch (stat) {
      case (CharacterKey.str):
        setter = (val) {
          widget.character.str = val;
          _str = val;
          widget?.onUpdate(widget.character);
        };
        errorSetter = (state) {
          errors[CharacterKey.str] = state;
        };
        break;
      case (CharacterKey.dex):
        setter = (val) {
          widget.character.dex = val;
          _dex = val;
          widget?.onUpdate(widget.character);
        };
        errorSetter = (state) {
          errors[CharacterKey.dex] = state;
        };
        break;
      case (CharacterKey.con):
        setter = (val) {
          widget.character.con = val;
          _con = val;
          widget?.onUpdate(widget.character);
        };
        errorSetter = (state) {
          errors[CharacterKey.con] = state;
        };
        break;
      case (CharacterKey.int):
        setter = (val) {
          widget.character.int = val;
          _int = val;
          widget?.onUpdate(widget.character);
        };
        errorSetter = (state) {
          errors[CharacterKey.int] = state;
        };
        break;
      case (CharacterKey.cha):
        setter = (val) {
          widget.character.cha = val;
          _cha = val;
          widget?.onUpdate(widget.character);
        };
        errorSetter = (state) {
          errors[CharacterKey.cha] = state;
        };
        break;
      case (CharacterKey.wis):
        setter = (val) {
          widget.character.wis = val;
          _wis = val;
          widget?.onUpdate(widget.character);
        };
        errorSetter = (state) {
          errors[CharacterKey.wis] = state;
        };
        break;
      default:
        setter = (val) {};
    }

    return (val) {
      return () {
        if (val == null) {
          errorSetter(true);
        } else {
          errorSetter(false);
          setter(val);
        }
      };
    };
  }

  num _getter(CharacterKey stat) {
    switch (stat) {
      case (CharacterKey.str):
        return _str;
      case (CharacterKey.dex):
        return _dex;
      case (CharacterKey.con):
        return _con;
      case (CharacterKey.int):
        return _int;
      case (CharacterKey.cha):
        return _cha;
      case (CharacterKey.wis):
        return _wis;
      default:
        return null;
    }
  }
}

class EditStatListTile extends StatelessWidget {
  final CharacterKey stat;
  final int value;
  final Function(int) onChange;

  const EditStatListTile({
    Key key,
    @required this.stat,
    @required this.value,
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListItem(
      padding: EdgeInsets.only(left: 8),
      title: Text(CHARACTER_STAT_LABELS[stat]),
      subtitle: Text(
        '${CHARACTER_STAT_MODIFIER_LABELS[stat]}: '
        '${CharacterFields.modifierFromValue(value)}',
      ),
      trailing: Container(
        width: 230,
        child: NumberController(
          value: value,
          onChange: onChange,
          min: 0,
          max: MAX_STAT_VALUE,
          autoFocus: false,
        ),
      ),
    );
  }
}
