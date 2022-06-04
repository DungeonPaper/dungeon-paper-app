import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/core/utils/enum_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class BioFormController extends GetxController with CharacterServiceMixin {
  final bioDesc = TextEditingController().obs;
  final looks = TextEditingController().obs;
  final alignmentName = 'good'.obs;
  final alignmentValue = TextEditingController().obs;
  final bonds = <TextEditingController>[].obs;
  final dirty = false.obs;

  @override
  void onReady() {
    super.onReady();
    final BioFormArguments args = Get.arguments;
    final char = args.character ?? this.char;
    bioDesc.value = TextEditingController(text: char.bio.description);
    looks.value = TextEditingController(text: char.bio.looks);
    alignmentName.value = char.bio.alignment.key;
    alignmentValue.value = TextEditingController(text: char.bio.alignment.description);
    bonds.value = char.sessionMarks.map((e) => TextEditingController(text: e.description)).toList();
  }

  void save() {
    charService.updateCharacter(char.copyWith(
      bio: char.bio.copyWith(
        description: bioDesc.value.text,
        looks: looks.value.text.replaceAll(RegExp('\\s*\n'), '  \n'),
        alignment: char.bio.alignment.copyWith(
          description: alignmentValue.value.text,
          type: getEnumByName(dw.AlignmentType, alignmentName.value),
        ),
      ),
    ));
  }

  void setDirty([String? value]) {
    if (!dirty.value) {
      dirty.value = true;
    }
  }
}

class BioFormArguments {
  final Character? character;
  BioFormArguments({required this.character});
}
