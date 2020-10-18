import 'package:dungeon_paper/src/flutter_utils/input_validators.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final InputDecoration decoration;
  final TextEditingController controller;
  final bool validate;
  final ValueNotifier<bool> validNotifier;

  const PasswordField({
    Key key,
    this.decoration,
    this.controller,
    this.validate = true,
    this.validNotifier,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscured;

  @override
  void initState() {
    super.initState();
    obscured = true;
    if (widget.controller != null && widget.validNotifier != null) {
      widget.controller.addListener(_updateValidityNotifier);
    }
  }

  @override
  void dispose() {
    if (widget.controller != null && widget.validNotifier != null) {
      widget.controller.removeListener(_updateValidityNotifier);
    }
    super.dispose();
  }

  void _updateValidityNotifier() {
    widget.validNotifier?.value =
        PasswordValidator.validate(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final decoration = widget.decoration ?? InputDecoration();

    return TextFormField(
      controller: widget.controller,
      autofillHints: [AutofillHints.password],
      decoration: decoration.copyWith(
        labelText: decoration.labelText ?? 'Password',
        floatingLabelBehavior:
            decoration.floatingLabelBehavior ?? FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: obscured ? Colors.grey[600] : Colors.blue[300],
          ),
          tooltip: obscured ? 'Tap to show password' : 'Tap to hide password',
          onPressed: () => setState(() => obscured = !obscured),
        ),
      ),
      obscureText: obscured,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      validator: widget.validate == true
          ? (pwd) => pwd.isNotEmpty && !PasswordValidator.validate(pwd)
              ? PasswordValidator.getMessage(pwd)
              : null
          : null,
    );
  }
}
