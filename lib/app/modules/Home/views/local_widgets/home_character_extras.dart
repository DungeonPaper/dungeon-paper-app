import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/bindings/basic_info_form_binding.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/views/basic_info_form_view.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/bindings/ability_scores_form_binding.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/views/ability_scores_form_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/popup_menu_item_list_tile.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/dialogs/character_bio_dialog.dart';
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
        PopupMenuButton<String>(
          icon: const Icon(Icons.person),
          onSelected: _onCharacterMenuSelect,
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'name_photo',
              child: PopupMenuItemListTile(
                icon: const Icon(Icons.photo),
                label: Text(S.current.basicInformationTitle),
              ),
            ),
            PopupMenuItem<String>(
              value: 'bio',
              child: PopupMenuItemListTile(
                icon: const Icon(Icons.text_snippet),
                label: Text(S.current.characterBioDialogTitle),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () => Get.to(
            () => AbilityScoresFormView(
              onChanged: (abilityScores) => controller
                  .updateCharacter(controller.current!.copyWith(abilityScores: abilityScores)),
            ),
            binding: AbilityScoresFormBinding(abilityScores: controller.current!.abilityScores),
            preventDuplicates: false,
          ),
          icon: const SvgIcon(DwIcons.dice_d6_numbered),
          tooltip: S.current.characterRollsTitle,
          // visualDensity: VisualDensity.compact,
        ),
        IconButton(
          onPressed: null,
          icon: Transform.scale(child: const Icon(Icons.handshake), scaleX: -1),
          tooltip: S.current.characterBondsDialogTitle,
          // visualDensity: VisualDensity.compact,
        ),
        IconButton(
          onPressed: null,
          icon: const Icon(Icons.personal_injury),
          tooltip: S.current.characterDebilitiesDialogTitle,
          // visualDensity: VisualDensity.compact,
        ),
        IconButton(
          onPressed: null,
          icon: const Icon(Icons.groups),
          // TODO update intl - use model when exists
          tooltip: S.current.entity('Campaign'),
          // visualDensity: VisualDensity.compact,
          // iconColor: Theme.of(context).colorScheme.onPrimary,
          // disabledColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        ),
      ],
    );
  }

  void _onCharacterMenuSelect(value) {
    final map = <String, void Function()>{
      'name_photo': _openBasicInfo,
      'bio': _openBio,
    };
    final cb = map[value]!;
    cb.call();
  }

  void _openBasicInfo() {
    Get.to(
      () => BasicInfoFormView(
        onChanged: (name, avatar) => controller.updateCharacter(
          controller.current!.copyWith(displayName: name, avatarUrl: avatar),
        ),
      ),
      binding: BasicInfoFormBinding(
        name: controller.current!.displayName,
        avatarUrl: controller.current!.avatarUrl,
      ),
    );
  }

  void _openBio() {
    Get.dialog(const CharacterBioDialog());
  }
}
