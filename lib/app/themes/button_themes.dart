import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonThemes {
  static final borderRadius = BorderRadius.circular(10);
  static final rRectShape = RoundedRectangleBorder(borderRadius: borderRadius);

  static ButtonStyle get primaryElevated => ElevatedButton.styleFrom(
        primary: Get.theme.primaryColor,
        shape: rRectShape,
      );
}
