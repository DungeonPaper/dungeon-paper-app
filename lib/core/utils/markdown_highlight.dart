import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as flutter_markdown;
import 'package:markdown/markdown.dart' as markdown;

class HighlightSyntax extends markdown.InlineSyntax {
  HighlightSyntax() : super('==([^=]+)==');
  // ,
  //       requiresDelimiterRun: true, allowIntraWord: true, tags: [DelimiterTag('mark', 2)]);

  @override
  bool onMatch(markdown.InlineParser parser, Match match) {
    final element = markdown.Element(
        'mark', [markdown.Element.text('span', match.input.substring(match.start + 2, match.end - 2))]);
    parser.addNode(element);
    return true;
  }
}

class HighlightBuilder extends flutter_markdown.MarkdownElementBuilder {
  HighlightBuilder(
    this.context, {
    this.color,
    this.backgroundColor,
    this.textStyle,
  }) : assert(textStyle == null || (color == null && backgroundColor == null));

  /// The text color
  final Color? color;

  /// The background color of the text
  final Color? backgroundColor;

  /// The text style. If textStyle is provided, [color] and [backgroundColor] must be null.
  final TextStyle? textStyle;

  /// The context to build the default text style from
  final BuildContext context;

  @override
  Widget? visitElementAfter(markdown.Element element, TextStyle? preferredStyle) {
    final highlightStyle = getHighlightStyle(
      context,
      override: getDefaultHighlightStyle(context),
      normalStyle: textStyle ?? Theme.of(context).textTheme.bodyMedium!,
    );

    return RichText(
      text: TextSpan(
        text: element.textContent,
        style: highlightStyle,
      ),
    );
  }

  static TextStyle getDefaultHighlightStyle(BuildContext context) => Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Colors.black,
        backgroundColor: Colors.yellow[200],
        fontStyle: FontStyle.italic,
      );

  static TextStyle getNormalStyle(BuildContext context, TextStyle? override) =>
      override ?? Theme.of(context).textTheme.bodyMedium!;

  static TextStyle getHighlightStyle(
    BuildContext context, {
    required TextStyle? override,
    required TextStyle normalStyle,
  }) {
    final defaultHighlightStyle = getDefaultHighlightStyle(context);
    final normalColorBrightness =
        ThemeData.estimateBrightnessForColor(normalStyle.color ?? defaultHighlightStyle.color!);
    final backgroundColor =
        override?.backgroundColor ?? normalStyle.backgroundColor ?? defaultHighlightStyle.backgroundColor!;
    final highlightBackgroundColorBrightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    final brightnessHighlightColor = normalColorBrightness == highlightBackgroundColorBrightness
        ? normalColorBrightness == Brightness.dark
            ? Colors.white
            : Colors.black
        : null;
    return normalStyle.copyWith(
      fontFamily: override?.fontFamily ?? normalStyle.fontFamily ?? defaultHighlightStyle.fontFamily,
      color: override?.color ?? brightnessHighlightColor ?? defaultHighlightStyle.color,
      backgroundColor: backgroundColor,
      fontStyle: override?.fontStyle ?? normalStyle.fontStyle ?? defaultHighlightStyle.fontStyle,
      fontWeight: override?.fontWeight ?? normalStyle.fontWeight ?? defaultHighlightStyle.fontWeight,
    );
  }
}

class HighlightText extends StatelessWidget {
  const HighlightText(
    this.text, {
    super.key,
    required this.highlightWords,
    this.highlightStyle,
    this.normalTextStyle,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.softWrap = true,
  });

  final String text;
  final TextStyle? highlightStyle;
  final TextStyle? normalTextStyle;
  final List<String> highlightWords;
  final TextOverflow overflow;
  final int? maxLines;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    final _text = highlight(text, highlightWords).split('==');
    final normalStyle = HighlightBuilder.getNormalStyle(context, normalTextStyle);
    final hlStyle = HighlightBuilder.getHighlightStyle(
      context,
      normalStyle: normalStyle,
      override: highlightStyle,
    );
    final words = highlightWords.map((word) => word.toLowerCase()).toSet();

    return DefaultTextStyle.merge(
      style: normalStyle,
      child: Builder(builder: (context) {
        var def = DefaultTextStyle.of(context).style;
        return RichText(
          overflow: overflow,
          maxLines: maxLines,
          softWrap: softWrap,
          text: TextSpan(
            children: [
              for (final word in _text)
                if (words.contains(word.toLowerCase()))
                  TextSpan(
                    text: word,
                    style: hlStyle,
                  )
                else
                  TextSpan(
                    text: word,
                    style: def,
                  ),
            ],
            style: highlightStyle,
          ),
        );
      }),
    );
  }

  static String highlight(String text, List<String> highlightWords) {
    for (final word in highlightWords.where((t) => t.isNotEmpty)) {
      text = text.replaceAllMapped(
        RegExp(word.replaceAll('\\', ''), caseSensitive: false),
        (match) => '==${match[0]}==',
      );
    }
    return text;
  }

  static markdownBuilder(BuildContext context, {TextStyle? textStyle}) {
    return HighlightBuilder(context, textStyle: textStyle);
  }
}
