import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
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
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCharacterExtras extends GetView<CharacterService> {
  const HomeCharacterExtras({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        MenuButton<String>(
          icon: const Icon(Icons.person),
          tooltip: tr.home.menu.character.tooltip,
          items: [
            MenuEntry(
              value: 'name_photo',
              icon: const Icon(Icons.photo),
              label: Text(tr.home.menu.character.basicInfo),
              onSelect: _openBasicInfo,
            ),
            MenuEntry(
              value: 'ability_scores',
              icon: const Icon(Icons.format_list_numbered_rtl),
              label: Text(tr.home.menu.character.abilityScores),
              onSelect: _openAbilityScores,
            ),
            MenuEntry(
              value: 'class',
              icon: Icon(CharacterClass.genericIcon),
              label:
                  Text(tr.generic.changeEntity(tr.entity(tn(CharacterClass)))),
              onSelect: _openCharClass,
            ),
            MenuEntry(
              value: 'race',
              icon: Icon(Race.genericIcon),
              label: Text(tr.generic.changeEntity(tr.entity(tn(Race)))),
              onSelect: _openRace,
            ),
            MenuEntry(
              value: 'roll_buttons',
              icon: const Icon(DwIcons.dice_d6),
              label: Text(tr.home.menu.character.customRolls),
              onSelect: _openRollButtons,
            ),
            MenuEntry(
              value: 'theme',
              icon: const Icon(Icons.brush),
              label: Text(tr.home.menu.character.theme),
              onSelect: _openThemeSelect,
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.text_snippet),
          tooltip: tr.home.menu.bio,
          onPressed: _openBio,
        ),
        Obx(
          () => IconButton(
            onPressed: _openBondsFlags,
            icon:
                Transform.scale(scaleX: -1, child: const Icon(Icons.handshake)),
            tooltip: SessionMark.categoryTitle(
              bonds: controller.maybeCurrent?.bonds ?? [],
              flags: controller.maybeCurrent?.flags ?? [],
            ),
          ),
        ),
        IconButton(
          onPressed: _openDebilities,
          icon: const Icon(Icons.personal_injury),
          tooltip: tr.home.menu.debilities,
        ),
        IconButton(
          onPressed: null,
          icon: const Icon(Icons.groups),
          tooltip: tr.entityPlural(tn(Campaign)),
        ),
      ],
    );
  }

  void _openAbilityScores() => Get.toNamed(
        Routes.abilityScores,
        arguments: AbilityScoresFormArguments(
          abilityScores: controller.current.abilityScores,
          onChanged: (abilityScores) => controller.updateCharacter(
              controller.current.copyWith(abilityScores: abilityScores)),
        ),
        preventDuplicates: false,
      );

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
      preSelection: controller.current.race,
      onSelected: (race) => controller.updateCharacter(
        controller.current.copyWithInherited(
          race: race.copyWithInherited(
              favorite: controller.current.race.favorite),
        ),
      ),
    );
  }

  void _openCharClass() {
    ModelPages.openCharacterClassesList(
      character: controller.current,
      onSelected: (cls) => controller.updateCharacter(
        // TODO add a reset dialog to confirm + ask what to reset: moves, spells, alignment, rac
        controller.current.copyWithInherited(
          characterClass: cls,
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
            settings:
                controller.current.settings.copyWith(rollButtons: rollButtons),
          ),
        ),
      ),
    );
  }

  void _openThemeSelect() {
    Get.toNamed(Routes.selectCharacterTheme);
  }
}
