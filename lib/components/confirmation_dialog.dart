import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final Widget title;
  final Widget text;
  final Widget okButtonText;
  final Widget cancelButtonText;

  const ConfirmationDialog({
    Key key,
    this.title: const Text('Are you sure?'),
    this.text: const Text(
        'This action can not be undone.\nAre you sure you want to proceed?'),
    this.okButtonText: const Text('OK'),
    this.cancelButtonText: const Text('Cancel'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: title,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: text,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0)
              .copyWith(bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: cancelButtonText,
                onPressed: () => Navigator.pop(context, false),
              ),
              RaisedButton(
                child: DefaultTextStyle(
                  child: okButtonText,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.red,
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        )
      ],
    );
  }
}
