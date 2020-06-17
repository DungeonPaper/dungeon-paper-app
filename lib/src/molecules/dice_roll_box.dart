import 'dart:math';

import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/molecules/dice_icon_list.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class DiceRollBox extends StatefulWidget {
  final List<Dice> diceList;
  final DiceListController controller;
  final bool animated;
  final void Function() onRemove;

  const DiceRollBox({
    Key key,
    @required this.diceList,
    @required this.controller,
    this.animated = true,
    this.onRemove,
  })  : assert(controller != null),
        assert(diceList != null && (diceList?.length ?? 0) > 0),
        super(key: key);

  @override
  _DiceRollBoxState createState() => _DiceRollBoxState();
}

class _DiceRollBoxState extends State<DiceRollBox>
    with TickerProviderStateMixin {
  List<Animation<double>> animations = [];
  List<AnimationController> animationControllers = [];

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
        for (var ctrl in animationControllers) {
          ctrl.value = 1;
        }
      }
    }
  }

  @override
  void dispose() {
    for (var ctrl in animationControllers) {
      ctrl.dispose();
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
                    onPressed: () => widget.controller.roll(),
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
          ],
        ),
      ),
    );
  }

  List<Dice> get flatDice => widget.diceList.fold(
        <Dice>[],
        (list, dice) =>
            list +
            List.generate(
              dice.amount,
              (index) => Dice(dice.sides),
            ),
      );

  List<DiceController> get flatDiceControllers =>
      enumerate(widget.diceList).fold(
        <DiceController>[],
        (list, dice) =>
            list +
            List.generate(
              dice.value.amount,
              (index) => DiceController(
                  dice.value,
                  widget.controller?.results != null &&
                          widget.controller.results.length > dice.index
                      ? widget.controller.results[dice.index]
                      : null),
            ),
      );

  void _animate() {
    for (var cont in animationControllers) {
      if (widget.animated) {
        cont.reset();
        cont.forward();
      } else {
        cont.value = 1;
      }
    }
  }

  void _initAnimations() {
    var _flat = flatDice;
    animationControllers = List.generate(
      _flat.length,
      (idx) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: Random().nextInt(10) * 200 + 2000),
      ),
    );
    animations = List.generate(
      _flat.length,
      (idx) => CurvedAnimation(
        parent: animationControllers[idx],
        curve: Curves.easeOutQuint,
      ),
    );
  }
}
