import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/molecules/dice_roll_box.dart';
import 'package:dungeon_paper/src/molecules/dice_roll_builder.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class RollDiceDialog extends StatefulWidget {
  final Character character;
  final List<Dice> initialDiceList;
  final List<Dice> initialAddingDice;

  const RollDiceDialog({
    Key key,
    this.character,
    this.initialDiceList,
    this.initialAddingDice,
  }) : super(key: key);

  @override
  _RollDiceDialogState createState() => _RollDiceDialogState();
}

class _RollDiceDialogState extends State<RollDiceDialog> {
  List<List<Dice>> diceList;
  DiceListController addingDiceCtrl;
  List<DiceListController> controllers;

  @override
  void initState() {
    diceList = [];
    controllers = [];
    addingDiceCtrl = DiceListController(
        widget.initialAddingDice?.isNotEmpty == true
            ? [...widget.initialAddingDice]
            : [Dice.d6 * 2]);

    if (widget.initialDiceList?.isNotEmpty == true) {
      _addDiceToState(widget.initialDiceList).call();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RollDialogTitle(),
        ValueListenableBuilder(
          valueListenable: addingDiceCtrl,
          builder: (context, dice, child) => DiceRollBuilder(
            key: Key(dice.toString()),
            character: widget.character,
            initialValue: dice,
            onChanged: _add,
          ),
        ),
        Expanded(
          child: buildDiceList(),
        ),
      ],
    );
  }

  SingleChildScrollView buildDiceList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var list in enumerate(reversedControllers)) ...[
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DiceRollBox(
                key: Key('dice-${list.value.hash}'),
                controller: reversedControllers.elementAt(list.index),
                onRemove: () => _removeAt(list.index),
                onEdit: () => _editAt(list.index),
              ),
            ),
          ],
          SizedBox(height: 16),
        ],
      ),
    );
  }

  num reversedIndex(num idx) {
    return diceList.length - idx - 1;
  }

  Iterable<DiceListController> get reversedControllers => controllers.reversed;

  void _add(List<Dice> dice) {
    logger.d('Add dice ${dice.join(', ')}');
    analytics.logEvent(
      name: Events.RollNewDice,
      parameters: {'dice': dice.join(', ')},
    );
    setState(_addDiceToState(dice));
    setState(() {
      addingDiceCtrl.value = [Dice.d6 * 2];
    });
  }

  void Function() _addDiceToState(List<Dice> dice) {
    return () {
      final _ctrl = DiceListController([...dice]);
      controllers.add(_ctrl);
      diceList.add(dice);
    };
  }

  void _removeAt(num idx) {
    idx = reversedIndex(idx);
    logger.d('Remove dice ${diceList[idx].join(', ')}');
    analytics.logEvent(
      name: Events.RemoveDice,
      parameters: {'dice': diceList[idx].join(', ')},
    );
    setState(() {
      diceList.removeAt(idx);
      controllers.removeAt(idx);
    });
  }

  void _editAt(num idx) {
    idx = reversedIndex(idx);
    logger.d('Edit dice ${diceList[idx].join(', ')}');
    analytics.logEvent(
      name: Events.EditDice,
      parameters: {'dice': diceList[idx].join(', ')},
    );
    setState(() {
      addingDiceCtrl.value = List.from(diceList[idx]);
      logger.d('diceList: ${addingDiceCtrl.value}');
    });
  }
}

class RollDialogTitle extends StatelessWidget {
  const RollDialogTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var mq = MediaQuery.of(context);
    return Container(
      height: 52,
      // width: mq.orientation == Orientation.portrait
      //     ? mq.size.width
      //     : mq.size.width / 2,
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
              color: Theme.of(context).canvasColor,
              iconSize: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Text(
                  'Roll Dice',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Theme.of(context).canvasColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showDiceRollDialog({
  Key key,
  @required BuildContext context,
  @required String analyticsSource,
  @required Character character,
  List<Dice> initialAddingDice,
  List<Dice> initialDiceList,
}) {
  logger.d("Open Dice Dialog ${{'screen_name': analyticsSource}}");
  analytics.setCurrentScreen(screenName: ScreenNames.DiceRoll);
  analytics.logEvent(name: Events.OpenDiceDialog, parameters: {
    'screen_name': analyticsSource,
  });
  Navigator.push(
    context,
    PageRouteBuilder(
      opaque: false,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, anim, anim2) => SafeArea(
        child: RollDiceDialog(
          key: key,
          character: character,
          initialAddingDice: initialAddingDice,
          initialDiceList: initialDiceList,
        ),
      ),
      transitionsBuilder: (context, anim, anim2, child) => Opacity(
        opacity: anim.value,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Material(
                color: Colors.black.withOpacity(0.7),
                child: GestureDetector(
                  onTap: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, (anim.value * -50) + 50),
              child: child,
            ),
          ],
        ),
      ),
    ),
  );
}
