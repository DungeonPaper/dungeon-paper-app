import 'package:dungeon_paper/app/widgets/atoms/background_icon_button.dart';
import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/dw_icons.dart';
import '../../data/models/move.dart';
import '../atoms/svg_icon.dart';

class MoveCardMini extends StatelessWidget {
  const MoveCardMini({Key? key, required this.move}) : super(key: key);

  final Move move;

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
                IconTheme(data: IconTheme.of(context).copyWith(size: 20), child: move.icon),
                const SizedBox(width: 8),
                Text(move.name),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              move.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textScaleFactor: 0.9,
              style: const TextStyle(fontWeight: FontWeight.w200),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                MoveCategoryChip(category: move.category),
                Expanded(child: Container()),
                BackgroundIconButton(
                  elevation: 1.5,
                  icon: SvgIcon(DwIcons.dice_d6, size: 20),
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
