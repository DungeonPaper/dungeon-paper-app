import 'dart:async';

import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:flutter/material.dart';

class SingleFieldEditDialog<T> extends StatefulWidget {
  final String fieldName;
  final T value;
  final FutureOr<void> Function() onConfirm;
  final void Function() onCancel;
  final Widget Function(BuildContext) fieldBuilder;
  final Widget title;
  final Widget prompt;
  final Iterable<Widget> children;
  final Widget confirmText;
  final bool confirmDisabled;

  const SingleFieldEditDialog({
    Key key,
    @required this.fieldName,
    @required this.value,
    @required this.onConfirm,
    @required this.onCancel,
    @required this.fieldBuilder,
    @required this.title,
    this.confirmText,
    this.confirmDisabled,
    this.prompt,
    this.children,
  }) : super(key: key);

  @override
  _SingleFieldEditDialogState<T> createState() =>
      _SingleFieldEditDialogState<T>();
}

class _SingleFieldEditDialogState<T> extends State<SingleFieldEditDialog<T>> {
  bool loading;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.prompt != null) widget.prompt,
            if (widget.children?.isNotEmpty == true) ...widget.children,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: widget.fieldBuilder(context),
            ),
          ],
        ),
      ),
      actions: StandardDialogControls.actions(
        context: context,
        onConfirm: _confirm,
        confirmDisabled: widget.confirmDisabled || loading,
        confirmText:
            loading ? Loader.button() : widget.confirmText ?? Text('Save'),
        onCancel: widget.onCancel,
      ),
    );
  }

  void _confirm() async {
    setState(() => loading = true);
    await widget.onConfirm?.call();
    setState(() => loading = false);
  }
}

class SingleTextFieldEditDialog extends StatefulWidget {
  final String value;
  final String fieldName;
  final Widget title;
  final Widget confirmText;
  final FutureOr<void> Function(String) onSave;
  final void Function() onCancel;
  final bool allowEmpty;
  final bool Function(String) confirmDisabled;

  const SingleTextFieldEditDialog({
    Key key,
    @required this.value,
    @required this.fieldName,
    @required this.title,
    @required this.onSave,
    @required this.onCancel,
    this.confirmText,
    this.allowEmpty = false,
    this.confirmDisabled,
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
    )..addListener(_listener);
    super.initState();
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleFieldEditDialog<String>(
      title: widget.title,
      value: widget.value,
      fieldName: widget.fieldName,
      confirmText: widget.confirmText,
      onConfirm: () => widget.onSave?.call(controller.text),
      confirmDisabled: isEmpty || _confirmDisabled,
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

  bool get isEmpty => widget.allowEmpty == true || controller.text.isEmpty;

  bool get _confirmDisabled =>
      widget.confirmDisabled?.call(controller.text) == true;
}
