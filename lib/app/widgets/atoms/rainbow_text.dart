import 'dart:ui' as ui show TextHeightBehavior;

import 'package:dungeon_paper/core/utils/color_utils.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum SplitMode {
  characters,
  words,
  custom,
}

class RainbowText extends StatelessWidget {
  const RainbowText(
    this.text, {
    super.key,
    this.splitMode = SplitMode.characters,
    this.pattern,
    this.joiner,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.selectionRegistrar,
    this.selectionColor,
  }) : assert(splitMode != SplitMode.custom || pattern != null);

  final SplitMode splitMode;
  final String text;
  final Pattern? pattern;
  final String? joiner;

  // taken from RichText
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final SelectionRegistrar? selectionRegistrar;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    Pattern splitPattern = splitMode == SplitMode.characters
        ? ''
        : splitMode == SplitMode.words
            ? ' '
            : pattern!;
    final split = text.split(splitPattern);
    final rainbow = ColorUtils.generateRainbow(split.length);
    final _joiner = joiner ??
        (splitMode == SplitMode.characters
            ? ''
            : splitMode == SplitMode.words
                ? ' '
                : '');
    return RichText(
      text: TextSpan(
        children: [
          for (final i in enumerate(split))
            TextSpan(
              text: i.value + _joiner,
              style: textTheme.bodyMedium!.copyWith(color: rainbow[i.index]),
            ),
        ],
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionRegistrar: selectionRegistrar,
      selectionColor: selectionColor,
    );
  }
}
