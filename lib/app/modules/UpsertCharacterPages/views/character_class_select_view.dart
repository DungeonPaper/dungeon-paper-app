import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/char_info_controller.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/on_init_builder.dart';
import 'package:dungeon_paper/core/request_notifier.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../data/models/character_class.dart';
import '../controllers/char_class_select_controller.dart';

class CharacterClassSelectView extends GetView<CharClassSelectController> {
  const CharacterClassSelectView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  final void Function(bool valid, CharacterClass? cls) onValidate;

  void updateControllers() {
    onValidate(controller.validate(), controller.isValid ? controller.selectedClass : null);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = Theme.of(context);
      return ListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        children: [
          Text('Valid: ${controller.isValid}'),
          ...controller.availableClasses
              .map(
                (cls) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: InkWell(
                    onTap: () {
                      controller.setCharClass(cls);
                      updateControllers();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: controller.selectedClass?.key == cls.key
                              ? DwColors.success
                              : Colors.transparent,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(cls.key + ': ' + cls.name),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      );
    });
  }
}
