import 'package:flutter/material.dart' as m;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart';

class HighlightSyntax extends InlineSyntax {
  HighlightSyntax() : super('==([^=]+)==');
  // ,
  //       requiresDelimiterRun: true, allowIntraWord: true, tags: [DelimiterTag('mark', 2)]);

  @override
  bool onMatch(InlineParser parser, Match match) {
    final element = Element(
        'mark', [Element.text('span', match.input.substring(match.start + 2, match.end - 2))]);
    parser.addNode(element);
    return true;
  }
}

class HighlightBuilder extends MarkdownElementBuilder {
  HighlightBuilder(
    this.context, {
    this.color,
    this.backgroundColor,
    this.textStyle,
  }) : assert(textStyle == null || (color == null && backgroundColor == null));

  /// The text color
  final m.Color? color;

  /// The background color of the text
  final m.Color? backgroundColor;

  /// The text style. If textStyle is provided, [color] and [backgroundColor] must be null.
  final m.TextStyle? textStyle;

  /// The context to build the default text style from
  final m.BuildContext context;

  @override
  m.Widget? visitElementAfter(Element element, m.TextStyle? preferredStyle) {
    final highlightStyle = textStyle ??
        getDefaultHighlightStyle(context).copyWith(
          color: color,
          backgroundColor: backgroundColor,
        );

    return m.RichText(
      text: m.TextSpan(
        text: element.textContent,
        style: highlightStyle,
      ),
    );
  }

  static m.TextStyle getDefaultHighlightStyle(m.BuildContext context) =>
      m.Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: m.Colors.black,
            backgroundColor: m.Colors.yellow[200],
            fontStyle: m.FontStyle.italic,
          );
}
