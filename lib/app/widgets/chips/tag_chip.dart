import 'package:dungeon_paper/app/model_utils/tag_utils.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/view_tag_dialog.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:flutter/material.dart';

import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

class TagChip extends StatelessWidget {
  const TagChip({
    Key? key,
    required this.tag,
    this.onPressed,
    this.onDeleted,
    this.icon,
    this.backgroundColor,
    this.visualDensity,
  }) : super(key: key);

  factory TagChip.openDescription({
    Key? key,
    required dw.Tag tag,
    void Function()? onPressed,
    void Function()? onDeleted,
    Widget? icon,
    Color? backgroundColor,
    VisualDensity? visualDensity,
  }) =>
      TagChip(
        key: key,
        tag: tag,
        onDeleted: onDeleted,
        icon: icon,
        backgroundColor: backgroundColor,
        onPressed: () => Get.dialog(
          ViewTagDialog(
            tag: tag,
          ),
        ),
      );

  final dw.Tag tag;
  final void Function()? onPressed;
  final void Function()? onDeleted;
  final Widget? icon;
  final VisualDensity? visualDensity;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    // TODO fix case in data
    final name = toTitleCase(tag.name);

    return PrimaryChip(
      icon: icon != null ? icon! : TagUtils.iconOf(tag),
      label: tag.value != null ? '$name: ${tag.value}' : name,
      visualDensity: visualDensity,
      onDeleted: onDeleted,
      onPressed: onPressed,
      tooltip: tag.description,
    );
  }
}
