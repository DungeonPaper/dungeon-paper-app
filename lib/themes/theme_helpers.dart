import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final r = color.red, g = color.green, b = color.blue;

  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

final cardRadius = BorderRadius.circular(15);

ThemeData createTheme({Color primary, Color secondary}) {
  final cardRect = RoundedRectangleBorder(borderRadius: cardRadius);
  final cardColor = Colors.white.withOpacity(0.85);
  final normalInputBorder = OutlineInputBorder(
    borderRadius: cardRadius,
    borderSide: BorderSide(
      width: 1,
      color: Color(0xFF000000).withOpacity(0.2),
    ),
  );

  return ThemeData(
    primarySwatch: createMaterialColor(primary),
    accentColor: secondary,
    scaffoldBackgroundColor: primary,
    cardColor: cardColor,
    fontFamily: 'Nunito',
    textTheme: TextTheme(
      headline6: TextStyle(color: secondary),
    ),
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: secondary,
      onBackground: secondary,
      onSecondary: Colors.white,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: secondary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      filled: true,
      border: normalInputBorder,
      enabledBorder: normalInputBorder,
      fillColor: Colors.white.withOpacity(0.5),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      focusedBorder: OutlineInputBorder(
        borderRadius: cardRadius,
        borderSide: BorderSide(
          width: 2,
          color: secondary,
        ),
      ),
      labelStyle: TextStyle(
        color: secondary,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      shape: cardRect,
      color: cardColor.withOpacity(1),
    ),
    cardTheme: CardTheme(
      shape: cardRect,
    ),
    buttonTheme: ButtonThemeData(
      shape: cardRect,
    ),
    dialogTheme: DialogTheme(
      shape: cardRect,
    ),
  );
}
