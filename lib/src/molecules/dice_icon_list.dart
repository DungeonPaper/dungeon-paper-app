import 'package:dungeon_paper/src/atoms/dice_roll_icon.dart';
import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';

class DiceIconList extends StatelessWidget {
  final double iconSize;
  final DiceListController controller;
  final List<Animation> animations;

  const DiceIconList({
    Key key,
    @required this.controller,
    @required this.animations,
    this.iconSize = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var dice in enumerate(controller.flat))
          Padding(
            padding: EdgeInsets.all(8),
            child: DiceRollIcon(
              // key: Key(
              //     'anim-${dice.index}-${dice.value}-${_ctrl.length > dice.index ? _ctrl[dice.index].result.toString() : '0'}'),
              animation: animations != null && animations.length > dice.index
                  ? animations[dice.index]
                  : AlwaysStoppedAnimation(1.0),
              dice: dice,
              result: controller.flatResults.length > dice.index
                  ? controller.flatResults[dice.index]
                  : null,
              size: iconSize,
            ),
          ),
      ],
    );
  }
}
