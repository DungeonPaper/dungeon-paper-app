import 'package:dungeon_paper/core/services/character_service.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/atoms/character_avatar.dart';
import '../../../widgets/atoms/labeled_icon_button.dart';
import '../../../widgets/atoms/svg_icon.dart';

class HomeCharacterHeaderView extends GetView<CharacterService> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            LabeledIconButton(
              onPressed: () => null,
              icon: SvgIcon(DwIcons.knapsack),
              label: "Items",
              shadowOffset: const Offset(-2, -2),
            ),
            const SizedBox(height: 16),
            LabeledIconButton(
              onPressed: () => null,
              icon: SvgIcon(DwIcons.scroll_quill),
              label: "+ Note",
              shadowOffset: const Offset(-2, 2),
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
              icon: SvgIcon(DwIcons.hand_rock),
              label: "Moves",
              shadowOffset: const Offset(2, -2),
            ),
            const SizedBox(height: 16),
            LabeledIconButton(
              onPressed: () => null,
              icon: SvgIcon(DwIcons.book_cover),
              label: "Spells",
              shadowOffset: const Offset(2, 2),
            ),
          ],
        ),
      ],
    );
  }
}
