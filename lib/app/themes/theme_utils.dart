import 'package:flutter/material.dart';

import 'colors.dart';

final borderRadius = BorderRadius.circular(20);
final rRectShape = RoundedRectangleBorder(borderRadius: borderRadius);

final lightColorScheme = ColorScheme.light();
final darkColorScheme = ColorScheme.dark();

final lightM3 = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  primaryColor: lightColorScheme.primary,
);

final darkM3 = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  primaryColor: darkColorScheme.primary,
);

final baseCardTheme = lightM3.cardTheme.copyWith(shape: rRectShape);
final inputBorderRadius = borderRadius;
final inputDecorationTheme = InputDecorationTheme(
  floatingLabelBehavior: FloatingLabelBehavior.always,
  filled: true,
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: inputBorderRadius,
  ),
);

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

ColorScheme createColorScheme(Color seedColor,
    {required Brightness brightness, Color? secondary, Color? primary, bool highContrast = false}) {
  final defaultBase = brightness == Brightness.light
      ? !highContrast
          ? const ColorScheme.light()
          : const ColorScheme.highContrastLight()
      : !highContrast
          ? const ColorScheme.dark()
          : const ColorScheme.highContrastDark();
  return ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: seedColor,
    primary: primary,
    secondary: secondary,
    onSecondary:
        ThemeData.estimateBrightnessForColor(secondary ?? defaultBase.secondary) == Brightness.light
            ? Colors.black
            : Colors.white,
  );
}

ThemeData createTheme(
  ColorScheme colorScheme, {
  Color? scaffoldBackgroundColor,
  Color? surfaceColor,
  required Brightness brightness,
}) {
  final textTheme = brightness == Brightness.light ? lightM3.textTheme : darkM3.textTheme;
  final base = ThemeData.from(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: copyTextThemeWith(textTheme, fontFamily: 'Nunito'),
  );

  return base.copyWith(
    useMaterial3: true,
    splashColor: colorScheme.secondary.withOpacity(0.1),
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: Colors.transparent,
      foregroundColor: base.colorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
    ),
    dialogTheme: base.dialogTheme.copyWith(
      shape: rRectShape,
    ),
    cardColor: surfaceColor,
    cardTheme: base.cardTheme.copyWith(shape: rRectShape, color: surfaceColor),
    popupMenuTheme: base.popupMenuTheme.copyWith(
      shape: rRectShape,
    ),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: inputBorderRadius,
      ),
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: DwColors.success,
      foregroundColor: Colors.white,
    ),
    tabBarTheme: base.tabBarTheme.copyWith(
      labelStyle: base.textTheme.bodyMedium!.copyWith(fontFamily: 'Nunito'),
      unselectedLabelStyle: base.textTheme.bodyMedium!.copyWith(fontFamily: 'Nunito'),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: colorScheme.secondary,
          width: 4,
        ),
      ),
    ),
  );
}

Brightness getCurrentPlatformBrightness() =>
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness;
