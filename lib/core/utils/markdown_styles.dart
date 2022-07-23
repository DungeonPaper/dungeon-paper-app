import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownStyles {
  static of(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final mdTheme = MarkdownStyleSheet.fromTheme(theme);
    return mdTheme.copyWith(
      h1: _headingTheme(textTheme.headline1!, mdTheme.h1!),
      h2: _headingTheme(textTheme.headline2!, mdTheme.h2!),
      h3: _headingTheme(textTheme.headline3!, mdTheme.h3!),
      h4: _headingTheme(textTheme.headline4!, mdTheme.h4!, textScaleFactor: 0.93),
      h5: _headingTheme(textTheme.headline5!, mdTheme.h5!, textScaleFactor: 0.88),
      h6: _headingTheme(textTheme.headline6!, mdTheme.h6!, textScaleFactor: 0.8),
      blockquotePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      blockquoteDecoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: theme.dividerColor,
            width: 4,
          ),
        ),
      ),
    );
  }

  static _headingTheme(
    TextStyle normalStyle,
    TextStyle mdStyle, {
    double? textScaleFactor,
  }) =>
      mdStyle.copyWith(
        // color: normalStyle.color,
        fontSize: mdStyle.fontSize! * (textScaleFactor ?? 1.0),
      );
  // normalStyle.copyWith(
  //   fontSize: mdStyle.fontSize! * (textScaleFactor ?? 1.0),
  // );
}
