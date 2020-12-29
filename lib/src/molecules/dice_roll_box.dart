import 'dart:math';
import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/molecules/dice_icon_list.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiceRollBox extends StatefulWidget {
  final DiceListController controller;
  final String analyticsSource;
  final bool animated;
  final void Function() onRemove;
  final void Function() onEdit;

  DiceRollBox({
    Key key,
    @required this.analyticsSource,
    @required this.controller,
    this.animated = true,
    this.onRemove,
    this.onEdit,
  })  : assert(controller != null),
        assert(controller.value != null && (controller.value?.length ?? 0) > 0),
        super(key: key);

  @override
  _DiceRollBoxState createState() => _DiceRollBoxState();
}

class _DiceRollBoxState extends State<DiceRollBox>
    with TickerProviderStateMixin {
  List<List<Animation<double>>> animations = [];
  List<List<AnimationController>> animationControllers = [];

  @override
  void initState() {
    super.initState();

    analytics.logEvent(
      name: Events.RollNewDice,
      parameters: {
        'dice': widget.controller.value.join(', '),
        'screen_name': widget.analyticsSource,
      },
    );

    if (widget.animated) {
      _initAnimations();
    }
    if (widget.controller != null) {
      if (widget.animated) {
        widget.controller.addListener(_animate);
      }
      if (!widget.controller.isRolled) {
        widget.controller.roll();
      } else if (widget.animated) {
        for (var group in animationControllers) {
          for (var ctrl in group) {
            ctrl.value = 1;
          }
        }
      }
    }
  }

  @override
  void dispose() {
    for (var group in animationControllers) {
      for (var ctrl in group) {
        ctrl.dispose();
      }
    }
    widget.controller?.removeListener(_animate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Get.theme.canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              color: Get.theme.colorScheme.secondary,
            ),
            padding: EdgeInsets.only(left: 16),
            child: DefaultTextStyle(
              style: TextStyle(
                color: Get.theme.colorScheme.onSecondary,
              ),
              child: IconTheme.merge(
                data: IconThemeData(
                  color: Get.theme.colorScheme.onSecondary,
                ),
                child: Row(
                  children: [
                    ValueListenableBuilder<List<Dice>>(
                      valueListenable: widget.controller,
                      builder: (context, dice, child) {
                        var total = widget.controller.results
                            .fold<int>(0, (_total, cur) => _total + cur.total);
                        return Text(
                          'Total: $total',
                          textScaleFactor: 1.2,
                        );
                      },
                    ),
                    Expanded(child: Container()),
                    if (widget.onRemove != null)
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: widget.onRemove,
                        visualDensity: VisualDensity.compact,
                        tooltip: 'Remove Dice',
                      ),
                    if (widget.onEdit != null)
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: widget.onEdit,
                        visualDensity: VisualDensity.compact,
                        tooltip: 'Edit Dice',
                      ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: _reroll,
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Roll Again',
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          ValueListenableBuilder<List<Dice>>(
            valueListenable: widget.controller,
            builder: (context, dice, child) {
              var total = widget.controller.results
                  .fold<int>(0, (_total, cur) => _total + cur.total);
              var totalModifiers = widget.controller.results
                  .fold<int>(0, (_total, cur) => _total + cur.dice.modifier);
              var totalWithoutModifiers = total - totalModifiers;
              return Text(
                '${widget.controller.value.join(', ')}\nWITHOUT MOD.: $totalWithoutModifiers | MOD. TOTAL: $totalModifiers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Get.theme.colorScheme.onSurface.withOpacity(0.4),
                ),
              );
            },
          ),
          ValueListenableBuilder<List<Dice>>(
            valueListenable: widget.controller,
            builder: (context, dice, child) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DiceIconList(
                controller: widget.controller,
                animations: animations,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _reroll() {
    logger.d('Reroll ${widget.controller.value.join(', ')}');
    analytics.logEvent(
      name: Events.RerollDice,
      parameters: {
        'dice': widget.controller.value.join(', '),
        'screen_name': widget.analyticsSource,
      },
    );
    widget.controller.roll();
  }

  void _animate() {
    _initAnimations();
    for (var group in animationControllers) {
      for (var ctrl in group) {
        if (widget.animated) {
          ctrl.reset();
          ctrl.forward();
        } else {
          ctrl.value = 1;
        }
      }
    }
  }

  void _initAnimations() {
    animationControllers = List.generate(
      widget.controller.value.length,
      (idx) => List.generate(
        widget.controller.value[idx].amount,
        (innerIdx) => AnimationController(
          vsync: this,
          duration: Duration(milliseconds: Random().nextInt(10) * 300 + 2000),
        ),
      ),
    );
    animations = List.generate(
      widget.controller.value.length,
      (idx) => List.generate(
        widget.controller.value[idx].amount,
        (innerIdx) => CurvedAnimation(
          parent: animationControllers[idx][innerIdx],
          curve: Curves.easeOutQuint,
        ),
      ),
    );
  }
}
