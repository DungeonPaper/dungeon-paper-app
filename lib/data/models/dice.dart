import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

class Dice {
  Dice({
    required this.amount,
    required this.sides,
    this.modifier,
  });

  final int amount;
  final int sides;
  final int? modifier;

  Dice copyWith({
    int? amount,
    int? sides,
    int? modifier,
  }) =>
      Dice(
        amount: amount ?? this.amount,
        sides: sides ?? this.sides,
        modifier: modifier ?? this.modifier,
      );

  factory Dice.fromRawJson(String str) => Dice.fromJson(json.decode(str));

  String toRawJson() => toJson();

  factory Dice.fromJson(String json) {
    var parts = json.split("d");
    debugPrint("parts: " + parts.toString());
    var amount = int.tryParse(parts[0]);
    int? sides;
    int? modifier;
    if (parts[1].contains(RegExp(r'[-+]'))) {
      var idx = parts[1].indexOf(RegExp(r'[^0-9]'));
      sides = int.tryParse(parts[1].substring(0, idx));
      modifier = int.tryParse(parts[1].substring(idx));
    } else {
      sides = int.tryParse(parts[1]);
    }

    if (sides == null || amount == null) {
      throw Exception("Dice parsing failed");
    }

    return Dice(
      amount: amount,
      sides: sides,
      modifier: modifier,
    );
  }

  @override
  String toString() => "${amount}d$sides$modifierWithSign";

  String toJson() => toString();

  String get modifierWithSign => modifier == null
      ? ""
      : modifier! > 0
          ? "+$modifier"
          : "$modifier";

  DiceResult roll() => DiceResult.roll(this);
}

class DiceResult {
  final Dice dice;
  final List<int> results;

  DiceResult({required this.dice, required this.results});

  static List<DiceResult> rollMany(List<Dice> dice) {
    return dice.map((d) {
      var arr = <int>[];
      for (var i = 0; i < d.amount; i++) {
        arr.add(Random().nextInt(d.sides));
      }
      return DiceResult(dice: d, results: arr);
    }).toList();
  }

  static DiceResult roll(Dice dice) {
    return rollMany([dice])[0];
  }
}
