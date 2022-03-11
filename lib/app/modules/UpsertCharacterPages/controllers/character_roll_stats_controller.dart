import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/create_character_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharacterRollStatsController extends GetxController {
  final rollStats = Rx(Get.find<CreateCharacterPageController>().rollStats.value!);
  final textControllers = <String, TextEditingController>{};

  final _isValid = true.obs;
  bool get isValid => _isValid.value;

  bool validate() {
    _isValid.value =
        textControllers.values.every((v) => v.text.isNotEmpty && int.tryParse(v.text) != null);
    if (_isValid.value) {
      rollStats.value = rollStats.value.copyWithStatValues(
        Map.fromEntries(
          textControllers.entries.map(
            (en) => MapEntry(
              en.key,
              int.parse(en.value.text),
            ),
          ),
        ),
      );
    }
    return _isValid.value;
  }

  void _initTextControllers() {
    for (final ctrl in textControllers.values) {
      ctrl.removeListener(validate);
    }
    textControllers.clear();
    for (final stat in rollStats.value.stats) {
      textControllers[stat.key] = TextEditingController(text: stat.value.toString())
        ..addListener(validate);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initTextControllers();
  }
}
