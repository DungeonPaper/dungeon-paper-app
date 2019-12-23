import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../flutter_utils.dart';

class NumberController extends StatefulWidget {
  final num value;
  final VoidCallbackFunc<num> onChange;
  final double height;
  final num min;
  final num max;
  final FormatType formatType;

  const NumberController({
    Key key,
    @required this.value,
    @required this.onChange,
    this.height = 80,
    this.min = -double.infinity,
    this.max = double.infinity,
    this.formatType = FormatType.Integer,
  }) : super(key: key);

  @override
  _NumberControllerState createState() => _NumberControllerState();
}

class _NumberControllerState extends State<NumberController> {
  num get controlledStat => widget.formatType == FormatType.Decimal
      ? double.tryParse(_controller.value.text)
      : int.tryParse(_controller.value.text);
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.value.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            shape: CircleBorder(side: BorderSide.none),
            color: Colors.red.shade300,
            textColor: Colors.white,
            child: Text('-', style: TextStyle(fontSize: 30)),
            onPressed: () => _update(
                controlledStat > widget.min ? controlledStat - 1 : widget.min,
                true),
          ),
          Expanded(
            child: TextField(
              onChanged: (val) {
                num intVal = widget.formatType == FormatType.Integer
                    ? int.tryParse(val)
                    : double.tryParse(val);
                _update(intVal);
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                BetweenValuesTextFormatter(
                  widget.min,
                  widget.max,
                  formatType: widget.formatType,
                ),
              ],
              decoration: InputDecoration(
                errorText: !_validate ? '${widget.min}-${widget.max}' : null,
              ),
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
                controlledStat < widget.max ? controlledStat + 1 : widget.max,
                true),
          ),
        ],
      ),
    );
  }

  bool get _validate {
    num intVal = int.tryParse(_controller.text);
    if (widget.min > -double.infinity) {
      return intVal != null && intVal >= widget.min;
    }
    if (widget.max < double.infinity) {
      return intVal != null && intVal <= widget.max;
    }
    return true;
  }

  _update(num val, [bool updateText = false]) {
    if (updateText) _controller.text = val.toString();
    if (widget.onChange != null) {
      widget.onChange(val);
    }
  }
}
