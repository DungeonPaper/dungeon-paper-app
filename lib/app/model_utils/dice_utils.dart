import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DiceUtils {
  static Widget iconOf(dw.Dice? tag) => const SvgIcon(DwIcons.dice_d6);

  static Set<dw.Dice> guessFromString(String str) {
    var basicRollPattern = RegExp(r'\broll([+-][a-z]+)\b', caseSensitive: false);
    var dicePattern = RegExp(r'\b\dd\d\b', caseSensitive: false);
    var found = <dw.Dice>{};
    var basicRollMatches = basicRollPattern.allMatches(str);
    for (var match in basicRollMatches) {
      found.add(dw.Dice.fromJson('2d6' + match.group(1)!.toUpperCase()));
    }
    var diceMatches = dicePattern.allMatches(str);
    for (var match in diceMatches) {
      found.add(dw.Dice.fromJson(match.input.substring(match.start, match.end)));
    }
    return found;
  }
}
