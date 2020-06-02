import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/edit_armor_dialog.dart';
import 'package:dungeon_paper/src/dialogs/edit_hit_dice_dialog.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:flutter/material.dart';

class ArmorAndHitDice extends StatelessWidget {
  final Character character;

  const ArmorAndHitDice({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          _item(
            context,
            icon: PlatformSvg.asset(
              'armor.svg',
              width: 20,
              height: 20,
            ),
            title: Text('ARMOR'),
            value: Text(character.armor.toString()),
            onTap: () => showDialog(
              context: context,
              builder: (context) => EditArmorDialog(value: character.armor),
            ),
          ),
          _item(
            context,
            icon: PlatformSvg.asset(
              'dice/d20.svg',
              width: 20,
              height: 20,
            ),
            title: Text('HIT DICE'),
            value: Text(character.damageDice.toString()),
            onTap: () => showDialog(
              context: context,
              builder: (context) =>
                  EditHitDiceDialog(dice: character.damageDice),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    Widget icon,
    Widget title,
    Widget value,
    VoidCallback onTap,
  }) {
    TextStyle style = Theme.of(context).textTheme.bodyText2.copyWith();
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DefaultTextStyle(child: title, style: style),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: icon,
              ),
              DefaultTextStyle(child: value, style: style),
            ],
          ),
        ),
      ),
    );
  }
}
