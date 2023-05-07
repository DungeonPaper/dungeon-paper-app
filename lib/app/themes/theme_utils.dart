import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

final borderRadius = BorderRadius.circular(20);
final rRectShape = RoundedRectangleBorder(borderRadius: borderRadius);

const lightColorScheme = ColorScheme.light();
const darkColorScheme = ColorScheme.dark();

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
      displayLarge: original.displayLarge?.copyWith(fontFamily: fontFamily, color: specialColor),
      displayMedium: original.displayMedium?.copyWith(fontFamily: fontFamily, color: specialColor),
      displaySmall: original.displaySmall?.copyWith(fontFamily: fontFamily, color: specialColor),
      headlineMedium: original.headlineMedium?.copyWith(fontFamily: fontFamily, color: specialColor),
      headlineSmall: original.headlineSmall?.copyWith(fontFamily: fontFamily, color: specialColor),
      titleLarge: original.titleLarge?.copyWith(fontFamily: fontFamily, color: specialColor),
      titleMedium: original.titleMedium?.copyWith(fontFamily: fontFamily, color: specialColor),
      titleSmall: original.titleSmall?.copyWith(fontFamily: fontFamily, color: specialColor),
      bodyLarge: original.bodyLarge?.copyWith(fontFamily: fontFamily, color: normalColor),
      bodyMedium: original.bodyMedium?.copyWith(fontFamily: fontFamily, color: normalColor),
      bodySmall: original.bodySmall?.copyWith(fontFamily: fontFamily, color: normalColor),
      labelLarge: original.labelLarge?.copyWith(fontFamily: fontFamily, color: normalColor),
      labelSmall: original.labelSmall?.copyWith(fontFamily: fontFamily, color: normalColor),
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
    onSecondary: ThemeData.estimateBrightnessForColor(secondary ?? defaultBase.secondary) == Brightness.light
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
      systemOverlayStyle: getUiOverlayStyleFor(base).copyWith(statusBarColor: Colors.transparent),
    ),
    checkboxTheme: base.checkboxTheme.copyWith(
      fillColor: MaterialStateProperty.resolveWith((states) => colorScheme.secondary),
      checkColor: MaterialStateProperty.resolveWith((states) => colorScheme.onSecondary),
    ),
    switchTheme: base.switchTheme.copyWith(
      thumbColor: MaterialStateProperty.resolveWith((states) => colorScheme.secondary),
      trackColor: MaterialStateProperty.resolveWith((states) => colorScheme.secondaryContainer),
    ),
    dialogTheme: base.dialogTheme.copyWith(
      shape: rRectShape,
    ),
    chipTheme: base.chipTheme.copyWith(shape: rRectShape),
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

SystemUiOverlayStyle getUiOverlayStyleFor(ThemeData theme) =>
    theme.brightness == Brightness.light ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
