import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
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
              value: 'race',
              icon: Icon(Race.genericIcon),
              label: Text(S.current.changeGeneric(S.current.entity(Race))),
              onSelect: _openRace,
            ),
            MenuEntry(
              value: 'roll_buttons',
              icon: const Icon(DwIcons.dice_d6),
              label: Text(S.current.customRollButtons),
              onSelect: _openRollButtons,
            ),
            MenuEntry(
              value: 'theme',
              icon: const Icon(Icons.brush),
              label: Text(S.current.characterSelectTheme),
              onSelect: _openThemeSelect,
            ),
          ],
        ),
        IconButton(
          onPressed: () => Get.toNamed(
            Routes.abilityScores,
            arguments: AbilityScoresFormArguments(
              abilityScores: controller.current.abilityScores,
              onChanged: (abilityScores) => controller
                  .updateCharacter(controller.current.copyWith(abilityScores: abilityScores)),
            ),
            preventDuplicates: false,
          ),
          icon: const Icon(Icons.format_list_numbered_rtl),
          tooltip: S.current.characterRollsTitle,
        ),
        Obx(
          () => IconButton(
            onPressed: _openBondsFlags,
            icon: Transform.scale(child: const Icon(Icons.handshake), scaleX: -1),
            tooltip: SessionMark.categoryTitle(
              bonds: controller.maybeCurrent?.bonds ?? [],
              flags: controller.maybeCurrent?.flags ?? [],
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
          tooltip: S.current.entity(S.current.entityPlural(Campaign)),
        ),
      ],
    );
  }

  void _openBasicInfo() {
    Get.toNamed(
      Routes.basicInfo,
      arguments: BasicInfoFormArguments(
        onChanged: (name, avatar) => controller.updateCharacter(
          controller.current.copyWith(displayName: name, avatarUrl: avatar),
        ),
        name: controller.current.displayName,
        avatarUrl: controller.current.avatarUrl,
      ),
    );
  }

  void _openBio() {
    Get.dialog(const CharacterBioDialog());
  }

  void _openRace() {
    ModelPages.openRacesList(
      character: controller.current,
      preSelections: [controller.current.race],
      onAdd: (_race) => controller.updateCharacter(
        controller.current.copyWithInherited(
          race: _race.first.copyWithInherited(favorite: controller.current.race.favorite),
        ),
      ),
    );
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
        character: controller.current,
        onChanged: (rollButtons) => controller.updateCharacter(
          controller.current.copyWith(
            settings: controller.current.settings.copyWith(rollButtons: rollButtons),
          ),
        ),
      ),
    );
  }

  void _openThemeSelect() {
    Get.toNamed(Routes.selectCharacterTheme);
  }
}
