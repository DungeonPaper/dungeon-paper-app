import 'package:dungeon_paper/core/services/character_service.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../widgets/atoms/character_avatar.dart';
import '../../../widgets/atoms/labeled_icon_button.dart';
import '../../../widgets/atoms/svg_icon.dart';

class HomeCharacterHeaderView extends GetView<CharacterService> {
  const HomeCharacterHeaderView({Key? key}) : super(key: key);

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
              label: S.current.quickIconsItems,
              shadowOffset: const Offset(-2, -2),
            ),
            const SizedBox(height: 16),
            LabeledIconButton(
              onPressed: () => null,
              icon: SvgIcon(DwIcons.scroll_quill),
              label: S.current.quickIconsNote,
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
              label: S.current.quickIconsMoves,
              shadowOffset: const Offset(2, -2),
            ),
            const SizedBox(height: 16),
            LabeledIconButton(
              onPressed: () => null,
              icon: SvgIcon(DwIcons.book_cover),
              label: S.current.quickIconsSpells,
              shadowOffset: const Offset(2, 2),
            ),
          ],
        ),
      ],
    );
  }
}
