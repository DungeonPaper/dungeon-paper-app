import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_panel.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_tile.dart';
import 'package:dungeon_paper/app/widgets/atoms/roll_dice_button.dart';
import 'package:dungeon_paper/core/utils/markdown_highlight.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicActionCard extends StatefulWidget {
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
    this.onExpansion,
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
  final void Function(bool)? onExpansion;
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
  State<DynamicActionCard> createState() => _DynamicActionCardState();
}

class _DynamicActionCardState extends State<DynamicActionCard> {
  late bool expanded;

  @override
  void initState() {
    super.initState();
    expanded = widget.initiallyExpanded ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final children = _buildChildren(context);
        var star = Container(
          width: 20,
          height: 20,
          padding: EdgeInsets.only(
            left: widget.leading.isNotEmpty ? 8 : 0,
            right: widget.trailing.isNotEmpty ? 8 : 0,
          ),
          child: IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: IconTheme(
              data: IconTheme.of(context).copyWith(
                size: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              ),
              child: widget.starred
                  ? widget.starredIcon ?? const Icon(Icons.star_rounded)
                  : widget.unstarredIcon ?? const Icon(Icons.star_border_rounded),
            ),
            onPressed: () => widget.onStarChanged?.call(!widget.starred),
          ),
        );

        return Card(
          margin: EdgeInsets.zero,
          elevation: expanded ? 5 : 1,
          child: CustomExpansionPanel(
            expandable: widget.expandable,
            titleBuilder: (context, color) => HighlightText(
              widget.title,
              highlightWords: widget.highlightWords,
              normalTextStyle: TextStyle(
                fontSize: Theme.of(context).textTheme.subtitle1!.fontSize,
                color: color,
              ),
              // highlightStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: color),
            ),
            key: widget.expansionKey,
            onExpansion: (val) {
              setState(() {
                expanded = val;
              });
              widget.onExpansion?.call(val);
            },
            initiallyExpanded: widget.initiallyExpanded ?? false,
            iconColor: Theme.of(context).colorScheme.secondary,
            textColor: Theme.of(context).colorScheme.secondary,
            childrenPadding: const EdgeInsets.all(8).copyWith(top: 0),
            icon: widget.icon,
            trailing: [
              ...widget.leading,
              widget.showStar
                  ? widget.expandable
                      ? star
                      : Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: star,
                        )
                  : const SizedBox.shrink(),
              ...widget.trailing
            ],
            children: widget.maxContentHeight == null
                ? children
                : [
                    ConstrainedBox(
                      constraints: BoxConstraints.loose(Size.fromHeight(widget.maxContentHeight!)),
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
      widget.description.isNotEmpty
          ? _renderMarkdown(
              context,
              widget.description,
              // style: Theme.of(context).textTheme.bodyText1,
            )
          : Text(
              S.current.noDescription,
              style: Theme.of(context).textTheme.bodyText1,
            ),
      // Divider(height: 32, color: dividerColor),
      if (widget.explanation != null && widget.explanation!.isNotEmpty) ...[
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 4),
          child: Text(S.current.explanation, style: Theme.of(context).textTheme.caption),
        ),
        _renderMarkdown(context, widget.explanation!),
      ],
      Divider(height: 24, color: dividerColor),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Wrap(
              spacing: widget.chipsSpacing,
              runSpacing: 6,
              children: widget.chips.toList(),
            ),
          ),
          ...widget.actions,
          if (widget.actions.isNotEmpty && widget.dice.isNotEmpty) const SizedBox(width: 8),
          if (widget.dice.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 2.5),
              child: RollDiceButton(dice: widget.dice),
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
        'mark': HighlightText.markdownBuilder(context),
      },
    );
  }

  String _highlight(String text) {
    for (final word in widget.highlightWords) {
      text = text.replaceAllMapped(
        RegExp(word.replaceAll('\\', ''), caseSensitive: false),
        (match) => '==${match[0]}==',
      );
    }
    return text;
  }
}
