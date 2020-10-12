import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:flutter/material.dart';

class SingleFieldEditDialog<T> extends StatelessWidget {
  final String fieldName;
  final T value;
  final void Function() onOK;
  final void Function() onCancel;
  final Widget Function(BuildContext) fieldBuilder;
  final Widget title;

  const SingleFieldEditDialog({
    Key key,
    @required this.fieldName,
    @required this.value,
    @required this.onOK,
    @required this.onCancel,
    @required this.fieldBuilder,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: fieldBuilder(context),
            ),
          ],
        ),
      ),
      actions: StandardDialogControls.actions(
        context: context,
        onConfirm: onOK,
        confirmText: Text('Save'),
        onCancel: onCancel,
      ),
    );
  }
}

class SingleTextFieldEditDialog extends StatefulWidget {
  final String value;
  final String fieldName;
  final Widget title;
  final void Function(String) onSave;
  final void Function() onCancel;

  const SingleTextFieldEditDialog({
    Key key,
    @required this.value,
    @required this.fieldName,
    @required this.title,
    @required this.onSave,
    @required this.onCancel,
  }) : super(key: key);

  @override
  _SingleTextFieldEditDialogState createState() =>
      _SingleTextFieldEditDialogState();
}

class _SingleTextFieldEditDialogState extends State<SingleTextFieldEditDialog> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController.fromValue(
      TextEditingValue(text: widget.value?.toString()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleFieldEditDialog<String>(
      title: widget.title,
      value: widget.value,
      fieldName: widget.fieldName,
      onOK: () => widget.onSave?.call(controller.text),
      onCancel: widget.onCancel,
      fieldBuilder: (context) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: widget.fieldName,
          ),
        ),
      ),
    );
  }
}
