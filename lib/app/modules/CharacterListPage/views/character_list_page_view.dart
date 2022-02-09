import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_paper/data/models/alignment.dart';
import 'package:dungeon_paper/data/models/character_class.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/models/character.dart';
import '../../../../data/models/dice.dart';
import '../../../../data/models/meta.dart';
import '../../../../generated/l10n.dart';
import '../controllers/character_list_page_controller.dart';

enum Steps {
  summary,
  information,
  charClass,
  stats,
  moves,
  alignment,
  gear,
  review,
}

class CharacterListPageView extends GetView<CharacterListPageController> {
  const CharacterListPageView({Key? key}) : super(key: key);

  int get stepCount => Steps.values.length;
  List<Steps> get steps => Steps.values.toList();

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
              // onPressed: () {
              //   var cls = CharacterClass(
              //     meta: SharedMeta.version(1),
              //     key: uuid(),
              //     name: "",
              //     bonds: [],
              //     damageDice: Dice.fromJson("1d6"),
              //     description: "",
              //     gearChoices: [],
              //     load: 0,
              //     hp: 10,
              //     alignments: AlignmentValues(
              //       neutral: "",
              //       chaotic: "",
              //       evil: "",
              //       good: "",
              //       lawful: "",
              //     ),
              //   );
              //   return controller.addCharacter(
              //     Character.withClass(
              //       characterClass: cls,
              //     ),
              //   );
              // },
              child: Text(S.current.createCharacterAddButton),
            )
          ],
        ),
      ),
    );
  }
}
