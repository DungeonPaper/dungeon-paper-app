import 'dart:math';
import 'package:dungeon_paper/src/atoms/dice_icon.dart';
import 'package:dungeon_paper/src/atoms/dice_selector.dart';
import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/dw_data.dart' show DiceResult;
import 'package:flutter/material.dart';

class RollDiceDialog extends StatefulWidget {
  @override
  _RollDiceDialogState createState() => _RollDiceDialogState();
}

class _RollDiceDialogState extends State<RollDiceDialog> {
  DiceController addingController;
  final List<Dice> diceList = [];
  final List<DiceController> controllers = [];

  @override
  void initState() {
    addingController = DiceController(Dice.d20);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Roll Dice'),
      children: [
        SizedBox(height: 16),
        for (var dice in enumerate(diceList))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: DiceRollerRow(
              key: PageStorageKey('dice-${dice.value}'),
              dice: dice.value,
              controller: controllers[dice.index],
              onRemove: () => _removeAt(dice.index),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            color: Theme.of(context).canvasColor,
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: DiceIconList(
                    dice: addingController.value,
                    controller: addingController,
                    animated: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DiceSelector(
                        dice: addingController.value,
                        textStyle: TextStyle(fontSize: 20),
                        onChanged: _set,
                      ),
                      IconButton(
                        color: Theme.of(context).primaryColor,
                        icon: Icon(Icons.check),
                        onPressed: () => _add(addingController.value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        StandardDialogControls(
          okText: Text('Done'),
          onOK: () => Navigator.pop(context),
        ),
      ],
    );
  }

  _add(Dice dice) {
    setState(() {
      controllers.add(DiceController(dice)..roll());
      diceList.add(dice);
      addingController.value = Dice(dice.sides);
    });
  }

  _set(Dice dice) {
    setState(() {
      addingController.value = dice;
    });
  }

  _removeAt(num idx) {
    setState(() {
      diceList.removeAt(idx);
      controllers.removeAt(idx);
    });
  }
}

class DiceRollerRow extends StatelessWidget {
  final Dice dice;
  final DiceController controller;
  final void Function() onRemove;

  const DiceRollerRow({
    Key key,
    @required this.dice,
    @required this.controller,
    this.onRemove,
  }) : super(key: key);

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
                  ValueListenableBuilder<Dice>(
                    valueListenable: controller,
                    builder: (context, dice, child) => Text(
                      'Result: ${controller.result.results.reduce((a, b) => a + b)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(child: Container()),
                  if (onRemove != null)
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: onRemove,
                    ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () => controller.roll(),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<Dice>(
              valueListenable: controller,
              builder: (context, dice, child) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DiceIconList(
                  dice: dice,
                  controller: controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiceController extends ValueNotifier<Dice> {
  DiceResult result;

  DiceController(Dice value) : super(value);

  Dice get dice => value;

  @override
  set value(Dice newValue) {
    result = null;
    super.value = newValue;
  }

  roll() {
    result = dice.getRoll();
    notifyListeners();
  }
}

class DiceIconList extends StatefulWidget {
  final Dice dice;
  final double iconSize;
  final DiceController controller;
  final bool animated;

  const DiceIconList({
    Key key,
    @required this.dice,
    @required this.controller,
    this.iconSize = 50,
    this.animated = true,
  }) : super(key: key);

  @override
  _DiceIconListState createState() => _DiceIconListState();
}

class _DiceIconListState extends State<DiceIconList>
    with TickerProviderStateMixin {
  List<Animation<double>> animations;
  List<AnimationController> animationControllers;

  @override
  void initState() {
    _animate();
    if (widget.controller != null) {
      widget.controller.addListener(_reanimate);
    }
    super.initState();
  }

  _reanimate() {
    print('listener');
    // if (mounted == true) {
    setState(_animate);
    // } else {
    //   _animate();
    // }
  }

  _animate() {
    animationControllers = List.generate(
      widget.controller.value.amount,
      (idx) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: Random().nextInt(10) * 200 + 2000),
      ),
    );
    animations = List.generate(
      widget.controller.value.amount,
      (idx) => CurvedAnimation(
        parent: animationControllers[idx],
        curve: Curves.easeOutQuint,
      ),
    );

    for (var cont in animationControllers) {
      if (widget.animated) {
        cont.reset();
        cont.forward();
      } else {
        cont.value = 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var dice in enumerate(List.generate(
            widget.dice.amount, (index) => Dice(widget.dice.sides))))
          Padding(
            padding: EdgeInsets.all(8),
            child: DiceValue(
              animation: animations[dice.index],
              dice: dice,
              controller: widget.controller,
              size: widget.iconSize,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    for (var cont in animationControllers) {
      cont.dispose();
    }
    if (widget.controller != null) {
      widget.controller.removeListener(_reanimate);
    }
    super.dispose();
  }
}

class DiceValue extends StatelessWidget {
  const DiceValue({
    Key key,
    @required this.animation,
    @required this.dice,
    @required this.controller,
    @required this.size,
  }) : super(key: key);

  final Animation<double> animation;
  final Enumeration<Dice> dice;
  final DiceController controller;
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
                  controller?.result != null
                      ? controller.result.results[dice.index] == 1
                          ? Colors.red
                          : controller.result.results[dice.index] ==
                                  dice.value.sides
                              ? Colors.green
                              : Colors.grey
                      : Colors.black,
                  animation.value,
                ),
              ),
            ),
            child: null,
          ),
          if (controller?.result != null) ...[
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
                controller.result.results[dice.index].toString(),
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
                controller.result.results[dice.index].toString(),
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
