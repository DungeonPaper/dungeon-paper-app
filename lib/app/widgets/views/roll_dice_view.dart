import 'dart:async';
import 'dart:ui';

import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/dice_icon.dart';
import 'package:dungeon_paper/app/widgets/molecules/dice_list_input.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RollDiceView extends StatefulWidget {
  final List<dw.Dice> dice;

  const RollDiceView({
    super.key,
    required this.dice,
  });

  static const rollAnimDuration = Duration(milliseconds: 1500);
  static const rollAnimResetDuration = Duration(milliseconds: 700);

  @override
  State<RollDiceView> createState() => _RollDiceViewState();
}

class _RollDiceViewState extends State<RollDiceView>
    with TickerProviderStateMixin {
  final diceSize = 56.0;
  final diceSpacing = 24.0;
  late AnimationStatus rollStatus;
  List<List<_AnimSet>> animations = [];
  late ValueNotifier<List<dw.Dice>> dice;
  late ValueNotifier<List<dw.Dice>> withoutModDice;
  late ScrollController scrollController;
  var results = <dw.DiceRoll>[];

  CharacterService get charService => Get.find();
  int get totalResult => results.fold(
      0, (previousValue, element) => previousValue + element.total);
  List<dw.Dice> get flat => dw.Dice.flatten(dice.value);

  @override
  void initState() {
    super.initState();
    withoutModDice = ValueNotifier(widget.dice);
    dice = ValueNotifier(_applyMods(widget.dice));
    rollStatus = AnimationStatus.dismissed;
    scrollController = ScrollController();
    withoutModDice.addListener(_updateDice);
    _roll();
    _setupAnimations();
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Colors.black54;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      // blendMode: BlendMode.darken,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            rollStatus == AnimationStatus.completed
                ? tr.dice.roll.title.rolled(totalResult)
                : tr.dice.roll.title.rolling(flat.length),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        backgroundColor: bgColor,
        body: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16).copyWith(top: 0),
                    child: DiceListInput(
                      controller: withoutModDice,
                      abilityScores: charService.current.abilityScores,
                      guessFrom: const [],
                      labelColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (final group in enumerate(dice.value))
                                _groupBuilder(group),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: AdvancedFloatingActionButton.extended(
          label: Text(tr.dice.roll.action),
          icon: const Icon(Icons.refresh),
          onPressed: _reRoll,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Padding _groupBuilder(Enumerated<dw.Dice> group) {
    final maxHeight = _getMaxHeight(context);
    final cardColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black.withOpacity(0.4)
        : Colors.white.withOpacity(0.1);
    final textTheme = Theme.of(context).textTheme;
    final currentAnimGroup = animations[group.index];
    return Padding(
      padding: group.index != dice.value.length - 1
          ? const EdgeInsets.only(bottom: 24)
          : EdgeInsets.zero,
      child: Material(
        color: cardColor.withOpacity(
            cardColor.opacity * currentAnimGroup.first.opacity.value),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: currentAnimGroup.first.opacity.value,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    currentAnimGroup.first.y.value * maxHeight,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr.dice.roll.total(results.isNotEmpty
                            ? results[group.index].total
                            : 0),
                        style:
                            textTheme.titleLarge!.copyWith(color: Colors.white),
                      ),
                      Text(
                        tr.dice.roll.resultBreakdown(
                          (withoutModDice.value[group.index]).toString(),
                          (group.value.modifierWithSign.isEmpty
                              ? '+0'
                              : group.value.modifierWithSign),
                        ),
                        style: textTheme.bodyMedium!
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
                    Builder(builder: _diceBuilder(group, d)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Function(BuildContext context) _diceBuilder(
    Enumerated<dw.Dice> group,
    Enumerated<dw.Dice> d,
  ) {
    return (context) {
      final maxHeight = _getMaxHeight(context);
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final currentAnim = animations[group.index][d.index];
      final currentResult =
          results.isNotEmpty ? results[group.index].results[d.index] : null;

      final colorScheme = Theme.of(context).colorScheme;
      final textContainerColor = currentResult == group.value.sides
          ? DwColors.success
          : currentResult == 1
              ? isDark
                  ? colorScheme.errorContainer
                  : colorScheme.error
              : Colors.black;
      final resultStr = (currentResult ?? '').toString();
      return Transform.translate(
        offset: Offset(
          0,
          currentAnim.y.value * maxHeight,
        ),
        child: Transform.rotate(
          angle: degToRad(360 * 3 * currentAnim.angle.value),
          child: Stack(
            children: [
              DiceIcon.from(
                group.value,
                size: diceSize,
                color: Colors.white,
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: currentAnim.opacity.value,
                  child: Center(
                    child: Transform.translate(
                      offset: DiceUtils.iconCenterOffset(group.value),
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Material(
                          type: MaterialType.circle,
                          color: textContainerColor,
                          child: Center(
                            child: Text(
                              resultStr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              textScaler: TextScaler.linear(
                                  resultStr.length > 2 ? 1 : 1.5),
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
      );
    };
  }

  double _getMaxHeight(BuildContext context) {
    try {
      return MediaQuery.of(context).size.height +
          (scrollController.hasClients && scrollController.positions.isNotEmpty
              ? scrollController.position.maxScrollExtent
              : 0);
    } catch (e) {
      return 0;
    }
  }

  List<dw.Dice> _applyMods(List<dw.Dice> dice) {
    return dice
        .map(
          (d) => d.needsModifier
              ? d.copyWithModifierValue(
                  charService.current.abilityScores
                      .getStat(d.modifierStat!)
                      .modifier,
                )
              : d,
        )
        .toList();
  }

  _roll() {
    results = dw.DiceRoll.rollMany(dice.value);
  }

  _reRoll() async {
    rollStatus = AnimationStatus.forward;

    if (results.isNotEmpty) {
      // play back quickly
      await _rollBackAnimations();
    }
    _roll();
    _runAnimations();
  }

  Future<void> _rollBackAnimations() async {
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
  }

  void _runAnimations() async {
    _walkAnimations((anim, groupIndex, animIndex) async {
      await Future.delayed(const Duration(milliseconds: 30));
      anim.controller.forward();
    });
  }

  Future<void> _walkAnimations(
    FutureOr<void> Function(_AnimSet animation, int groupIndex, int animIndex)
        cb,
  ) async {
    for (final group in enumerate(animations)) {
      for (final anim in enumerate(group.value)) {
        await cb(anim.value, group.index, anim.index);
      }
    }
  }

  void _walkAnimationsSync(
    void Function(_AnimSet animation, int groupIndex, int animIndex) cb,
  ) {
    for (final group in enumerate(animations)) {
      for (final anim in enumerate(group.value)) {
        cb(anim.value, group.index, anim.index);
      }
    }
  }

  void _setupAnimations([bool start = true]) {
    _walkAnimations(((animation, groupIndex, animIndex) {
      animation.controller.removeListener(_updateAnimStatus);
    }));
    animations = List.generate(
      dice.value.length,
      (index) => List.generate(
        dice.value[index].amount,
        (index) => _AnimSet(vsync: this),
      ),
    );
    rollStatus = AnimationStatus.forward;
    _walkAnimations(
      ((animation, groupIndex, animIndex) =>
          animation.controller.addListener(_updateAnimStatus)),
    );
    if (animations.isNotEmpty && animations.last.isNotEmpty) {
      animations.last.last.controller.addListener(_updateAnimStatus);
      if (start) {
        _runAnimations();
      }
    }
  }

  void _updateAnimStatus() {
    setState(() {
      if (animations.last.last.controller.status == AnimationStatus.completed) {
        rollStatus = AnimationStatus.completed;
      }
    });
  }

  @override
  void dispose() {
    _walkAnimationsSync(((animation, groupIndex, animIndex) {
      // animation.controller.removeListener(_updateAnimStatus);
      animation.dispose();
    }));
    super.dispose();
  }

  void _updateDice() {
    setState(() {
      debugPrint('Updating dice, new value: ${withoutModDice.value}');
      dice.value = _applyMods(withoutModDice.value);
      results = [];
      rollStatus = AnimationStatus.dismissed;
      _setupAnimations(false);
    });
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

    controller = AnimationController(
        vsync: vsync, duration: RollDiceView.rollAnimDuration);
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
