import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/modules/HPDialog/bindings/hp_dialog_binding.dart';
import 'package:dungeon_paper/app/modules/HPDialog/views/hp_dialog_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/exp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeCharacterHpExpView extends GetView<CharacterService> {
  const HomeCharacterHpExpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: HpBar(),
            ),
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              HPDialogBinding().dependencies();
              Get.dialog(const HPDialogView());
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: ExpBar(),
            ),
            borderRadius: BorderRadius.circular(10),
            onTap: () => null,
          ),
        ),
      ],
    );
  }
}
