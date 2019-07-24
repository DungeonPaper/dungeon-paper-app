import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadDisplay extends StatelessWidget {
  final DbCharacter character;

  const LoadDisplay({
    Key key,
    @required this.character,
  }) : super(key: key);

  num get maxLoad =>
      character.mainClass.load + DbCharacter.statModifier(character.str);

  num get currentLoad {
    double count = 0.0;
    character.inventory.forEach((item) {
      Tag wght =
          item.tags?.firstWhere((t) => t.name == 'weight', orElse: () => null);
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
    double perc = currentLoad * 1.0 / maxLoad;
    if (perc >= 0.7) {
      return BgAndFgColors(Colors.red[400], Colors.white);
    }
    if (perc >= 0.4) {
      return BgAndFgColors(Colors.yellow[200], Colors.black);
    }
    return BgAndFgColors(Colors.green[300], Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Encumbrance',
      child: Chip(
        backgroundColor: severity.background,
        padding: EdgeInsets.all(12.0),
        label: DefaultTextStyle.merge(
          style: TextStyle(color: severity.foreground),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ENC.'),
              SizedBox.fromSize(size: Size.square(10)),
              SvgPicture.asset(
                'assets/dumbbell.svg',
                width: 20,
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
