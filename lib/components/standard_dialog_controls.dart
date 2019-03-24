import 'package:flutter/material.dart';

class StandardDialogControls extends StatelessWidget {
  final Function() onOK;
  final Function() onCancel;
  final Widget cancelText;
  final Widget okText;

  const StandardDialogControls({
    Key key,
    this.onOK,
    this.onCancel,
    Widget cancelText,
    Widget okText,
  })  : cancelText = cancelText ?? const Text('Cancel'),
        okText = okText ?? const Text('Save'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0)
            .copyWith(bottom: 0),
        child: Wrap(
          alignment: WrapAlignment.end,
          children: <Widget>[
            FlatButton(
              onPressed:
                  onCancel != null ? onCancel : () => Navigator.pop(context),
              child: cancelText,
            ),
            RaisedButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: onOK,
              child: okText,
            ),
          ],
        ),
      ),
    );
  }
}
