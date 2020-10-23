import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final Widget title;
  final Widget text;
  final Widget okButtonText;
  final Widget cancelButtonText;
  final Object Function(bool result) returnValue;
  final bool noCancel;

  const ConfirmationDialog({
    Key key,
    this.title = const Text('Are you sure?'),
    this.text =
        const Text('This action can not be undone.\nDo you want to proceed?'),
    this.okButtonText = const Text('OK'),
    this.cancelButtonText = const Text('Cancel'),
    this.returnValue,
    this.noCancel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: text,
        ),
      ),
      actions: <Widget>[
        if (!noCancel)
          FlatButton(
            child: cancelButtonText,
            onPressed: () => Get.back(result: getReturnVal(false)),
          ),
        RaisedButton(
          child: DefaultTextStyle(
            child: okButtonText,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          color: Colors.red,
          onPressed: () => Get.back(result: getReturnVal(true)),
        ),
      ],
    );
  }

  dynamic getReturnVal(bool result) {
    if (returnValue != null) {
      return returnValue(result);
    }

    return result;
  }
}
