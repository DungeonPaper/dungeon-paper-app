import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
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

class HomeCharacterExtras extends StatelessWidget with CharacterProviderMixin {
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
              onSelect: () => _openBasicInfo(context),
            ),
            MenuEntry(
              value: 'ability_scores',
              icon: const Icon(Icons.format_list_numbered_rtl),
              label: Text(tr.home.menu.character.abilityScores),
              onSelect: () => _openAbilityScores(context),
            ),
            MenuEntry(
              value: 'class',
              icon: Icon(CharacterClass.genericIcon),
              label:
                  Text(tr.generic.changeEntity(tr.entity(tn(CharacterClass)))),
              onSelect: () => _openCharClass(context),
            ),
            MenuEntry(
              value: 'race',
              icon: Icon(Race.genericIcon),
              label: Text(tr.generic.changeEntity(tr.entity(tn(Race)))),
              onSelect: () => _openRace(context),
            ),
            MenuEntry(
              value: 'roll_buttons',
              icon: const Icon(DwIcons.dice_d6),
              label: Text(tr.home.menu.character.customRolls),
              onSelect: () => _openRollButtons(context),
            ),
            MenuEntry(
              value: 'theme',
              icon: const Icon(Icons.brush),
              label: Text(tr.home.menu.character.theme),
              onSelect: () => _openThemeSelect(context),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.text_snippet),
          tooltip: tr.home.menu.bio,
          onPressed: () => _openBio(context),
        ),
        CharacterProvider.consumer(
          (context, controller, _) => IconButton(
            onPressed: () => _openBondsFlags(context),
            icon:
                Transform.scale(scaleX: -1, child: const Icon(Icons.handshake)),
            tooltip: SessionMark.categoryTitle(
              bonds: controller.maybeCurrent?.bonds ?? [],
              flags: controller.maybeCurrent?.flags ?? [],
            ),
          ),
        ),
        IconButton(
          onPressed: () => _openDebilities(context),
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

  void _openAbilityScores(BuildContext context) {
    Navigator.of(context).pushNamed(
      Routes.abilityScores,
      arguments: AbilityScoresFormArguments(
        abilityScores: charProvider.current.abilityScores,
        onChanged: (abilityScores) => charProvider.updateCharacter(
            charProvider.current.copyWith(abilityScores: abilityScores)),
      ),
    );
  }

  void _openBasicInfo(BuildContext context) {
    Navigator.of(context).pushNamed(
      Routes.basicInfo,
      arguments: BasicInfoFormArguments(
        onChanged: (name, avatar) => charProvider.updateCharacter(
          charProvider.current.copyWith(displayName: name, avatarUrl: avatar),
        ),
        name: charProvider.current.displayName,
        avatarUrl: charProvider.current.avatarUrl,
      ),
    );
  }

  void _openBio(BuildContext context) {
    showDialog(context: context, builder: (_) => const CharacterBioDialog());
  }

  void _openRace(BuildContext context) {
    ModelPages.openRacesList(
      context,
      character: charProvider.current,
      preSelection: charProvider.current.race,
      onSelected: (race) => charProvider.updateCharacter(
        charProvider.current.copyWithInherited(
          race: race.copyWithInherited(
              favorite: charProvider.current.race.favorite),
        ),
      ),
    );
  }

  void _openCharClass(BuildContext context) {
    ModelPages.openCharacterClassesList(
      context,
      character: charProvider.current,
      onSelected: (cls) => charProvider.updateCharacter(
        // TODO add a reset dialog to confirm + ask what to reset: moves, spells, alignment, rac
        charProvider.current.copyWithInherited(
          characterClass: cls,
        ),
      ),
    );
  }

  void _openBondsFlags(BuildContext context) {
    showDialog(
        context: context, builder: (_) => const CharacterBondsFlagsDialog());
  }

  void _openDebilities(BuildContext context) {
    showDialog(
        context: context, builder: (_) => const CharacterDebilitiesDialog());
  }

  void _openRollButtons(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CustomRollButtonsDialog(
        character: charProvider.current,
        onChanged: (rollButtons) => charProvider.updateCharacter(
          charProvider.current.copyWith(
            settings: charProvider.current.settings
                .copyWith(rollButtons: rollButtons),
          ),
        ),
      ),
    );
  }

  void _openThemeSelect(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.selectCharacterTheme);
  }
}

