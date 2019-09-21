import 'package:flutter/material.dart';

class StandardDialogControls extends StatelessWidget {
  final Function() onOK;
  final Function() onCancel;
  final Widget cancelText;
  final Widget okText;
  final List<Widget> extraActions;
  final EdgeInsets padding;
  final bool okDisabled;
  final bool cancelDisabled;

  const StandardDialogControls({
    Key key,
    this.onOK,
    this.onCancel,
    Widget cancelText,
    Widget okText,
    this.extraActions,
    this.padding = const EdgeInsets.only(top: 40, left: 16, right: 16),
    this.okDisabled = false,
    this.cancelDisabled = false,
  })  : cancelText = cancelText ?? const Text('Cancel'),
        okText = okText ?? const Text('Save'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: padding,
        child: Wrap(
          alignment: WrapAlignment.end,
          spacing: 5.0,
          children: <Widget>[
            if (onCancel != null)
              FlatButton(
                onPressed:
                    !cancelDisabled ? onCancel != null ? onCancel : () => Navigator.pop(context) : null,
                child: cancelText,
              ),
            if (extraActions != null && extraActions.isNotEmpty)
              ...extraActions,
            if (onOK != null)
              RaisedButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: !okDisabled ? onOK : null,
                child: okText,
              ),
          ],
        ),
      ),
    );
  }
}
