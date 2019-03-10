import 'package:flutter/material.dart';

class StandardDialogControls extends StatelessWidget {
  final Function() onOK;
  final Function() onCancel;
  final Widget cancelText;
  final Widget okText;

  const StandardDialogControls(
      {Key key, this.onOK, this.onCancel, Widget cancelText, Widget okText})
      : cancelText = cancelText ?? const Text('Cancel'),
        okText = okText ?? const Text('Save'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0)
          .copyWith(bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: onCancel,
            child: cancelText,
          ),
          RaisedButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: onOK,
            child: okText,
          ),
        ],
      ),
    );
  }
}
