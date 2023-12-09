import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/add_tag_dialog.dart';
import 'package:dungeon_paper/app/widgets/molecules/chip_list_input.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

class TagListInput extends StatelessWidget {
  const TagListInput({
    super.key,
    this.controller,
  });

  const TagListInput.builder({
    super.key,
    this.controller,
  });

  final ValueNotifier<List<dw.Tag>>? controller;

  @override
  Widget build(BuildContext context) {
    return ChipListInput<dw.Tag>(
      controller: controller,
      dialogBuilder: (context, tag, {required onSave}) => AddTagDialog(
        tag: tag?.value,
        onSave: onSave,
      ),
      chipBuilder: (context, tag, {onDeleteChip, required onTapChip}) =>
          TagChip(
        tag: tag != null
            ? tag.value
            : dw.Tag(
                name: tr.generic.addEntity(tr.entity(tn(dw.Tag))), value: null),
        icon: tag != null ? null : const Icon(Icons.add),
        onPressed: onTapChip,
        onDeleted: onDeleteChip,
      ),
    );
  }
}
