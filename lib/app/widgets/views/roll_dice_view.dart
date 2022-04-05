import 'dart:math';

import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/dice_icon.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/grid_point.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

class RollDiceView extends StatefulWidget {
  final List<dw.Dice> dice;

  const RollDiceView({
    Key? key,
    required this.dice,
  }) : super(key: key);

  @override
  State<RollDiceView> createState() => _RollDiceViewState();
}

class _RollDiceViewState extends State<RollDiceView> with SingleTickerProviderStateMixin {
  final diceSize = 56.0;
  final diceSpacing = 24.0;
  late AnimationStatus rollStatus;

  late Animation<double> yAnim;
  late Animation<double> rotateAnim;
  late Animation<double> opacityAnim;
  late AnimationController animController;

  late List<List<_AnimSet>> anims;

  late List<dw.Dice> dice;
  var results = <dw.DiceRoll>[];
  CharacterService get charService => Get.find();

  @override
  void initState() {
    super.initState();
    dice = _applyMods(widget.dice);
    roll();
    _setupAnimations();
  }

  void _setupAnimations() {
    final forwardTween = Tween<double>(begin: 0, end: 1);
    final reverseTween = Tween<double>(begin: 1, end: 0);

    animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));
    rotateAnim = reverseTween.animate(CurvedAnimation(
      parent: animController,
      curve: const Interval(0, 0.75, curve: Curves.easeOutQuad),
    ));
    yAnim = reverseTween.animate(CurvedAnimation(
      parent: animController,
      curve: const Interval(0, 0.75, curve: Curves.fastOutSlowIn),
    ));
    opacityAnim = forwardTween.animate(CurvedAnimation(
      parent: animController,
      curve: const Interval(0.75, 1, curve: Curves.easeOutCubic),
    ));
    yAnim.addListener(_setEmptyState);
    yAnim.addStatusListener(_setStatus);
    animController.forward();
  }

  void _setEmptyState() {
    setState(() {});
  }

  void _setStatus(status) {
    setState(() {
      rollStatus = status;
    });
  }

  @override
  void dispose() {
    super.dispose();
    animController.dispose();
    yAnim.removeListener(_setEmptyState);
    yAnim.removeStatusListener(_setStatus);
  }

  @override
  Widget build(BuildContext context) {
    var bgColor = Colors.black.withOpacity(0.85);
    return Scaffold(
      appBar: AppBar(
        title: Text(rollStatus == AnimationStatus.completed
            ? 'Result: $totalResult'
            : 'Rolling ${flat.length} dice'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: bgColor,
      body: LayoutBuilder(builder: (context, constraints) {
        final maxHeight = MediaQuery.of(context).size.height;

        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: diceSpacing,
                spacing: diceSpacing,
                children: [
                  for (final dice in enumerate(flat))
                    Transform.translate(
                      offset: Offset(
                        0,
                        yAnim.value * maxHeight,
                      ),
                      child: Transform.rotate(
                        angle: degToRad(360 * 3 * rotateAnim.value),
                        child: Stack(
                          children: [
                            DiceIcon.from(
                              dice.value,
                              size: diceSize,
                              color: Colors.white,
                            ),
                            Positioned.fill(
                              child: Opacity(
                                opacity: opacityAnim.value,
                                child: Center(
                                  child: Transform.translate(
                                    offset: DiceUtils.iconCenterOffset(dice.value),
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Material(
                                        type: MaterialType.circle,
                                        color: Colors.black,
                                        child: Center(
                                          child: Text(
                                            results[dice.index].total.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                            textScaleFactor: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: DwColors.success,
        label: const Text('Roll again'),
        icon: const Icon(Icons.refresh),
        onPressed: _reRoll,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  double getTop(int index, int columnCount) {
    return GridPoint.fromIndex(index, columnCount).row * (diceSize + diceSpacing);
  }

  double getLeft(int index, int columnCount) {
    return GridPoint.fromIndex(index, columnCount).col * (diceSize + diceSpacing);
  }

  List<dw.Dice> _applyMods(List<dw.Dice> dice) {
    return dice
        .map(
          (d) => d.needsModifier
              ? d.copyWithModifierValue(
                  charService.current!.rollStats.getStat(d.modifierStat!).modifier,
                )
              : d,
        )
        .toList();
  }

  int get totalResult => results.fold(0, (previousValue, element) => previousValue + element.total);

  List<dw.Dice> get flat => dw.Dice.flatten(dice);

  roll() {
    results = dw.DiceRoll.rollMany(flat);
  }

  _reRoll() {
    animController.reset();
    roll();
    animController.forward();
  }
}

class _AnimSet {
  late final Animation<double> y;
  late final Animation<double> angle;
  late final Animation<double> opacity;
  late final AnimationController controller;

  _AnimSet({
    required TickerProvider vsync,
  }) {
    init(vsync);
  }

  init(TickerProvider vsync) {
    final forwardTween = Tween<double>(begin: 0, end: 1);
    final reverseTween = Tween<double>(begin: 1, end: 0);

    controller = AnimationController(vsync: vsync, duration: const Duration(milliseconds: 2500));
    angle = reverseTween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0, 0.75, curve: Curves.easeOutQuad),
    ));
    y = reverseTween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0, 0.75, curve: Curves.fastOutSlowIn),
    ));
    opacity = forwardTween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.75, 1, curve: Curves.easeOutCubic),
    ));
  }
}
