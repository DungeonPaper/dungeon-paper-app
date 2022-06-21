import 'package:flutter/material.dart';

TextTheme copyTextThemeWith(
  TextTheme original, {
  String? fontFamily,
  Color? normalColor,
  Color? specialColor,
}) =>
    original.copyWith(
      headline1: original.headline1?.copyWith(fontFamily: fontFamily, color: specialColor),
      headline2: original.headline2?.copyWith(fontFamily: fontFamily, color: specialColor),
      headline3: original.headline3?.copyWith(fontFamily: fontFamily, color: specialColor),
      headline4: original.headline4?.copyWith(fontFamily: fontFamily, color: specialColor),
      headline5: original.headline5?.copyWith(fontFamily: fontFamily, color: specialColor),
      headline6: original.headline6?.copyWith(fontFamily: fontFamily, color: specialColor),
      subtitle1: original.subtitle1?.copyWith(fontFamily: fontFamily, color: specialColor),
      subtitle2: original.subtitle2?.copyWith(fontFamily: fontFamily, color: specialColor),
      bodyText1: original.bodyText1?.copyWith(fontFamily: fontFamily, color: normalColor),
      bodyText2: original.bodyText2?.copyWith(fontFamily: fontFamily, color: normalColor),
      caption: original.caption?.copyWith(fontFamily: fontFamily, color: normalColor),
      button: original.button?.copyWith(fontFamily: fontFamily, color: normalColor),
      overline: original.overline?.copyWith(fontFamily: fontFamily, color: normalColor),
    );
