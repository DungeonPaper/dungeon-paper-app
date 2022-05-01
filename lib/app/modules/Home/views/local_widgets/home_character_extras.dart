import 'package:dungeon_paper/app/widgets/atoms/background_icon_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/dialogs/character_bio_dialog.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCharacterExtras extends StatelessWidget {
  const HomeCharacterExtras({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        IconButton(
          onPressed: null,
          icon: const SvgIcon(DwIcons.dice_d6_numbered),
          tooltip: S.current.characterRollsTitle,
          // visualDensity: VisualDensity.compact,
        ),
        IconButton(
          onPressed: _openBio,
          icon: const Icon(Icons.library_books),
          tooltip: S.current.characterBioDialogTitle,
          // visualDensity: VisualDensity.compact,
        ),
        IconButton(
          onPressed: null,
          icon: const Icon(Icons.handshake),
          tooltip: S.current.characterBondsDialogTitle,
          // visualDensity: VisualDensity.compact,
        ),
        IconButton(
          onPressed: null,
          icon: const Icon(Icons.personal_injury),
          tooltip: S.current.characterDebilitiesDialogTitle,
          // visualDensity: VisualDensity.compact,
        ),
        BackgroundIconButton(
          onPressed: null,
          icon: const Icon(Icons.groups),
          // TODO update intl - use model when exists
          tooltip: S.current.entity('Campaign'),
          // visualDensity: VisualDensity.compact,
          iconColor: Theme.of(context).colorScheme.onPrimary,
          disabledColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        ),
      ],
    );
  }

  void _openBio() {
    Get.dialog(const CharacterBioDialog());
  }
}
