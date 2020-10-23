import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StandardDialogControls extends StatelessWidget {
  final void Function() onConfirm;
  final void Function() onCancel;
  final Widget cancelText;
  final Widget confirmText;
  final List<Widget> middle;
  final EdgeInsets padding;
  final bool confirmDisabled;
  final bool cancelDisabled;

  static const defaultCancelText = Text('Cancel');
  static const defaultOkText = Text('Save');
  static const defaultPadding = EdgeInsets.only(top: 40, left: 16, right: 16);

  const StandardDialogControls({
    Key key,
    this.onConfirm,
    this.onCancel,
    this.cancelText = defaultCancelText,
    this.confirmText = defaultOkText,
    this.middle,
    this.padding = defaultPadding,
    this.confirmDisabled = false,
    this.cancelDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: padding,
        child: Wrap(
          alignment: WrapAlignment.end,
          spacing: 5.0,
          children: actions(
            context: context,
            onCancel: onCancel,
            onConfirm: onConfirm,
            cancelText: cancelText,
            confirmText: confirmText,
            middle: middle,
            confirmDisabled: confirmDisabled,
            cancelDisabled: cancelDisabled,
          ),
        ),
      ),
    );
  }

  static List<Widget> actions({
    void Function() onConfirm,
    void Function() onCancel,
    Widget cancelText = defaultCancelText,
    Widget confirmText = defaultOkText,
    List<Widget> middle,
    bool confirmDisabled = false,
    bool cancelDisabled = false,
    @required BuildContext context,
  }) =>
      <Widget>[
        if (onCancel != null)
          FlatButton(
            onPressed: !cancelDisabled ? (onCancel ?? () => Get.back()) : null,
            child: cancelText,
          ),
        if (middle?.isNotEmpty == true) ...middle,
        if (onConfirm != null)
          RaisedButton(
            color: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: !confirmDisabled ? onConfirm : null,
            child: confirmText,
          ),
      ];
}
