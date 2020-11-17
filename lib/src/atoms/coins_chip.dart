import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/edit_coins_dialog.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CoinsChip extends StatelessWidget {
  final Character character;

  const CoinsChip({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Coins',
      child: ActionChip(
        onPressed: () {
          analytics.logEvent(name: Events.OpenCoinsChip);
          showDialog(
            context: context,
            builder: (context) => EditCoinsDialog(value: character.coins),
          );
        },
        visualDensity: VisualDensity.compact,
        backgroundColor: Color(0xFFF5EB6B),
        padding: EdgeInsets.all(8),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PlatformSvg.asset(
              'coin-stack.svg',
              size: 20,
            ),
            SizedBox.fromSize(size: Size.square(10)),
            Text(currency(character.coins))
          ],
        ),
      ),
    );
  }
}
