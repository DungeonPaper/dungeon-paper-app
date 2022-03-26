import 'package:dungeon_paper/app/widgets/atoms/expansion_row.dart';
import 'package:dungeon_paper/generated/l10n.dart';
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
    required this.explanation,
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
  final String explanation;
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

    var dividerColor = Theme.of(context).colorScheme.onBackground.withOpacity(0.3);
    return Obx(
      () => Card(
        margin: EdgeInsets.zero,
        elevation: expanded.value == true ? 5 : 1,
        child: ExpansionRow(
          title: Text(title),
          expansionKey: expansionKey,
          onExpansion: (state) => expanded.value = state,
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
            // Divider(height: 16, color: dividerColor),
            description.isNotEmpty
                ? MarkdownBody(data: description)
                : Text(
                    S.current.noDescription,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
            // Divider(height: 32, color: dividerColor),
            if (explanation.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 4),
                child: Text(S.current.explanation, style: Theme.of(context).textTheme.caption),
              ),
              MarkdownBody(data: explanation),
            ],
            Divider(height: 32, color: dividerColor),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: chipsSpacing,
                    runSpacing: chipsSpacing,
                    children: chips.toList(),
                  ),
                ),
                ...actions,
                if (actions.isNotEmpty && dice.isNotEmpty) const SizedBox(width: 8),
                if (dice.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.5),
                    child: BackgroundIconButton(
                      elevation: 1.5,
                      icon: const SvgIcon(DwIcons.dice_d6, size: 20),
                      iconColor: Theme.of(context).colorScheme.onPrimary,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                      onPressed: () => null,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
