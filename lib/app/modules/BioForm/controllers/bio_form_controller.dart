import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/core/utils/enum_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class BioFormController extends ChangeNotifier with CharacterProviderMixin {
  var bioDesc = TextEditingController();
  var looks = TextEditingController();
  var alignmentName = 'good';
  var alignmentValue = TextEditingController();
  var bonds = <TextEditingController>[];
  var dirty = false;

  BioFormController() {
    final BioFormArguments args = Get.arguments;
    final char = args.character ?? this.char;
    bioDesc = TextEditingController(text: char.bio.description);
    looks = TextEditingController(text: char.bio.looks);
    alignmentName = char.bio.alignment.key;
    alignmentValue =
        TextEditingController(text: char.bio.alignment.description);
    bonds = char.sessionMarks
        .map((e) => TextEditingController(text: e.description))
        .toList();
  }


  void save() {
    charProvider.updateCharacter(char.copyWith(
      bio: char.bio.copyWith(
        description: bioDesc.value.text,
        looks: looks.value.text.replaceAll(RegExp('\\s*\n'), '  \n'),
        alignment: char.bio.alignment.copyWith(
          description: alignmentValue.value.text,
          type: getEnumByName(dw.AlignmentType.values, alignmentName),
        ),
      ),
    ));
  }

  void setDirty([String? value]) {
    if (!dirty) {
      dirty = true;
      notifyListeners();
    }
  }
}

class BioFormArguments {
  final Character? character;
  BioFormArguments({required this.character});
}
