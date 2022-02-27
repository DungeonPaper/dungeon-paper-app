import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

import '../../../core/dw_icons.dart';
import '../atoms/background_icon_button.dart';
import '../atoms/svg_icon.dart';

class DynamicActionCardMini extends StatelessWidget {
  const DynamicActionCardMini({
    Key? key,
    required this.title,
    required this.icon,
    required this.starred,
    required this.dice,
    required this.description,
    required this.chips,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final bool starred;
  final List<Dice> dice;
  final String description;
  final Iterable<Widget> chips;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconTheme(data: IconTheme.of(context).copyWith(size: 20), child: icon),
                const SizedBox(width: 8),
                Text(title),
                Expanded(child: Container()),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    iconSize: 16,
                    icon: Icon(
                      starred ? Icons.star_rounded : Icons.star_border_rounded,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    ),
                    onPressed: () => null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              description,
              overflow: TextOverflow.ellipsis,
              maxLines: dice.isNotEmpty ? 3 : 4,
              textScaleFactor: 0.9,
              style: const TextStyle(fontWeight: FontWeight.w200),
            ),
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
      ),
    );
  }
}
