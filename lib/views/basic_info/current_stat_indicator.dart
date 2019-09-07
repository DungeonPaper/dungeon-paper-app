import 'package:flutter/material.dart';

class CurrentStatIndicator extends StatelessWidget {
  const CurrentStatIndicator({
    Key key,
    @required this.initialValue,
    @required this.value,
    @required this.label,
    @required this.differenceTextBuilder,
  }) : super(key: key);

  final int initialValue;
  final int value;
  final String label;
  final String Function(bool adding) differenceTextBuilder;

  @override
  Widget build(BuildContext context) {
    var difference = value - initialValue;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          label + ' Change:',
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
                differenceTextBuilder(difference >= 0) + ': ',
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
