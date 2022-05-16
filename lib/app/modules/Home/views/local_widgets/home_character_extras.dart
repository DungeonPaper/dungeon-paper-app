import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/controllers/ability_scores_form_controller.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/controllers/basic_info_form_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/dialogs/character_bio_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/character_bonds_flags_dialog.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCharacterExtras extends GetView<CharacterService> {
  const HomeCharacterExtras({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        MenuButton<String>(
          icon: const Icon(Icons.person),
          items: [
            MenuEntry(
              id: 'name_photo',
              icon: const Icon(Icons.photo),
              label: Text(S.current.basicInformationTitle),
              onSelect: _openBasicInfo,
            ),
            MenuEntry(
              id: 'bio',
              icon: const Icon(Icons.text_snippet),
              label: Text(S.current.characterBioDialogTitle),
              onSelect: _openBio,
            ),
          ],
        ),
        IconButton(
          onPressed: () => Get.toNamed(
            Routes.abilityScores,
            arguments: AbilityScoresFormArguments(
              abilityScores: controller.current!.abilityScores,
              onChanged: (abilityScores) => controller
                  .updateCharacter(controller.current!.copyWith(abilityScores: abilityScores)),
            ),
            preventDuplicates: false,
          ),
          icon: const SvgIcon(DwIcons.dice_d6_numbered),
          tooltip: S.current.characterRollsTitle,
        ),
        IconButton(
          onPressed: _openBondsFlags,
          icon: Transform.scale(child: const Icon(Icons.handshake), scaleX: -1),
          tooltip: S.current.characterBondsFlagsDialogTitle,
        ),
        IconButton(
          onPressed: null,
          icon: const Icon(Icons.personal_injury),
          tooltip: S.current.characterDebilitiesDialogTitle,
        ),
        IconButton(
          onPressed: null,
          icon: const Icon(Icons.groups),
          // TODO update intl - use model when exists
          tooltip: S.current.entity('Campaign'),
        ),
      ],
    );
  }

  void _openBasicInfo() {
    Get.toNamed(
      Routes.basicInfo,
      arguments: BasicInfoFormArguments(
        onChanged: (name, avatar) => controller.updateCharacter(
          controller.current!.copyWith(displayName: name, avatarUrl: avatar),
        ),
        name: controller.current!.displayName,
        avatarUrl: controller.current!.avatarUrl,
      ),
    );
  }

  void _openBio() {
    Get.dialog(const CharacterBioDialog());
  }

  void _openBondsFlags() {
    Get.dialog(const CharacterBondsFlagsDialog());
  }
}
