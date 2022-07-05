import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/app/widgets/molecules/categorized_list.dart';
import 'package:dungeon_paper/app/widgets/molecules/character_subtitle.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';

class CharacterListPageView extends GetView<CharacterService> {
  const CharacterListPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.characterListTitle),
        centerTitle: true,
      ),
      floatingActionButton: AdvancedFloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.createCharacter),
        label: Text(S.current.createCharacterAddButton),
        icon: const Icon(Icons.add),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.only(bottom: 12),
          children: [
            for (final cat in controller.charsByCategory.keys)
              CategorizedList(
                title: Text(cat.isNotEmpty ? cat : S.current.characterNoCategory),
                onReorder: (oldIndex, newIndex) => controller.updateAll(
                  CharacterUtils.reorderCharacters(controller.charsByCategory[cat]!)
                      .call(oldIndex, newIndex),
                ),
                children: [
                  for (var char in controller.charsByCategory[cat]!)
                    Padding(
                      key: Key(char.key),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: ListTileTheme.merge(
                          minLeadingWidth: 48,
                          minVerticalPadding: 8,
                          horizontalTitleGap: 10,
                          child: InkWell(
                            borderRadius: borderRadius,
                            splashColor: Theme.of(context).splashColor,
                            onTap: () {
                              controller.setCurrent(char.key);
                              Get.offAllNamed(Routes.home);
                            },
                            child: ListTile(
                              leading: CharacterAvatar.squircle(character: char, size: 48),
                              title: Text(char.displayName),
                              subtitle: CharacterSubtitle(
                                character: char,
                                textAlign: TextAlign.start,
                              ),
                              trailing: EntityEditMenu(
                                onEdit: null,
                                onDelete: () => awaitDeleteConfirmation<Character>(
                                  context,
                                  char.displayName,
                                  () => controller.deleteCharacter(char),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
