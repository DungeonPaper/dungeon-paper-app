import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

class DiceUtils {
  static Widget iconOf(dw.Dice? tag) => const SvgIcon(DwIcons.dice_d6);

  static Set<dw.Dice> guessFromString(String str) {
    final basicRollPattern = RegExp(r'\broll([+-][a-z0-9]+)\b', caseSensitive: false);
    final dicePattern = RegExp(r'\b\d+d\d+([+-][a-z0-9]+)?\b', caseSensitive: false);
    final found = <dw.Dice>{};
    final basicRollMatches = basicRollPattern.allMatches(str);
    for (final match in basicRollMatches) {
      found.add(dw.Dice.fromJson('2d6' + match.group(1)!.toUpperCase()));
    }
    final diceMatches = dicePattern.allMatches(str);
    for (final match in diceMatches) {
      found.add(dw.Dice.fromJson(match.input.substring(match.start, match.end)));
    }
    return found;
  }
}
