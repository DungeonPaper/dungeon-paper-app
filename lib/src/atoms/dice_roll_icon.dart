import 'dart:math';

import 'package:dungeon_paper/src/atoms/dice_icon.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/dw_data.dart' show DiceResult;
import 'package:flutter/material.dart';

class DiceRollIcon extends StatelessWidget {
  const DiceRollIcon({
    Key key,
    @required this.animation,
    @required this.dice,
    @required this.size,
    @required this.result,
  }) : super(key: key);

  final Animation<double> animation;
  final Enumeration<Dice> dice;
  final DiceResult result;
  final double size;

  static const SPIN_COUNT = 3;

  Offset get diceOffset => dice.value.sides == 4 ? Offset(0, -5) : Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
        opacity: min(1, animation.value + 0.3),
        child: Transform.translate(
          offset: -diceOffset,
          child: Transform.rotate(
            angle: 360 * (pi / 180) * SPIN_COUNT * animation.value,
            child: child,
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Transform.translate(
              offset: diceOffset,
              child: DiceIcon(
                dice: dice.value,
                size: size,
                color: Color.lerp(
                  Colors.grey,
                  result != null
                      ? result.results[dice.index] == 1
                          ? Colors.red
                          : result.results[dice.index] == dice.value.sides
                              ? Colors.green
                              : Colors.grey
                      : Colors.black,
                  animation.value,
                ),
              ),
            ),
            child: null,
          ),
          if (result != null) ...[
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Transform.scale(
                scale: animation.value,
                child: Opacity(
                  opacity: animation.value,
                  child: child,
                ),
              ),
              child: Text(
                result.results[dice.index].toString(),
                style: TextStyle(
                  fontSize: 30,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.black,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Transform.scale(
                scale: animation.value,
                child: Opacity(
                  opacity: animation.value,
                  child: child,
                ),
              ),
              child: Text(
                result.results[dice.index].toString(),
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
