import 'dart:async';
import 'dart:ui';

import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/dice_icon.dart';
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

  static const rollAnimDuration = Duration(milliseconds: 1000);
  static const rollAnimResetDuration = Duration(milliseconds: 500);

  @override
  State<RollDiceView> createState() => _RollDiceViewState();
}

class _RollDiceViewState extends State<RollDiceView> with TickerProviderStateMixin {
  final diceSize = 56.0;
  final diceSpacing = 24.0;
  late AnimationStatus rollStatus;
  late List<List<_AnimSet>> animations;
  late List<dw.Dice> dice;
  late List<dw.Dice> withoutModDice;
  var results = <dw.DiceRoll>[];

  CharacterService get charService => Get.find();
  int get totalResult => results.fold(0, (previousValue, element) => previousValue + element.total);
  List<dw.Dice> get flat => dw.Dice.flatten(dice);

  @override
  void initState() {
    super.initState();
    withoutModDice = widget.dice;
    dice = _applyMods(widget.dice);
    rollStatus = AnimationStatus.dismissed;
    _roll();
    _setupAnimations();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Colors.black.withOpacity(0.85);
    final cardColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black.withOpacity(0.4)
        : Colors.white.withOpacity(0.1);
    final textTheme = Theme.of(context).textTheme;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      // blendMode: BlendMode.darken,
      child: Scaffold(
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final group in enumerate(dice))
                      Padding(
                        padding: group.index != dice.length - 1
                            ? const EdgeInsets.only(bottom: 24)
                            : EdgeInsets.zero,
                        child: Material(
                          color: cardColor.withOpacity(
                              cardColor.opacity * animations[group.index].first.opacity.value),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Opacity(
                                  opacity: animations[group.index].first.opacity.value,
                                  child: Transform.translate(
                                    offset: Offset(
                                      0,
                                      animations[group.index].first.y.value * maxHeight,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total: ${results[group.index].total}',
                                          style: textTheme.headline6!.copyWith(color: Colors.white),
                                        ),
                                        Text(
                                          'Dice: ' +
                                              (withoutModDice[group.index]).toString() +
                                              ' | '
                                                  'Modifier: ' +
                                              (group.value.modifierWithSign.isEmpty
                                                  ? '+0'
                                                  : group.value.modifierWithSign),
                                          style: textTheme.bodyText2!
                                              .copyWith(color: Colors.white.withOpacity(0.75)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  runSpacing: diceSpacing,
                                  spacing: diceSpacing,
                                  children: [
                                    for (final d in enumerate(dw.Dice.flatten([group.value])))
                                      Transform.translate(
                                        offset: Offset(
                                          0,
                                          animations[group.index][d.index].y.value * maxHeight,
                                        ),
                                        child: Transform.rotate(
                                          angle: degToRad(360 *
                                              3 *
                                              animations[group.index][d.index].angle.value),
                                          child: Stack(
                                            children: [
                                              DiceIcon.from(
                                                group.value,
                                                size: diceSize,
                                                color: Colors.white,
                                              ),
                                              Positioned.fill(
                                                child: Opacity(
                                                  opacity: animations[group.index][d.index]
                                                      .opacity
                                                      .value,
                                                  child: Center(
                                                    child: Transform.translate(
                                                      offset:
                                                          DiceUtils.iconCenterOffset(group.value),
                                                      child: SizedBox(
                                                        width: 30,
                                                        height: 30,
                                                        child: Material(
                                                          type: MaterialType.circle,
                                                          color: Colors.black,
                                                          child: Center(
                                                            child: Text(
                                                              results[group.index]
                                                                  .results[d.index]
                                                                  .toString(),
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
                              ],
                            ),
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
      ),
    );
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

  _roll() {
    results = dw.DiceRoll.rollMany(dice);
  }

  _reRoll() async {
    // play back quickly
    await _walkAnimations((animation, groupIndex, animIndex) {
      animation.controller.duration = RollDiceView.rollAnimResetDuration;
      animation.controller.reverse();
    });
    // wait for animation
    await Future.delayed(RollDiceView.rollAnimResetDuration);

    // revert duration change
    await _walkAnimations((animation, groupIndex, animIndex) {
      animation.controller.duration = RollDiceView.rollAnimDuration;
    });

    _roll();
    _runAnimations();
  }

  void _runAnimations() async {
    _walkAnimations((anim, groupIndex, animIndex) async {
      await Future.delayed(Duration(milliseconds: (groupIndex * 30) + (animIndex * 30)));
      anim.controller.forward();
    });
  }

  FutureOr<void> _walkAnimations(
      FutureOr<void> Function(_AnimSet animation, int groupIndex, int animIndex) cb) async {
    for (final group in enumerate(animations)) {
      for (final anim in enumerate(group.value)) {
        await cb(anim.value, group.index, anim.index);
      }
    }
  }

  void _setupAnimations() async {
    animations = List.generate(
      dice.length,
      (index) => List.generate(
        dice[index].amount,
        (index) => _AnimSet(vsync: this),
      ),
    );
    animations.first.first.controller.addListener(_updateAnimStatus);
    animations.last.last.controller.addListener(_updateAnimStatus);
    _runAnimations();
    // animController.forward();
  }

  void _updateAnimStatus() {
    setState(() {
      rollStatus = animations.first.first.controller.status != AnimationStatus.completed ||
              animations.last.last.controller.status != AnimationStatus.completed
          ? AnimationStatus.forward
          : AnimationStatus.completed;
    });
  }

  @override
  void dispose() {
    animations.first.first.controller.removeListener(_updateAnimStatus);
    animations.last.last.controller.removeListener(_updateAnimStatus);
    for (final group in animations) {
      for (final animation in group) {
        animation.dispose();
      }
    }
    super.dispose();
  }
}

class _AnimSet {
  late final AnimationController controller;
  late final Animation<double> y;
  late final Animation<double> angle;
  late final Animation<double> opacity;

  _AnimSet({
    required TickerProvider vsync,
  }) {
    init(vsync);
  }

  init(TickerProvider vsync) {
    final forwardTween = Tween<double>(begin: 0, end: 1);
    final reverseTween = Tween<double>(begin: 1, end: 0);

    controller = AnimationController(vsync: vsync, duration: RollDiceView.rollAnimDuration);
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

  dispose() {
    controller.dispose();
  }
}
