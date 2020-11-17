import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArmorChip extends StatelessWidget {
  final Character character;

  const ArmorChip({
    Key key,
    @required this.character,
  }) : super(key: key);

  num get armor => character.armor;

  @override
  Widget build(BuildContext context) {
    return Chip(
      visualDensity: VisualDensity.compact,
      backgroundColor: Colors.grey[700],
      padding: EdgeInsets.all(8),
      label: IconTheme(
        data: IconThemeData(color: Colors.white),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ARMOR'),
              SizedBox(width: 10),
              PlatformSvg.asset(
                'armor.svg',
                size: 20,
              ),
              SizedBox(width: 10),
              Text('$armor'),
            ],
          ),
        ),
      ),
    );
  }
}
