import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonThemes {
  static final borderRadius = BorderRadius.circular(10);
  static final rRectShape = RoundedRectangleBorder(borderRadius: borderRadius);

  static ButtonStyle primaryElevated(BuildContext context) => ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shape: rRectShape,
      );
}
