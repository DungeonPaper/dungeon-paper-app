import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_panel.dart';
import 'package:dungeon_paper/app/widgets/atoms/roll_dice_button.dart';
import 'package:dungeon_paper/core/utils/markdown_highlight.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicActionCard extends StatelessWidget {
  const DynamicActionCard({
    Key? key,
    this.expansionKey,
    required this.title,
    required this.icon,
    this.starred = false,
    this.dice = const [],
    required this.description,
    this.explanation,
    this.maxContentHeight,
    this.initiallyExpanded,
    this.showStar = true,
    this.starredIcon,
    this.unstarredIcon,
    this.chips = const [],
    this.chipsSpacing = 4,
    this.onStarChanged,
    this.actions = const [],
    this.leading = const [],
    this.trailing = const [],
    this.expandable = true,
    this.highlightWords = const [],
  }) : super(key: key);

  final bool expandable;
  final double? maxContentHeight;
  final String description;
  final String? explanation;
  final Key? expansionKey;
  final String title;
  final Widget? icon;
  final Widget? starredIcon;
  final Widget? unstarredIcon;
  final bool starred;
  final bool? initiallyExpanded;
  final bool showStar;
  final List<Dice> dice;
  final Iterable<Widget> chips;
  final double chipsSpacing;
  final void Function(bool starred)? onStarChanged;
  final Iterable<Widget> actions;
  final Iterable<Widget> trailing;
  final Iterable<Widget> leading;
  final List<String> highlightWords;

  @override
  Widget build(BuildContext context) {
    final expanded = false.obs;

    return OrientationBuilder(
      builder: (context, orientation) {
        final children = _buildChildren(context);

        var star = Container(
          width: 20,
          height: 20,
          padding: EdgeInsets.only(
            left: leading.isNotEmpty ? 8 : 0,
            right: trailing.isNotEmpty ? 8 : 0,
          ),
          child: IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: IconTheme(
              data: IconTheme.of(context).copyWith(
                size: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              ),
              child: starred
                  ? starredIcon ?? const Icon(Icons.star_rounded)
                  : unstarredIcon ?? const Icon(Icons.star_border_rounded),
            ),
            onPressed: () => onStarChanged?.call(!starred),
          ),
        );

        return Card(
          margin: EdgeInsets.zero,
          elevation: expanded.value ? 5 : 1,
          child: CustomExpansionPanel(
            expandable: expandable,
            title: HighlightText(
              title,
              highlightWords: highlightWords,
              normalTextStyle: Theme.of(context).textTheme.subtitle1,
              textStyle: Theme.of(context).textTheme.subtitle1!,
            ),
            expansionKey: expansionKey,
            onExpansion: (state) => expanded.value = state,
            initiallyExpanded: initiallyExpanded,
            iconColor: Theme.of(context).colorScheme.secondary,
            textColor: Theme.of(context).colorScheme.secondary,
            childrenPadding: const EdgeInsets.all(8).copyWith(top: 0),
            icon: icon,
            trailing: [
              ...leading,
              showStar
                  ? expandable
                      ? star
                      : Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: star,
                        )
                  : const SizedBox.shrink(),
              ...trailing
            ],
            children: maxContentHeight == null
                ? children
                : [
                    ConstrainedBox(
                      constraints: BoxConstraints.loose(Size.fromHeight(maxContentHeight!)),
                      child: ListView(
                        shrinkWrap: true,
                        children: children.sublist(0, children.length - 2),
                      ),
                    ),
                    children[children.length - 1],
                  ],
          ),
        );
      },
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    final dividerColor = Theme.of(context).dividerColor;

    return [
      // Divider(height: 16, color: dividerColor),
      description.isNotEmpty
          ? _renderMarkdown(
              context,
              description,
              // style: Theme.of(context).textTheme.bodyText1,
            )
          : Text(
              S.current.noDescription,
              style: Theme.of(context).textTheme.bodyText1,
            ),
      // Divider(height: 32, color: dividerColor),
      if (explanation != null && explanation!.isNotEmpty) ...[
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 4),
          child: Text(S.current.explanation, style: Theme.of(context).textTheme.caption),
        ),
        _renderMarkdown(context, explanation!),
      ],
      Divider(height: 24, color: dividerColor),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Wrap(
              spacing: chipsSpacing,
              runSpacing: 6,
              children: chips.toList(),
            ),
          ),
          ...actions,
          if (actions.isNotEmpty && dice.isNotEmpty) const SizedBox(width: 8),
          if (dice.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 2.5),
              child: RollDiceButton(dice: dice),
            ),
        ],
      )
    ];
  }

  MarkdownBody _renderMarkdown(BuildContext context, String text, {TextStyle? style}) {
    return MarkdownBody(
      data: _highlight(text),
      onTapLink: (text, href, title) => launch(href!),
      inlineSyntaxes: [HighlightSyntax()],
      builders: {
        'mark': HighlightBuilder(context, textStyle: style),
      },
    );
  }

  String _highlight(String text) {
    for (final word in highlightWords) {
      text = text.replaceAllMapped(
        RegExp(word.replaceAll('\\', ''), caseSensitive: false),
        (match) => '==${match[0]}==',
      );
    }
    return text;
  }
}

class HighlightText extends StatelessWidget {
  const HighlightText(
    this.text, {
    super.key,
    required this.highlightWords,
    this.textStyle,
    this.normalTextStyle,
  });

  final String text;
  final TextStyle? textStyle;
  final TextStyle? normalTextStyle;
  final List<String> highlightWords;

  @override
  Widget build(BuildContext context) {
    final _text = _highlight(text).split('==');
    final normalStyle = normalTextStyle ?? Theme.of(context).textTheme.bodyMedium!;
    final defaultHighlightStyle = HighlightBuilder.getDefaultHighlightStyle(context);
    final highlightStyle = normalStyle.copyWith(
      color: defaultHighlightStyle.color,
      backgroundColor: defaultHighlightStyle.backgroundColor,
      fontStyle: defaultHighlightStyle.fontStyle,
    );
    final words = highlightWords.map((word) => word.toLowerCase()).toSet();

    return DefaultTextStyle.merge(
      child: RichText(
        text: TextSpan(
          children: [
            for (final word in _text)
              if (words.contains(word.toLowerCase()))
                TextSpan(
                  text: word,
                  style: highlightStyle,
                )
              else
                TextSpan(
                  text: word,
                  style: normalStyle,
                ),
          ],
          style: textStyle,
        ),
      ),
    );
  }

  String _highlight(String text) {
    for (final word in highlightWords) {
      text = text.replaceAllMapped(
        RegExp(word.replaceAll('\\', ''), caseSensitive: false),
        (match) => '==${match[0]}==',
      );
    }
    return text;
  }
}
