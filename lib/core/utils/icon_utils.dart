import 'package:flutter/material.dart';

class IconUtils {
  static IconData? iconDataFromName(String? name) => null;

  static dynamic iconDataToJson(IconData? icon) => icon?.toString();
}

mixin WithIcon {
  IconData get icon;
}
