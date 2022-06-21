import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/widgets/atoms/expansion_row.dart';
import 'package:dungeon_paper/app/widgets/atoms/roll_dice_button.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/dw_icons.dart';
import '../atoms/background_icon_button.dart';

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
          child: ExpansionRow(
            expandable: expandable,
            title: Text(title),
            expansionKey: expansionKey,
            onExpansion: (state) => expanded.value = state,
            initiallyExpanded: initiallyExpanded,
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
          ? MarkdownBody(data: description, onTapLink: (text, href, title) => launch(href!))
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
        MarkdownBody(data: explanation!, onTapLink: (text, href, title) => launch(href!)),
      ],
      Divider(height: 24, color: dividerColor),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Wrap(
              spacing: chipsSpacing,
              runSpacing: 0,
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
}
