import 'package:flutter/material.dart';

TextTheme copyTextThemeWith(TextTheme original, {String? fontFamily}) => original.copyWith(
      headline1: original.headline1?.copyWith(fontFamily: fontFamily),
      headline2: original.headline2?.copyWith(fontFamily: fontFamily),
      headline3: original.headline3?.copyWith(fontFamily: fontFamily),
      headline4: original.headline4?.copyWith(fontFamily: fontFamily),
      headline5: original.headline5?.copyWith(fontFamily: fontFamily),
      headline6: original.headline6?.copyWith(fontFamily: fontFamily),
      subtitle1: original.subtitle1?.copyWith(fontFamily: fontFamily),
      subtitle2: original.subtitle2?.copyWith(fontFamily: fontFamily),
      bodyText1: original.bodyText1?.copyWith(fontFamily: fontFamily),
      bodyText2: original.bodyText2?.copyWith(fontFamily: fontFamily),
      caption: original.caption?.copyWith(fontFamily: fontFamily),
      button: original.button?.copyWith(fontFamily: fontFamily),
      overline: original.overline?.copyWith(fontFamily: fontFamily),
    );
