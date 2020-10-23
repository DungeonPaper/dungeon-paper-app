import 'package:dungeon_paper/src/atoms/password_field.dart';
import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPasswordDialog extends StatefulWidget {
  final void Function(String password) onConfirm;
  final Widget confirmText;

  const VerifyPasswordDialog({
    Key key,
    this.onConfirm,
    this.confirmText,
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
      content: SingleChildScrollView(
        child: PasswordField(
          validNotifier: isValid,
          controller: controller,
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
