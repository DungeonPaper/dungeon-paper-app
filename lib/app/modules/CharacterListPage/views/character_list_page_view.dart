import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../data/models/character.dart';
import '../controllers/character_list_page_controller.dart';

class CharacterListPageView extends GetView<CharacterListPageController> {
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
            for (var char in controller.characters)
              Card(
                child: Text(char.toRawJson()),
              ),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.createCharacterPage),
              child: Text(S.current.createCharacterAddButton),
            ),
            ElevatedButton(
              onPressed: () => controller.addCharacter(Character.empty()),
              child: Text(S.current.createCharacterAddButton),
            ),
          ],
        ),
      ),
    );
  }
}
