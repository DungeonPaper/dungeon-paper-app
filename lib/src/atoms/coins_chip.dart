import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/edit_coins_dialog.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
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
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => EditCoinsDialog(value: character.coins),
        );
      },
      child: Chip(
        backgroundColor: Theme.of(context).primaryColorLight,
        padding: EdgeInsets.all(12.0),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PlatformSvg.asset(
              'coin-stack.svg',
              width: 20,
            ),
            SizedBox.fromSize(size: Size.square(10)),
            Text(currency(character.coins))
          ],
        ),
      ),
    );
  }
}
