import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbilityScoreFormController extends GetxController {
  final entity = AbilityScore.empty().obs;

  late final Rx<TextEditingController> _key;
  TextEditingController get key => _key.value;

  late final Rx<TextEditingController> _name;
  TextEditingController get name => _name.value;

  late final Rx<TextEditingController> _description;
  TextEditingController get description => _description.value;

  late final Rx<TextEditingController> _debilityName;
  TextEditingController get debilityName => _debilityName.value;

  late final Rx<TextEditingController> _debilityDescription;
  TextEditingController get debilityDescription => _debilityDescription.value;

  late final Rx<IconData?> _icon;
  IconData? get icon => _icon.value;

  late final void Function(AbilityScore abilityScore) onSave;

  @override
  void onInit() {
    super.onInit();
    final AbilityScoreFormArguments args = Get.arguments;
    if (args.abilityScore != null) {
      entity.value = args.abilityScore!;
    }
    onSave = args.onSave;
    _key.value = TextEditingController(text: entity.value.key)..addListener(_update);
    _name.value = TextEditingController(text: entity.value.name)..addListener(_update);
    _description.value = TextEditingController(text: entity.value.description)
      ..addListener(_update);
    _debilityName.value = TextEditingController(text: entity.value.debilityName)
      ..addListener(_update);
    _debilityDescription.value = TextEditingController(text: entity.value.debilityDescription)
      ..addListener(_update);
    _icon.value = entity.value.icon;
  }

  @override
  void onClose() {
    _key.value.dispose();
    _name.value.dispose();
    _description.value.dispose();
    _debilityName.value.dispose();
    _debilityDescription.value.dispose();
    _icon.close();
    super.onClose();
  }

  void _update() {
    _key.refresh();
    _name.refresh();
    _description.refresh();
    _debilityName.refresh();
    _debilityDescription.refresh();
    _icon.refresh();
  }

  void save() {
    entity.value = entity.value.copyWith(
      key: key.text,
      name: name.text,
      description: description.text,
      debilityName: debilityName.text,
      debilityDescription: debilityDescription.text,
      icon: icon,
    );
    onSave(entity.value);
    Get.back();
  }
}

class AbilityScoreFormArguments {
  final AbilityScore? abilityScore;
  final void Function(AbilityScore abilityScore) onSave;

  AbilityScoreFormArguments({
    required this.abilityScore,
    required this.onSave,
  });
}
