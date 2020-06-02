import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/widgets.dart';

class DiceIcon extends StatelessWidget {
  final Dice dice;
  final double size;
  final Color color;

  const DiceIcon({
    Key key,
    @required this.dice,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformSvg.asset(
      'dice/d${dice.sides}.svg',
      width: size,
      height: size,
      color: color,
    );
  }
}
