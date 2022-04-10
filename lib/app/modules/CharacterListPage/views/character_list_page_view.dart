import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/molecules/categorized_list.dart';
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
      body: Obx(
        () => ListView(
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
                        child: InkWell(
                          onTap: () {
                            controller.setCurrent(char.key);
                            Get.offAllNamed(Routes.home);
                          },
                          child: ListTile(
                            leading: CharacterAvatar.circle(character: char, size: 48),
                            title: Text(char.displayName),
                            subtitle: Text(S.current.characterHeaderSubtitle(
                              char.stats.level,
                              char.characterClass.name,
                              S.current.alignment(char.bio.alignment.key),
                            )),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 8),
            SizedBox(
              height: 48,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ElevatedButton.icon(
                  style: ButtonThemes.primaryElevated(context),
                  onPressed: () => Get.toNamed(Routes.createCharacterPage),
                  label: Text(S.current.createCharacterAddButton),
                  icon: const Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
