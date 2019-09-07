import 'package:dungeon_paper/db/character_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../flutter_utils.dart';

class NumberController extends StatefulWidget {
  final int value;
  final VoidCallbackFunc<int> onChange;

  const NumberController({
    Key key,
    @required this.value,
    @required this.onChange,
  }) : super(key: key);

  @override
  _NumberControllerState createState() => _NumberControllerState();
}

class _NumberControllerState extends State<NumberController> {
  int get controlledStat => int.parse(_controller.value.text);
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.value.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          shape: CircleBorder(side: BorderSide.none),
          color: Colors.red.shade300,
          textColor: Colors.white,
          child: Text('-', style: TextStyle(fontSize: 30)),
          onPressed: () =>
              _update(controlledStat > 0 ? controlledStat - 1 : 0, true),
        ),
        Expanded(
          child: TextField(
            onChanged: (val) {
              num intVal = int.tryParse(val);
              if (intVal != null) {
                _update(int.tryParse(val) ?? widget.value);
              }
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
              BetweenValuesTextFormatter(0, MAX_STAT_VALUE)
            ],
            decoration: InputDecoration(errorText: !_validate ? '' : null),
            controller: _controller,
            autofocus: true,
            style: TextStyle(fontSize: 24.0),
            textAlign: TextAlign.left,
          ),
        ),
        RaisedButton(
          shape: CircleBorder(side: BorderSide.none),
          color: Colors.green.shade400,
          textColor: Colors.white,
          child: Text('+', style: TextStyle(fontSize: 24)),
          onPressed: () => _update(
              controlledStat < MAX_STAT_VALUE
                  ? controlledStat + 1
                  : MAX_STAT_VALUE,
              true),
        ),
      ],
    );
  }

  bool get _validate {
    num intVal = int.tryParse(_controller.text);
    return intVal != null && intVal <= MAX_STAT_VALUE && intVal >= 0;
  }

  _update(num val, [bool updateText = false]) {
    if (updateText) _controller.text = val.toString();
    if (widget.onChange != null) {
      widget.onChange(val);
    }
  }
}
