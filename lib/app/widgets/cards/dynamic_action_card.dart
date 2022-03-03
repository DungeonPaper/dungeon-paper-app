import 'package:dungeon_paper/app/widgets/atoms/expansion_row.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/dw_icons.dart';
import '../atoms/background_icon_button.dart';
import '../atoms/svg_icon.dart';

class DynamicActionCard extends StatelessWidget {
  const DynamicActionCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.starred,
    required this.dice,
    required this.body,
    this.showStar = true,
    this.starredIcon,
    this.unstarredIcon,
    this.chips = const [],
  }) : super(key: key);

  final String title;
  final Widget icon;
  final Widget? starredIcon;
  final Widget? unstarredIcon;
  final bool starred;
  final bool showStar;
  final List<Dice> dice;
  final List<Widget> body;
  final Iterable<Widget> chips;

  @override
  Widget build(BuildContext context) {
    final expanded = false.obs;

    return Card(
      margin: EdgeInsets.zero,
      child: ExpansionRow(
        title: Text(title),
        onExpansion: (state) => expanded.value = !state,
        leading: icon,
        childrenPadding: const EdgeInsets.all(8).copyWith(top: 0),
        trailing: showStar
            ? SizedBox(
                width: 20,
                height: 20,
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
                  onPressed: () => null,
                ),
              )
            : const SizedBox.shrink(),
        children: [
          ...body,
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              ...chips,
              Expanded(child: Container()),
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
