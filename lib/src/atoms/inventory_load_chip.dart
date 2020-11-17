import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InventoryLoadChip extends StatelessWidget {
  final Character character;

  const InventoryLoadChip({
    Key key,
    @required this.character,
  }) : super(key: key);

  num get maxLoad => character.maxLoad;
  num get currentLoad => character.load;

  BgAndFgColors get severity {
    if (isOverEncumbered) {
      return BgAndFgColors(Colors.red[400], Colors.white);
    }
    if (currentLoadPercent >= 0.7) {
      return BgAndFgColors(Colors.yellow[200], Colors.black);
    }
    return BgAndFgColors(Colors.green[500], Colors.black);
  }

  double get currentLoadPercent => currentLoad * 1.0 / maxLoad;
  bool get isOverEncumbered => currentLoadPercent >= 1;

  @override
  Widget build(BuildContext context) {
    var ttMsg = 'The weight you can carry.';
    if (isOverEncumbered) {
      ttMsg += '\nYou are over-encumbered!';
    }
    return Tooltip(
      message: ttMsg,
      child: Chip(
        visualDensity: VisualDensity.compact,
        backgroundColor: severity.background,
        padding: EdgeInsets.all(8),
        label: DefaultTextStyle.merge(
          style: TextStyle(color: severity.foreground),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('LOAD'),
              SizedBox.fromSize(size: Size.square(10)),
              PlatformSvg.asset(
                'dumbbell.svg',
                size: 20,
                color: severity.foreground,
              ),
              SizedBox.fromSize(size: Size.square(10)),
              Text(commatize(currentLoad) + '/' + commatize(maxLoad)),
            ],
          ),
        ),
      ),
    );
  }
}
