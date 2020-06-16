import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/dw_data.dart'
    show DiceResult; // TODO: remove
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DiceController extends ValueNotifier<Dice> {
  DiceResult result;
  bool isRolled;

  DiceController(Dice value, [this.result]) : super(value);

  Dice get dice => value;

  @override
  set value(Dice newValue) {
    result = null;
    isRolled = false;
    super.value = newValue;
  }

  void roll() {
    result = dice.getRoll();
    isRolled = true;
    notifyListeners();
  }
}

class DiceListController extends ValueNotifier<List<Dice>> {
  List<DiceResult> results;
  String hash;
  bool isRolled = false;

  DiceListController(List<Dice> value, [this.results = const <DiceResult>[]])
      : hash = Uuid().v4(),
        super(value);

  @override
  set value(List<Dice> newValue) {
    results = null;
    super.value = newValue;
  }

  operator []=(int idx, dynamic value) {
    super.value[idx] = value;
    notifyListeners();
  }

  void add(Dice value) {
    results = null;
    isRolled = false;
    super.value.add(value);
    notifyListeners();
  }

  void remove(Dice value) {
    results = null;
    isRolled = false;
    super.value.remove(value);
    notifyListeners();
  }

  void removeAt(int index) {
    results = null;
    isRolled = false;
    super.value.removeAt(index);
    notifyListeners();
  }

  void roll() {
    results = value.fold([], (a, b) => a + [b.getRoll()]);
    isRolled = true;
    notifyListeners();
  }

  List<Dice> get flat => value.fold(
        <Dice>[],
        (list, dice) =>
            list +
            List.generate(
              dice.amount,
              (index) => Dice(dice.sides),
            ),
      );

  List<DiceResult> get flatResults => enumerate(results).fold(
        <DiceResult>[],
        (list, result) =>
            list +
            List.generate(
              result.value.results.length,
              (index) => result.value,
            ),
      );
}
