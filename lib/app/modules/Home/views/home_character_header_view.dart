import 'package:dungeon_paper/app/modules/Home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/atoms/character_avatar.dart';
import '../../../widgets/atoms/labeled_icon_button.dart';

class HomeCharacterHeaderView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            LabeledIconButton(
              onPressed: () => null,
              icon: const Icon(Icons.note_add),
              label: "+ Note",
            ),
            const SizedBox(height: 16),
            LabeledIconButton(
              onPressed: () => null,
              icon: const Icon(Icons.note_add),
              label: "+ Note",
            ),
          ],
        ),
        const SizedBox(width: 8),
        CharacterAvatar(),
        const SizedBox(width: 8),
        Column(
          children: [
            LabeledIconButton(
              onPressed: () => null,
              icon: const Icon(Icons.note_add),
              label: "+ Note",
            ),
            const SizedBox(height: 16),
            LabeledIconButton(
              onPressed: () => null,
              icon: const Icon(Icons.note_add),
              label: "+ Note",
            ),
          ],
        ),
      ],
    );
  }
}
