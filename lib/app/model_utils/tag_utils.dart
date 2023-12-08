import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

class TagUtils {
  static List<dw.Tag> excludeMetaTags(Iterable<dw.Tag> tags) => tags
      .where((tag) =>
          !['language', 'source'].contains(tag.name.toLowerCase().trim()))
      .toList();

  static Widget iconOf(dw.Tag tag) => Transform.rotate(
        child: const Icon(Icons.label),
        angle: degToRad(-45.0),
      );
}
