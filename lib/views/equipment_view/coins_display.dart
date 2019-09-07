import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'edit_coins_dialog.dart';

class CoinsDisplay extends StatelessWidget {
  final DbCharacter character;

  const CoinsDisplay({
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
            SvgPicture.asset(
              'assets/coin-stack.svg',
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
