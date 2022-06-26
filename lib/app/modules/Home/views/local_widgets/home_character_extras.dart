import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/controllers/ability_scores_form_controller.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/controllers/basic_info_form_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/app/widgets/dialogs/character_bio_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/character_bonds_flags_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/custom_roll_buttons_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/debilities_dialog.dart';
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
              value: 'name_photo',
              icon: const Icon(Icons.photo),
              label: Text(S.current.basicInformationTitle),
              onSelect: _openBasicInfo,
            ),
            MenuEntry(
              value: 'bio',
              icon: const Icon(Icons.text_snippet),
              label: Text(S.current.characterBioDialogTitle),
              onSelect: _openBio,
            ),
            MenuEntry(
              value: 'roll_buttons',
              icon: const Icon(DwIcons.dice_d6_numbered),
              label: Text(S.current.customRollButtons),
              onSelect: _openRollButtons,
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
          icon: const Icon(DwIcons.dice_d6_numbered),
          tooltip: S.current.characterRollsTitle,
        ),
        Obx(
          () => IconButton(
            onPressed: _openBondsFlags,
            icon: Transform.scale(child: const Icon(Icons.handshake), scaleX: -1),
            tooltip: SessionMark.categoryTitle(
              bonds: controller.current?.bonds ?? [],
              flags: controller.current?.flags ?? [],
            ),
          ),
        ),
        IconButton(
          onPressed: _openDebilities,
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

  void _openDebilities() {
    Get.dialog(const CharacterDebilitiesDialog());
  }

  void _openRollButtons() {
    Get.dialog(
      CustomRollButtonsDialog(
        character: controller.current!,
        onChanged: (rollButtons) => controller.updateCharacter(
          controller.current!.copyWith(
            settings: controller.current!.settings.copyWith(rollButtons: rollButtons),
          ),
        ),
      ),
    );
  }
}
