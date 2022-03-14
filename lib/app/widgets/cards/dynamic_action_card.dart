import 'package:dungeon_paper/app/widgets/atoms/expansion_row.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

import '../../../core/dw_icons.dart';
import '../atoms/background_icon_button.dart';
import '../atoms/svg_icon.dart';

class DynamicActionCard extends StatelessWidget {
  const DynamicActionCard({
    Key? key,
    this.expansionKey,
    required this.title,
    required this.icon,
    required this.starred,
    required this.dice,
    required this.description,
    this.initiallyExpanded,
    this.showStar = true,
    this.starredIcon,
    this.unstarredIcon,
    this.chips = const [],
    this.chipsSpacing = 4,
    required this.onStarChanged,
    this.actions = const [],
    this.leading = const [],
    this.trailing = const [],
  }) : super(key: key);

  final String description;
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
  final void Function(bool starred) onStarChanged;
  final Iterable<Widget> actions;
  final Iterable<Widget> trailing;
  final Iterable<Widget> leading;

  @override
  Widget build(BuildContext context) {
    final expanded = false.obs;

    return Card(
      margin: EdgeInsets.zero,
      child: ExpansionRow(
        title: Text(title),
        expansionKey: expansionKey,
        onExpansion: (state) => expanded.value = !state,
        initiallyExpanded: initiallyExpanded,
        childrenPadding: const EdgeInsets.all(8).copyWith(top: 0),
        icon: icon,
        trailing: showStar
            ? [
                ...leading,
                Container(
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
                    onPressed: () => onStarChanged(!starred),
                  ),
                ),
                ...trailing
              ]
            : [...leading, const SizedBox.shrink(), ...trailing],
        children: [
          MarkdownBody(data: description),
          if (description.isNotEmpty) const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Wrap(
                  children: chips
                      .map(
                        (c) => Padding(
                          padding: EdgeInsets.only(right: chipsSpacing),
                          child: c,
                        ),
                      )
                      .toList(),
                ),
              ),
              ...actions,
              if (dice.isNotEmpty)
                BackgroundIconButton(
                  elevation: 1.5,
                  icon: const SvgIcon(DwIcons.dice_d6, size: 20),
                  iconColor: Theme.of(context).colorScheme.onPrimary,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                  onPressed: () => null,
                ),
            ],
          )
        ],
      ),
    );
  }
}
