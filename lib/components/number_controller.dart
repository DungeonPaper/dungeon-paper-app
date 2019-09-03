import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../flutter_utils.dart';

class NumberController extends StatefulWidget {
  final num value;
  final VoidCallbackFunc<num> onChange;

  const NumberController({
    Key key,
    @required this.value,
    @required this.onChange,
  }) : super(key: key);

  @override
  _NumberControllerState createState() => _NumberControllerState();
}

class _NumberControllerState extends State<NumberController> {
  num get controlledStat => int.parse(_controller.value.text);
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          shape: CircleBorder(side: BorderSide.none),
          color: Colors.red.shade300,
          textColor: Colors.white,
          child: Text('-', style: TextStyle(fontSize: 30)),
          onPressed: () => _update(controlledStat > 0 ? controlledStat - 1 : 0),
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
              BetweenValuesTextFormatter(0, 20)
            ],
            decoration: InputDecoration(errorText: !_validate ? '' : null),
            controller: _controller,
            autofocus: true,
            style: TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
        ),
        RaisedButton(
          shape: CircleBorder(side: BorderSide.none),
          color: Colors.green.shade400,
          textColor: Colors.white,
          child: Text('+', style: TextStyle(fontSize: 24)),
          onPressed: () =>
              _update(controlledStat < 20 ? controlledStat + 1 : 20),
        ),
      ],
    );
  }

  bool get _validate {
    num intVal = int.tryParse(_controller.text);
    return intVal != null && intVal <= 20 && intVal >= 0;
  }

  _update(num val) {
    if (widget.onChange != null) {
      widget.onChange(val);
    }
  }
}
