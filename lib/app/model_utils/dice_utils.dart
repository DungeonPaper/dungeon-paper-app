import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DiceUtils {
  static Widget iconOf(dw.Dice? tag) => const SvgIcon(DwIcons.dice_d6);
}
