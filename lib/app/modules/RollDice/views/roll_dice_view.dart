import 'dart:math';

import 'package:dungeon_paper/app/widgets/atoms/dice_icon.dart';
import 'package:dungeon_paper/core/utils/grid_point.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/roll_dice_controller.dart';

class RollDiceView extends StatefulWidget {
  const RollDiceView({Key? key}) : super(key: key);

  @override
  State<RollDiceView> createState() => _RollDiceViewState();
}

class _RollDiceViewState extends State<RollDiceView> with SingleTickerProviderStateMixin {
  final diceSize = 56.0;
  final diceSpacing = 24.0;
  late AnimationStatus rollStatus;
  late final Animation<double> yAnim;
  late final Animation<double> rotateAnim;
  late final AnimationController animController;
  // late final Tween<double> yTween;
  // late final Tween<double> rotateTween;
  // late final AnimationController rotateAnimController;
  RollDiceController get controller => Get.find();

  @override
  void initState() {
    super.initState();

    final tween = Tween<double>(begin: 1, end: 0);
    animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    rotateAnim = tween.animate(animController.drive(
      CurveTween(curve: Curves.easeOutQuad),
    ));
    yAnim = tween.animate(animController.drive(
      CurveTween(curve: Curves.fastOutSlowIn),
    ));
    yAnim.addListener(() {
      setState(() {});
    });
    yAnim.addStatusListener((status) {
      setState(() {
        rollStatus = status;
      });
    });
    animController.forward();
    // rollStatus = yAnim.status;
  }

  @override
  Widget build(BuildContext context) {
    var bgColor = Colors.black.withOpacity(0.85);
    return Scaffold(
      appBar: AppBar(
        title: Text(rollStatus == AnimationStatus.completed
            ? 'Result: ${controller.totalResult}'
            : 'Rolling ${controller.flat.length} dice'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: bgColor,
      body: LayoutBuilder(builder: (context, constraints) {
        final columnCount = constraints.maxWidth ~/ (diceSize + diceSpacing + (diceSpacing * 4));
        final rowCount = GridPoint.fromIndex(controller.dice.length - 1, columnCount).row + 1;
        const maxHeightBuffer = 125;
        final maxHeight = MediaQuery.of(context).size.height;
        final topPadding = constraints.maxHeight / 3 - rowCount * diceSize;

        return Center(
          child: SingleChildScrollView(
            child: Container(
              // color: Colors.red,
              width: columnCount * (diceSize + diceSpacing),
              // height: max(
              //   rowCount * (diceSize + diceSpacing) - diceSpacing * 1.5,
              //   min(
              //     constraints.maxHeight,
              //     maxHeight - maxHeightBuffer,
              //   ),
              // ),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: diceSpacing,
                spacing: diceSpacing,
                children: [
                  for (final dice in enumerate(controller.flat))
                    Transform.translate(
                      offset: Offset(
                        0,
                        yAnim.value * maxHeight,
                      ),
                      child: Transform.rotate(
                        angle: degToRad(720 * rotateAnim.value),
                        child: DiceIcon.from(
                          dice.value,
                          size: diceSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  double getTop(int index, int columnCount) {
    return GridPoint.fromIndex(index, columnCount).row * (diceSize + diceSpacing);
  }

  double getLeft(int index, int columnCount) {
    return GridPoint.fromIndex(index, columnCount).col * (diceSize + diceSpacing);
  }
}
