import 'dart:math';
import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/molecules/dice_icon_list.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class DiceRollBox extends StatefulWidget {
  final DiceListController controller;
  final bool animated;
  final void Function() onRemove;

  DiceRollBox({
    Key key,
    @required this.controller,
    this.animated = true,
    this.onRemove,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: Theme.of(context).canvasColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                color: Theme.of(context).primaryColor,
              ),
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  ValueListenableBuilder<List<Dice>>(
                    valueListenable: widget.controller,
                    builder: (context, dice, child) {
                      var total = widget.controller.results
                          .fold<int>(0, (_total, cur) => _total + cur.total);
                      return Text(
                        'Total: $total',
                        style: TextStyle(fontSize: 16),
                      );
                    },
                  ),
                  Expanded(child: Container()),
                  if (widget.onRemove != null)
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: widget.onRemove,
                    ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: _reroll,
                  ),
                ],
              ),
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
            ValueListenableBuilder<List<Dice>>(
              valueListenable: widget.controller,
              builder: (context, dice, child) {
                var total = widget.controller.results
                    .fold<int>(0, (_total, cur) => _total + cur.total);
                var totalModifiers = widget.controller.results
                    .fold<int>(0, (_total, cur) => _total + cur.dice.modifier);
                var totalWithoutModifiers = total - totalModifiers;
                return Text(
                  'WITHOUT MOD.: $totalWithoutModifiers | MOD. TOTAL: $totalModifiers',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.4),
                  ),
                );
              },
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _reroll() {
    logger.d('Reroll ${widget.controller.value.join(', ')}');
    analytics.logEvent(
      name: Events.RerollDice,
      parameters: {'dice': widget.controller.value.join(', ')},
    );
    widget.controller.roll();
  }

  void _animate() {
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
          duration: Duration(milliseconds: Random().nextInt(10) * 200 + 2000),
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
