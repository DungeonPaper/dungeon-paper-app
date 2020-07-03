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

  num get currentLoad {
    var count = 0.0;
    character.inventory.forEach((item) {
      var wght =
          item.tags?.firstWhere((t) => t?.name == 'weight', orElse: () => null);
      if (wght != null && wght.hasValue) {
        num wghtValue = 0;
        if (wght.value is num) {
          wghtValue += wght.value;
        } else {
          wghtValue += double.tryParse(wght.value ?? 0) ?? 0.0;
        }
        count += wghtValue * item.amount;
      }
    });
    return count;
  }

  BgAndFgColors get severity {
    if (isOverEncumbered) {
      return BgAndFgColors(Colors.red[400], Colors.white);
    }
    if (currentLoadPercent >= 0.7) {
      return BgAndFgColors(Colors.yellow[200], Colors.black);
    }
    return BgAndFgColors(Colors.green[300], Colors.black);
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
        backgroundColor: severity.background,
        padding: EdgeInsets.all(12.0),
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
