import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/character_class.dart';
import '../controllers/char_class_select_controller.dart';

class CharacterClassSelectView extends GetView<CharClassSelectController> {
  const CharacterClassSelectView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  final void Function(bool valid, CharacterClass? cls) onValidate;

  void updateControllers() {
    onValidate(controller.validate(), controller.isValid ? controller.selectedClass.value : null);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // final theme = Theme.of(context);
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
                          color: controller.selectedClass.value?.key == cls.key
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cls.name),
                              if (cls.description.isNotEmpty)
                                Text(
                                  cls.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
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
