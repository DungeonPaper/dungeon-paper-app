import 'package:dungeon_paper/src/atoms/dice_roll_icon.dart';
import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class DiceIconList extends StatelessWidget {
  final double iconSize;
  final DiceListController controller;
  final List<List<Animation>> animations;

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
        for (var group in enumerate(controller.value))
          for (var dice in enumerate(List.generate(
              group.value.amount, (idx) => Dice(group.value.sides, 1))))
            Padding(
              padding: EdgeInsets.all(8),
              child: DiceRollIcon(
                // key: Key(
                //     'anim-${dice.index}-${dice.value}-${_ctrl.length > dice.index ? _ctrl[dice.index].result.toString() : '0'}'),
                animation: animations != null &&
                        animations.length > group.index &&
                        animations[group.index].length > dice.index
                    ? animations[group.index][dice.index]
                    : AlwaysStoppedAnimation(1.0),
                dice: dice,
                result: controller.results != null &&
                        controller.results.length > group.index
                    ? controller.results[group.index]
                    : null,
                size: iconSize,
              ),
            ),
      ],
    );
  }
}
