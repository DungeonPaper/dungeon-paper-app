import 'package:dungeon_paper/src/atoms/password_field.dart';
import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPasswordDialog extends StatefulWidget {
  final void Function(String password) onConfirm;
  final Widget confirmText;
  final Widget title;
  final List<Widget> children;

  const VerifyPasswordDialog({
    Key key,
    this.title,
    this.confirmText,
    this.onConfirm,
    this.children,
  }) : super(key: key);

  @override
  _VerifyPasswordDialogState createState() => _VerifyPasswordDialogState();
}

class _VerifyPasswordDialogState extends State<VerifyPasswordDialog> {
  TextEditingController controller;
  ValueNotifier<bool> isValid;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '')..addListener(_emptySetState);
    isValid = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title ?? Text('Verify Password'),
      content: SingleChildScrollView(
        child: AutofillGroup(
          child: Column(
            children: [
              ...(widget.children ?? []),
              if (widget.children?.isNotEmpty == true) SizedBox(height: 16),
              PasswordField(
                validNotifier: isValid,
                controller: controller,
              ),
            ],
          ),
        ),
      ),
      actions: StandardDialogControls.actions(
        context: context,
        confirmText: widget.confirmText,
        onConfirm: () => widget.onConfirm?.call(controller.text),
        onCancel: () => Get.back(),
        confirmDisabled: isValid.value == false,
      ),
    );
  }

  void _emptySetState() {
    setState(() {});
  }
}
